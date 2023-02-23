import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/get_archive_tasks_stream.dart';

part 'calenddar_task_archive_event.dart';
part 'calenddar_task_archive_state.dart';

@singleton
class CalendarTaskArchiveBloc
    extends Bloc<CalendarTaskArchiveEvent, CalendarTaskArchiveState> {
  final AuthenticationBloc authenticationBloc;
  final FilterBloc filterBloc;
  final GetArchiveTasksStream getArchiveTasksStream;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _workRequestArchiveStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  CalendarTaskArchiveBloc({
    required this.authenticationBloc,
    required this.filterBloc,
    required this.getArchiveTasksStream,
  }) : super(CalendarTaskArchiveEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _filterStreamSubscription = filterBloc.stream.listen(
      (filterState) {
        if (filterState is FilterLoadedState) {
          if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription
                in _workRequestArchiveStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _workRequestArchiveStreamSubscriptions.clear();
          }

          _companyId = filterState.companyId;
          if (filterState.isAdmin && filterState.groups.isEmpty) {
            _locations = filterState.locations.map((loc) => loc.id).toList();
          } else {
            _locations = filterState
                .getAvailableLocations(FeatureType.tasks)
                .map((loc) => loc.id)
                .toList();
          }
          final state = this.state;
          if (state is CalendarTaskArchiveLoadedState) {
            add(GetCalendarTasksArchiveStreamEvent(
                from: state.from, to: state.to));
          } else {
            final now = DateTime.now();
            final from = DateTime(now.year, now.month - 1);
            final to = DateTime(now.year, now.month + 2);
            add(GetCalendarTasksArchiveStreamEvent(from: from, to: to));
          }
        }
      },
    );

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _locations = [];
        if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
          for (var assetSubscription
              in _workRequestArchiveStreamSubscriptions) {
            assetSubscription?.cancel();
          }
          _workRequestArchiveStreamSubscriptions.clear();
        }
        emit(CalendarTaskArchiveEmptyState());
      },
    );

    on<GetCalendarTasksArchiveStreamEvent>((event, emit) async {
      if (_companyId.isEmpty) {
        final filterState = filterBloc.state;
        if (filterState is FilterLoadedState) {
          _companyId = filterState.companyId;
          if (filterState.isAdmin && filterState.groups.isEmpty) {
            _locations = filterState.locations.map((loc) => loc.id).toList();
          } else {
            _locations = filterState
                .getAvailableLocations(FeatureType.tasks)
                .map((loc) => loc.id)
                .toList();
          }
        }
      }
      if (_locations.isEmpty) {
        emit(
          CalendarTaskArchiveLoadedState(
            allTasks: const TasksListModel(
              allTasks: [],
            ),
            from: event.from,
            to: event.to,
          ),
        );
      } else {
        emit(CalendarTaskArchiveLoadingState());
        if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var workRequestSubscription
              in _workRequestArchiveStreamSubscriptions) {
            workRequestSubscription?.cancel();
          }
          // clear subscriptions list
          _workRequestArchiveStreamSubscriptions.clear();
        }

        final List<List<String>> chunkedLocations = [];
        // chunks list size, because of DB limitations
        int chunkSize = 10;
        for (var i = 0; i < _locations.length; i += chunkSize) {
          chunkedLocations.add(
            _locations.sublist(
              i,
              i + chunkSize > _locations.length
                  ? _locations.length
                  : i + chunkSize,
            ),
          );
        }
        for (int j = 0; j < chunkedLocations.length; j++) {
          var chunk = chunkedLocations[j];
          final params = ItemsInLocationsParams(
            locations: chunk,
            companyId: _companyId,
            from: event.from,
            to: event.to,
          );
          final failureOrTasksStream = await getArchiveTasksStream(params);
          await failureOrTasksStream.fold(
            (failure) async => emit(CalendarTaskArchiveErrorState()),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allTasks.listen((snapshot) {
                add(UpdateCalendarTasksArchiveListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                  from: event.from,
                  to: event.to,
                ));
              });
              _workRequestArchiveStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateCalendarTasksArchiveListEvent>((event, emit) async {
      List<Task>? oldTasks;
      // save old tasks if this is not a first chunk
      if (state is CalendarTaskArchiveLoadedState) {
        oldTasks = (state as CalendarTaskArchiveLoadedState).allTasks.allTasks;
      }
      emit(CalendarTaskArchiveLoadingState());
      // gets tasks list
      TasksListModel workRequestsList = TasksListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge tasks list if this is not a first chunk
      if (oldTasks != null) {
        List<Task> workRequestsToRemove = [];
        for (var oldTask in oldTasks) {
          if (event.locations.contains(oldTask.locationId)) {
            workRequestsToRemove.add(oldTask);
          }
        }
        for (var workRequestToRemove in workRequestsToRemove) {
          oldTasks.remove(workRequestToRemove);
        }
        // merge and sort by priority
        List<Task> tmpList = [
          ...oldTasks,
          ...workRequestsList.allTasks,
        ]..sort((a, b) => b.executionDate.compareTo(a.executionDate));

        workRequestsList = TasksListModel(
          allTasks: tmpList,
        );
      }
      emit(CalendarTaskArchiveLoadedState(
        allTasks: workRequestsList,
        from: event.from,
        to: event.to,
      ));
    });
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _filterStreamSubscription.cancel();
    if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _workRequestArchiveStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
