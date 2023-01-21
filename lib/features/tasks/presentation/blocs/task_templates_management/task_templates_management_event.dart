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
  final List<File>? images;
  final File? video;
  const AddTaskTemplateEvent({
    required super.task,
    this.images,
    this.video,
  });
}

class UpdateTaskTemplateEvent extends TaskTemplatesManagementEvent {
  final List<File>? images;
  final File? video;
  const UpdateTaskTemplateEvent({
    required super.task,
    this.images,
    this.video,
  });
}

class DeleteTaskTemplateEvent extends TaskTemplatesManagementEvent {
  const DeleteTaskTemplateEvent({required super.task});
}
