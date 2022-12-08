part of 'task_action_management_bloc.dart';

abstract class TaskActionManagementEvent extends Equatable {
  final TaskAction taskAction;
  final Task task;
  const TaskActionManagementEvent({
    required this.taskAction,
    required this.task,
  });

  @override
  List<Object> get props => [taskAction];
}

class AddTaskActionEvent extends TaskActionManagementEvent {
  final List<File>? images;
  const AddTaskActionEvent({
    required super.taskAction,
    required super.task,
    this.images,
  });
}

class DeleteTaskActionEvent extends TaskActionManagementEvent {
  const DeleteTaskActionEvent({
    required super.taskAction,
    required super.task,
  });
}

class UpdateTaskActionEvent extends TaskActionManagementEvent {
  final List<File>? images;
  const UpdateTaskActionEvent({
    required super.taskAction,
    required super.task,
    this.images,
  });
}
