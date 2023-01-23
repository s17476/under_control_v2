import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../../tasks/data/models/task_action/task_actions_list_model.dart';
import '../../../../tasks/domain/entities/task_action/task_action.dart';
import '../../../domain/usecases/get_latest_task_actions.dart';

part 'task_actions_status_event.dart';
part 'task_actions_status_state.dart';

@singleton
class TaskActionsStatusBloc
    extends Bloc<TaskActionsStatusEvent, TaskActionsStatusState> {
  final AuthenticationBloc authenticationBloc;
  final FilterBloc filterBloc;
  final GetLatestTaskActions getLatestTaskActions;

  late StreamSubscription _filterStreamSubscription;
  late StreamSubscription _authStreamSubscription;
  final List<StreamSubscription?> _taskActionsStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  TaskActionsStatusBloc({
    required this.authenticationBloc,
    required this.filterBloc,
    required this.getLatestTaskActions,
  }) : super(TaskActionsStatusEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          // _clearSubscriptions();
          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations = state
                .getAvailableLocations(FeatureType.tasks)
                .map((loc) => loc.id)
                .toList();
          }

          add(GetTaskActionsStatusEvent());
        }
      },
    );

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _locations = [];
        _clearSubscriptions();
        emit(TaskActionsStatusEmptyState());
      },
    );

    on<GetTaskActionsStatusEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(TaskActionsStatusLoadedState());
      } else {
        emit(TaskActionsStatusLoadingState());
        _clearSubscriptions();

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

          final failureOrTaskActionsStream = await getLatestTaskActions(params);
          await failureOrTaskActionsStream.fold(
            (failure) async =>
                emit(TaskActionsStatusErrorState(message: failure.message)),
            (stream) async {
              final streamSubscription =
                  stream.allTaskActions.listen((snapshot) {
                add(UpdateStatusEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _taskActionsStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateStatusEvent>((event, emit) async {
      List<TaskAction>? oldTaskActions;
      // save old work orders if this is not a first chunk
      if (state is TaskActionsStatusLoadedState) {
        oldTaskActions =
            (state as TaskActionsStatusLoadedState).taskActions.allTaskActions;
      }
      emit(TaskActionsStatusLoadingState());
      // gets work orders list
      TaskActionsListModel taskActionsList = TaskActionsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge work orders list if this is not a first chunk
      if (oldTaskActions != null) {
        List<TaskAction> taskActionsToRemove = [];
        for (var oldTaskAction in oldTaskActions) {
          if (event.locations.contains(oldTaskAction.locationId)) {
            taskActionsToRemove.add(oldTaskAction);
          }
        }
        for (var taskActionToRemove in taskActionsToRemove) {
          oldTaskActions.remove(taskActionToRemove);
        }
        // merge and sort by date
        List<TaskAction> tmpList = [
          ...oldTaskActions,
          ...taskActionsList.allTaskActions,
        ];

        taskActionsList = TaskActionsListModel(
          allTaskActions: tmpList,
        );
      }
      emit(TaskActionsStatusLoadedState(taskActions: taskActionsList));
    });
  }

  void _clearSubscriptions() {
    if (_taskActionsStreamSubscriptions.isNotEmpty) {
      for (var subscription in _taskActionsStreamSubscriptions) {
        subscription?.cancel();
      }
      _taskActionsStreamSubscriptions.clear();
    }
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    _authStreamSubscription.cancel();
    if (_taskActionsStreamSubscriptions.isNotEmpty) {
      for (var subscription in _taskActionsStreamSubscriptions) {
        subscription?.cancel();
      }
    }

    return super.close();
  }
}
