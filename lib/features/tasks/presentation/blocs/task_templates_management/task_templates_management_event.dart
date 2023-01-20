part of 'task_templates_management_bloc.dart';

abstract class TaskTemplatesManagementEvent extends Equatable {
  final Task task;
  const TaskTemplatesManagementEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class AddTaskTemplateEvent extends TaskTemplatesManagementEvent {
  const AddTaskTemplateEvent({required super.task});
}

class UpdateTaskTemplateEvent extends TaskTemplatesManagementEvent {
  const UpdateTaskTemplateEvent({required super.task});
}

class DeleteTaskTemplateEvent extends TaskTemplatesManagementEvent {
  const DeleteTaskTemplateEvent({required super.task});
}
