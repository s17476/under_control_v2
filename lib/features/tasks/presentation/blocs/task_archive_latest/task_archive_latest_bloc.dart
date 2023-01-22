import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/get_archive_latest_tasks_stream.dart';

part 'task_archive_latest_event.dart';
part 'task_archive_latest_state.dart';

@singleton
class TaskArchiveLatestBloc
    extends Bloc<TaskArchiveLatestEvent, TaskArchiveLatestState> {
  final AuthenticationBloc authenticationBloc;
  final FilterBloc filterBloc;
  final GetArchiveLatestTasksStream getArchiveLatestTasksStream;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _taskArchiveStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  TaskArchiveLatestBloc({
    required this.authenticationBloc,
    required this.filterBloc,
    required this.getArchiveLatestTasksStream,
  }) : super(TaskArchiveLatestEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_taskArchiveStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription
                in _taskArchiveStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _taskArchiveStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations = state
                .getAvailableLocations(FeatureType.tasks)
                .map((loc) => loc.id)
                .toList();
          }

          add(GetTasksArchiveLatestStreamEvent());
        }
      },
    );

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _locations = [];
        if (_taskArchiveStreamSubscriptions.isNotEmpty) {
          for (var assetSubscription in _taskArchiveStreamSubscriptions) {
            assetSubscription?.cancel();
          }
          _taskArchiveStreamSubscriptions.clear();
        }
        emit(TaskArchiveLatestEmptyState());
      },
    );

    on<GetTasksArchiveLatestStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          TaskArchiveLatestLoadedState(
            allTasks: const TasksListModel(
              allTasks: [],
            ),
          ),
        );
      } else {
        emit(TaskArchiveLatestLoadingState());
        if (_taskArchiveStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var workRequestSubscription in _taskArchiveStreamSubscriptions) {
            workRequestSubscription?.cancel();
          }
          // clear subscriptions list
          _taskArchiveStreamSubscriptions.clear();
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
          );

          final failureOrTasksStream =
              await getArchiveLatestTasksStream(params);
          await failureOrTasksStream.fold(
            (failure) async =>
                emit(TaskArchiveLatestErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allTasks.listen((snapshot) {
                add(UpdateTasksArchiveLatestListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _taskArchiveStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateTasksArchiveLatestListEvent>((event, emit) async {
      List<Task>? oldTasks;
      // save old tasks if this is not a first chunk
      if (state is TaskArchiveLatestLoadedState) {
        oldTasks = (state as TaskArchiveLatestLoadedState).allTasks.allTasks;
      }
      emit(TaskArchiveLatestLoadingState());
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
        ]..sort((a, b) => b.date.compareTo(a.date));

        workRequestsList = TasksListModel(
          allTasks: tmpList,
        );
      }
      emit(TaskArchiveLatestLoadedState(
        allTasks: workRequestsList,
      ));
    });
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _filterStreamSubscription.cancel();
    if (_taskArchiveStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _taskArchiveStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
