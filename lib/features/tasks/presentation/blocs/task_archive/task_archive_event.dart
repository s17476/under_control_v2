part of 'task_archive_bloc.dart';

abstract class TaskArchiveEvent extends Equatable {
  final List properties;

  const TaskArchiveEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTasksArchiveStreamEvent extends TaskArchiveEvent {
  final bool isAllTasks;

  GetTasksArchiveStreamEvent({
    this.isAllTasks = false,
  }) : super(properties: [isAllTasks]);
}

class ResetEvent extends TaskArchiveEvent {}

class UpdateTasksArchiveListEvent extends TaskArchiveEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;
  final bool isAllTasks;

  UpdateTasksArchiveListEvent({
    required this.snapshot,
    required this.locations,
    required this.isAllTasks,
  }) : super(properties: [snapshot, locations, isAllTasks]);
}
