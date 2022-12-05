part of 'task_archive_latest_bloc.dart';

abstract class TaskArchiveLatestEvent extends Equatable {
  final List properties;

  const TaskArchiveLatestEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTasksArchiveLatestStreamEvent extends TaskArchiveLatestEvent {}

class UpdateTasksArchiveLatestListEvent extends TaskArchiveLatestEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateTasksArchiveLatestListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
