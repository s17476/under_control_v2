import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../data/models/task/task_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/add_task.dart';
import '../../../domain/usecases/task/cancel_task.dart';
import '../../../domain/usecases/task/delete_task.dart';
import '../../../domain/usecases/task/update_task.dart';

part 'task_management_event.dart';
part 'task_management_state.dart';

@injectable
class TaskManagementBloc
    extends Bloc<TaskManagementEvent, TaskManagementState> {
  final CompanyProfileBloc companyProfileBloc;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;
  final CancelTask cancelTask;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  TaskManagementBloc({
    required this.companyProfileBloc,
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
    required this.cancelTask,
  }) : super(TaskManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
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

    on<DeleteTaskEvent>(
      (event, emit) async {
        emit(TaskManagementLoadingState());
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
  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
