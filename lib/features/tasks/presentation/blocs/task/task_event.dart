part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  final List properties;

  const TaskEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTasksStreamEvent extends TaskEvent {
  final bool isAllTasks;

  GetTasksStreamEvent({required this.isAllTasks})
      : super(properties: [isAllTasks]);
}

class ResetEvent extends TaskEvent {}

class UpdateTasksListEvent extends TaskEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;
  final bool isAllTasks;

  UpdateTasksListEvent({
    required this.snapshot,
    required this.locations,
    required this.isAllTasks,
  }) : super(properties: [snapshot, locations, isAllTasks]);
}
