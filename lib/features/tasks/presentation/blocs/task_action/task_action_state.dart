part of 'task_action_bloc.dart';

abstract class TaskActionState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const TaskActionState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskActionEmptyState extends TaskActionState {}

class TaskActionLoadingState extends TaskActionState {}

class TaskActionErrorState extends TaskActionState {
  const TaskActionErrorState({
    super.message,
    super.error = true,
  });
}

class TaskActionLoadedState extends TaskActionState {
  final TaskActionsListModel allActions;

  TaskActionLoadedState({
    required this.allActions,
  }) : super(properties: [allActions]);

  TaskAction? getTaskActionById(String id) {
    final index =
        allActions.allTaskActions.indexWhere((action) => action.id == id);
    if (index >= 0) {
      return allActions.allTaskActions[index];
    }
    return null;
  }
}
