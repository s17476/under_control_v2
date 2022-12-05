part of 'task_action_bloc.dart';

abstract class TaskActionEvent extends Equatable {
  final List properties;

  const TaskActionEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTaskActionsForTaskStreamEvent extends TaskActionEvent {
  final Task task;
  final String companyId;
  GetTaskActionsForTaskStreamEvent({
    required this.task,
    required this.companyId,
  }) : super(properties: [task, companyId]);
}

class UpdateTaskActionsListEvent extends TaskActionEvent {
  final QuerySnapshot<Object?> snapshot;

  UpdateTaskActionsListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}

class ResetTaskActionsEvent extends TaskActionEvent {}
