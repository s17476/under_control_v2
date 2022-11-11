part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const TaskState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskEmptyState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskErrorState extends TaskState {
  const TaskErrorState({
    super.message,
    super.error = true,
  });
}

class TaskLoadedState extends TaskState {
  final TasksListModel allTasks;

  TaskLoadedState({
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
