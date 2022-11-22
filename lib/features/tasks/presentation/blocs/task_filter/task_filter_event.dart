part of 'task_filter_bloc.dart';

abstract class TaskFilterEvent extends Equatable {
  final TaskOrRequest taskOrRequest;
  final TaskOwner taskOwner;
  final TaskPriority taskPriority;
  final TaskType taskType;
  const TaskFilterEvent({
    this.taskOrRequest = TaskOrRequest.all,
    this.taskOwner = TaskOwner.all,
    this.taskPriority = TaskPriority.unknown,
    this.taskType = TaskType.unknown,
  });

  @override
  List<Object> get props => [taskOrRequest, taskOwner, taskPriority, taskType];
}

class TaskFilterResetEvent extends TaskFilterEvent {}

class TaskFilterSelectEvent extends TaskFilterEvent {
  const TaskFilterSelectEvent({
    super.taskOrRequest,
    super.taskOwner,
    super.taskPriority,
    super.taskType,
  });
}
