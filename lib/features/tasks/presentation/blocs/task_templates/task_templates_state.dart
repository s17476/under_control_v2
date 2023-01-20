part of 'task_templates_bloc.dart';

abstract class TaskTemplatesState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const TaskTemplatesState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskTemplatesEmptyState extends TaskTemplatesState {}

class TaskTemplatesLoadingState extends TaskTemplatesState {}

class TaskTemplatesErrorState extends TaskTemplatesState {
  const TaskTemplatesErrorState({
    super.message,
    super.error = true,
  });
}

class TaskTemplatesLoadedState extends TaskTemplatesState {
  final TasksListModel allTasks;
  TaskTemplatesLoadedState({
    required this.allTasks,
  }) : super(properties: [allTasks]);
}
