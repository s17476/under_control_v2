import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/get_tasks_stream.dart';

part 'task_event.dart';
part 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FilterBloc filterBloc;
  final GetTasksStream getTasksStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _workRequestStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  TaskBloc({
    required this.filterBloc,
    required this.getTasksStream,
  }) : super(TaskEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_workRequestStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription
                in _workRequestStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _workRequestStreamSubscriptions.clear();
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
          add(GetTasksStreamEvent());
        }
      },
    );

    on<GetTasksStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          TaskLoadedState(
            allTasks: const TasksListModel(
              allTasks: [],
            ),
          ),
        );
      } else {
        emit(TaskLoadingState());
        if (_workRequestStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var workRequestSubscription in _workRequestStreamSubscriptions) {
            workRequestSubscription?.cancel();
          }
          // clear subscriptions list
          _workRequestStreamSubscriptions.clear();
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

          final failureOrTasksStream = await getTasksStream(params);
          await failureOrTasksStream.fold(
            (failure) async => emit(TaskErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allTasks.listen((snapshot) {
                add(UpdateTasksListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _workRequestStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateTasksListEvent>((event, emit) async {
      List<Task>? oldTasks;
      // save old work orders if this is not a first chunk
      if (state is TaskLoadedState) {
        oldTasks = (state as TaskLoadedState).allTasks.allTasks;
      }
      emit(TaskLoadingState());
      // gets work orders list
      TasksListModel workRequestsList = TasksListModel.fromSnapshot(
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
        // merge and sort by priority
        List<Task> tmpList = [
          ...oldTasks,
          ...workRequestsList.allTasks,
        ]..sort((a, b) => a.executionDate.compareTo(b.executionDate));

        workRequestsList = TasksListModel(
          allTasks: tmpList,
        );
      }
      emit(TaskLoadedState(
        allTasks: workRequestsList,
      ));
    });
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_workRequestStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _workRequestStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
