import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task_template/add_task_template.dart';
import '../../../domain/usecases/task_template/delete_task_template.dart';
import '../../../domain/usecases/task_template/update_task_template.dart';

part 'task_templates_management_event.dart';
part 'task_templates_management_state.dart';

@injectable
class TaskTemplatesManagementBloc
    extends Bloc<TaskTemplatesManagementEvent, TaskTemplatesManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddTaskTemplate addTaskTemplate;
  final UpdateTaskTemplate updateTaskTemplate;
  final DeleteTaskTemplate deleteTaskTemplate;

  String _companyId = '';

  TaskTemplatesManagementBloc({
    required this.userProfileBloc,
    required this.addTaskTemplate,
    required this.updateTaskTemplate,
    required this.deleteTaskTemplate,
  }) : super(TaskTemplatesManagementEmptyState()) {
    on<AddTaskTemplateEvent>((event, emit) async {
      emit(TaskTemplatesManagementLoadingState());
      _getCompanyId();
      final failureOrString = await addTaskTemplate(
        TaskParams(
          task: event.task,
          companyId: _companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          TaskTemplatesManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          TaskTemplatesManagementSuccessState(
            message: BlocMessage.added,
          ),
        ),
      );
    });

    on<UpdateTaskTemplateEvent>((event, emit) async {
      emit(TaskTemplatesManagementLoadingState());
      _getCompanyId();
      final failureOrVoidResult = await updateTaskTemplate(
        TaskParams(
          task: event.task,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          TaskTemplatesManagementErrorState(
            message: BlocMessage.notUpdated,
          ),
        ),
        (_) async => emit(
          TaskTemplatesManagementSuccessState(
            message: BlocMessage.updated,
          ),
        ),
      );
    });

    on<DeleteTaskTemplateEvent>((event, emit) async {
      emit(TaskTemplatesManagementLoadingState());
      _getCompanyId();
      final failureOrVoidResult = await deleteTaskTemplate(
        TaskParams(
          task: event.task,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          TaskTemplatesManagementErrorState(
            message: BlocMessage.notDeleted,
          ),
        ),
        (_) async => emit(
          TaskTemplatesManagementSuccessState(
            message: BlocMessage.deleted,
          ),
        ),
      );
    });
  }

  void _getCompanyId() {
    if (_companyId.isEmpty) {
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        _companyId = userState.userProfile.companyId;
      }
    }
  }
}
