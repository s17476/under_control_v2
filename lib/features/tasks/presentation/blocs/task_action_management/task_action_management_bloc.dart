import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/entities/task_action/task_action.dart';
import '../../../domain/usecases/task_action/add_task_action.dart';
import '../../../domain/usecases/task_action/delete_task_action.dart';
import '../../../domain/usecases/task_action/update_task_action.dart';

part 'task_action_management_event.dart';
part 'task_action_management_state.dart';

@injectable
class TaskActionManagementBloc
    extends Bloc<TaskActionManagementEvent, TaskActionManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddTaskAction addTaskAction;
  final DeleteTaskAction deleteTaskAction;
  final UpdateTaskAction updateTaskAction;

  UserProfile? _userProfile;

  TaskActionManagementBloc({
    required this.userProfileBloc,
    required this.addTaskAction,
    required this.deleteTaskAction,
    required this.updateTaskAction,
  }) : super(TaskActionManagementEmptyState()) {
    on<AddTaskActionEvent>(
      (event, emit) async {
        emit(TaskActionManagementLoadingState());
        _getUser();
        final failureOrString = await addTaskAction(
          TaskActionParams(
            task: event.task,
            taskAction: event.taskAction,
            userProfile: _userProfile!,
            images: event.images,
          ),
        );
        await failureOrString.fold(
          (failure) async => emit(
            TaskActionManagementErrorState(
              message: BlocMessage.notAdded,
            ),
          ),
          (_) async => emit(
            TaskActionManagementSuccessState(
              message: BlocMessage.added,
            ),
          ),
        );
      },
    );

    on<DeleteTaskActionEvent>(
      (event, emit) async {
        emit(TaskActionManagementLoadingState());
        _getUser();
        final failureOrVoidResult = await deleteTaskAction(
          TaskActionParams(
            task: event.task,
            taskAction: event.taskAction,
            userProfile: _userProfile!,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            TaskActionManagementErrorState(
              message: BlocMessage.notDeleted,
            ),
          ),
          (_) async => emit(
            TaskActionManagementSuccessState(
              message: BlocMessage.deleted,
            ),
          ),
        );
      },
    );

    on<UpdateTaskActionEvent>(
      (event, emit) async {
        emit(TaskActionManagementLoadingState());
        _getUser();
        final failureOrVoidResult = await updateTaskAction(
          TaskActionParams(
            task: event.task,
            taskAction: event.taskAction,
            userProfile: _userProfile!,
            images: event.images,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            TaskActionManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            TaskActionManagementSuccessState(
              message: BlocMessage.updated,
            ),
          ),
        );
      },
    );
  }

  void _getUser() {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      _userProfile = userState.userProfile;
    }
  }
}
