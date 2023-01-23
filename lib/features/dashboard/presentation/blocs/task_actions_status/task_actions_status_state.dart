part of 'task_actions_status_bloc.dart';

abstract class TaskActionsStatusState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const TaskActionsStatusState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskActionsStatusEmptyState extends TaskActionsStatusState {}

class TaskActionsStatusLoadingState extends TaskActionsStatusState {}

class TaskActionsStatusErrorState extends TaskActionsStatusState {
  const TaskActionsStatusErrorState({
    super.message,
    super.error = true,
  });
}

class TaskActionsStatusLoadedState extends TaskActionsStatusState {
  final TaskActionsListModel taskActions;

  TaskActionsStatusLoadedState(
      {this.taskActions = const TaskActionsListModel(allTaskActions: [])})
      : super(properties: [taskActions]);
}
