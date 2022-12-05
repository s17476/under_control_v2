part of 'task_archive_latest_bloc.dart';

abstract class TaskArchiveLatestState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const TaskArchiveLatestState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskArchiveLatestEmptyState extends TaskArchiveLatestState {}

class TaskArchiveLatestLoadingState extends TaskArchiveLatestState {}

class TaskArchiveLatestErrorState extends TaskArchiveLatestState {
  const TaskArchiveLatestErrorState({
    super.message,
    super.error = true,
  });
}

class TaskArchiveLatestLoadedState extends TaskArchiveLatestState {
  final TasksListModel allTasks;

  TaskArchiveLatestLoadedState({
    required this.allTasks,
  }) : super(properties: [allTasks]);

  Task? getTaskById(String id) {
    final index = allTasks.allTasks.indexWhere((asset) => asset.id == id);
    if (index >= 0) {
      return allTasks.allTasks[index];
    }
    return null;
  }
}
