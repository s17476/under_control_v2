part of 'task_archive_bloc.dart';

abstract class TaskArchiveState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const TaskArchiveState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskArchiveEmptyState extends TaskArchiveState {}

class TaskArchiveLoadingState extends TaskArchiveState {}

class TaskArchiveErrorState extends TaskArchiveState {
  const TaskArchiveErrorState({
    super.message,
    super.error = true,
  });
}

class TaskArchiveLoadedState extends TaskArchiveState {
  final TasksListModel allTasks;

  TaskArchiveLoadedState({
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
