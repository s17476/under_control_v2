import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/get_tasks_stream.dart';

part 'calendar_task_event.dart';
part 'calendar_task_state.dart';

@lazySingleton
class CalendarTaskBloc extends Bloc<CalendarTaskEvent, CalendarTaskState> {
  final AuthenticationBloc authenticationBloc;
  final FilterBloc filterBloc;
  final GetTasksStream getTasksStream;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _taskStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  CalendarTaskBloc({
    required this.authenticationBloc,
    required this.filterBloc,
    required this.getTasksStream,
  }) : super(CalendarTaskEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _filterStreamSubscription = filterBloc.stream.listen(
      (filterState) {
        if (filterState is FilterLoadedState) {
          if (_taskStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription in _taskStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _taskStreamSubscriptions.clear();
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
          if (state is CalendarTaskLoadedState) {
            add(GetCalendarTasksStreamEvent(from: state.from, to: state.to));
          } else {
            final now = DateTime.now();
            final from = DateTime(now.year, now.month - 1);
            final to = DateTime(now.year, now.month + 2);
            add(GetCalendarTasksStreamEvent(from: from, to: to));
          }
        }
      },
    );

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _locations.clear();
        if (_taskStreamSubscriptions.isNotEmpty) {
          for (var taskSubscription in _taskStreamSubscriptions) {
            taskSubscription?.cancel();
          }
          _taskStreamSubscriptions.clear();
        }
        emit(CalendarTaskEmptyState());
      },
    );

    on<GetCalendarTasksStreamEvent>(
      transformer: restartable(),
      (event, emit) async {
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
            CalendarTaskLoadedState(
              allTasks: const TasksListModel(
                allTasks: [],
              ),
              from: event.from,
              to: event.to,
            ),
          );
        } else {
          emit(CalendarTaskLoadingState());
          if (_taskStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription in _taskStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _taskStreamSubscriptions.clear();
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

            final failureOrTasksStream = await getTasksStream(params);
            await failureOrTasksStream.fold(
              (failure) async => emit(CalendarTaskErrorState()),
              (assetsStream) async {
                final streamSubscription =
                    assetsStream.allTasks.listen((snapshot) {
                  add(UpdateCalendarTasksListEvent(
                    snapshot: snapshot,
                    locations: chunk,
                    from: event.from,
                    to: event.to,
                  ));
                });
                _taskStreamSubscriptions.add(streamSubscription);
              },
            );
          }
        }
      },
    );

    on<UpdateCalendarTasksListEvent>(
      transformer: restartable(),
      (event, emit) async {
        List<Task>? oldTasks;
        // save old work orders if this is not a first chunk
        if (state is CalendarTaskLoadedState) {
          oldTasks = (state as CalendarTaskLoadedState).allTasks.allTasks;
        }
        emit(CalendarTaskLoadingState());
        // gets work orders list
        TasksListModel tasksList = TasksListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );

        // merge work orders list if this is not a first chunk
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
          // merge and sort by execution's date
          List<Task> tmpList = [
            ...oldTasks,
            ...tasksList.allTasks,
          ]..sort((a, b) => a.executionDate.compareTo(b.executionDate));

          tasksList = TasksListModel(
            allTasks: tmpList,
          );
        }

        emit(CalendarTaskLoadedState(
          allTasks: tasksList,
          from: event.from,
          to: event.to,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _filterStreamSubscription.cancel();
    if (_taskStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _taskStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
