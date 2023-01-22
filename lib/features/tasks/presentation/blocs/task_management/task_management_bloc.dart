import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/task/task_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/add_task.dart';
import '../../../domain/usecases/task/cancel_task.dart';
import '../../../domain/usecases/task/complete_task.dart';
import '../../../domain/usecases/task/delete_task.dart';
import '../../../domain/usecases/task/update_task.dart';

part 'task_management_event.dart';
part 'task_management_state.dart';

@injectable
class TaskManagementBloc
    extends Bloc<TaskManagementEvent, TaskManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;
  final CancelTask cancelTask;
  final CompleteTask completeTask;

  String _companyId = '';

  TaskManagementBloc({
    required this.userProfileBloc,
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
    required this.cancelTask,
    required this.completeTask,
  }) : super(TaskManagementEmptyState()) {
    on<AddTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
        _getCompanyId();
        final failureOrString = await addTask(
          TaskParams(
            task: event.task,
            companyId: _companyId,
            images: event.images,
            video: event.video,
          ),
        );
        await failureOrString.fold(
          (failure) async => emit(
            TaskManagementErrorState(
              message: BlocMessage.notAdded,
            ),
          ),
          (_) async => emit(
            TaskManagementSuccessState(
              message: BlocMessage.added,
            ),
          ),
        );
      },
    );

    on<CompleteTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
        _getCompanyId();
        final failureOrVoidResult = await completeTask(
          TaskParams(
            task: event.task,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            TaskManagementErrorState(
              message: BlocMessage.notCompleted,
            ),
          ),
          (_) async => emit(
            TaskManagementSuccessState(
              message: BlocMessage.completed,
            ),
          ),
        );
      },
    );

    on<DeleteTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
        _getCompanyId();
        final failureOrVoidResult = await deleteTask(
          TaskParams(
            task: event.task,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            TaskManagementErrorState(
              message: BlocMessage.notDeleted,
            ),
          ),
          (_) async => emit(
            TaskManagementSuccessState(
              message: BlocMessage.deleted,
            ),
          ),
        );
      },
    );

    on<CancelTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
        _getCompanyId();
        String updatedDescription = '';
        if (event.task.description.isEmpty) {
          updatedDescription = event.comment;
        } else {
          updatedDescription =
              '${event.comment} \n---\n ${event.task.description}';
        }
        final updatedTask = TaskModel.fromTask(event.task).copyWith(
          description: updatedDescription,
        );
        final failureOrVoidResult = await cancelTask(
          TaskParams(
            task: updatedTask,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            TaskManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            TaskManagementSuccessState(
              message: BlocMessage.updated,
            ),
          ),
        );
      },
    );

    on<UpdateTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
        _getCompanyId();
        final failureOrVoidResult = await updateTask(
          TaskParams(
            task: event.task,
            companyId: _companyId,
            images: event.images,
            video: event.video,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            TaskManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            TaskManagementSuccessState(
              message: BlocMessage.updated,
            ),
          ),
        );
      },
    );
  }
  void _getCompanyId() {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      _companyId = userState.userProfile.companyId;
    }
  }
}
