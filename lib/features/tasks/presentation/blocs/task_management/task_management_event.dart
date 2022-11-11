part of 'task_management_bloc.dart';

abstract class TaskManagementEvent extends Equatable {
  final Task task;
  const TaskManagementEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class AddTaskEvent extends TaskManagementEvent {
  final List<File>? images;
  final File? video;
  const AddTaskEvent({
    required super.task,
    this.images,
    this.video,
  });
}

class DeleteTaskEvent extends TaskManagementEvent {
  const DeleteTaskEvent({required super.task});
}

class CancelTaskEvent extends TaskManagementEvent {
  final String comment;
  const CancelTaskEvent({
    required super.task,
    required this.comment,
  });
}

class UpdateTaskEvent extends TaskManagementEvent {
  final List<File>? images;
  final File? video;
  const UpdateTaskEvent({
    required super.task,
    this.images,
    this.video,
  });
}
