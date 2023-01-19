import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../data/models/task_action/task_actions_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/entities/task_action/task_action.dart';
import '../../../domain/usecases/task_action/get_task_actions_stream.dart';

part 'task_action_event.dart';
part 'task_action_state.dart';

@injectable
class TaskActionBloc extends Bloc<TaskActionEvent, TaskActionState> {
  final GetTaskActionsStream getTaskActionsStream;

  StreamSubscription? streamSubscription;

  TaskActionBloc({
    required this.getTaskActionsStream,
  }) : super(TaskActionEmptyState()) {
    on<GetTaskActionsForTaskStreamEvent>(
      (event, emit) async {
        emit(TaskActionLoadingState());
        final taskParams = TaskParams(
          task: event.task,
          companyId: event.companyId,
        );
        final failureOrTaskActionsStream =
            await getTaskActionsStream(taskParams);
        failureOrTaskActionsStream.fold(
          (failure) async =>
              emit(TaskActionErrorState(message: failure.message)),
          (stream) async {
            streamSubscription = stream.allTaskActions.listen((snapshot) {
              add(
                UpdateTaskActionsListEvent(snapshot: snapshot),
              );
            });
          },
        );
      },
    );

    on<UpdateTaskActionsListEvent>((event, emit) async {
      TaskActionsListModel taskActions = TaskActionsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );
      print('TaskActionBloc - Loaded');
      emit(TaskActionLoadedState(allActions: taskActions));
    });

    on<ResetTaskActionsEvent>(
      (event, emit) {
        streamSubscription?.cancel();
        emit(TaskActionEmptyState());
      },
    );
  }
  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
