part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  final List properties;

  const TaskEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTasksStreamEvent extends TaskEvent {}

class UpdateTasksListEvent extends TaskEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateTasksListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
