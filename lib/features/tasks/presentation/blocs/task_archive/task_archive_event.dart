part of 'task_archive_bloc.dart';

abstract class TaskArchiveEvent extends Equatable {
  final List properties;

  const TaskArchiveEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTasksArchiveStreamEvent extends TaskArchiveEvent {}

class ResetEvent extends TaskArchiveEvent {}

class UpdateTasksArchiveListEvent extends TaskArchiveEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateTasksArchiveListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
