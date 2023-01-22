part of 'task_filter_bloc.dart';

abstract class TaskFilterEvent extends Equatable {
  final TaskOrRequest? taskOrRequest;
  final TaskOwner? taskOwner;
  final TaskPriority? taskPriority;
  final TaskType? taskType;
  final List properties;
  const TaskFilterEvent({
    this.taskOrRequest,
    this.taskOwner,
    this.taskPriority,
    this.taskType,
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class TaskFilterResetEvent extends TaskFilterEvent {
  const TaskFilterResetEvent({
    super.taskOrRequest = TaskOrRequest.all,
    super.taskOwner = TaskOwner.all,
    super.taskPriority = TaskPriority.unknown,
    super.taskType = TaskType.unknown,
  });
}

class TaskFilterSelectEvent extends TaskFilterEvent {
  TaskFilterSelectEvent({
    super.taskOrRequest,
    super.taskOwner,
    super.taskPriority,
    super.taskType,
  }) : super(properties: [
          taskOrRequest,
          taskOwner,
          taskPriority,
          taskType,
        ]);
}

class TaskFilterShowEvent extends TaskFilterEvent {}

class ResetEvent extends TaskFilterEvent {}

class TaskFilterSetMiniSizeEvent extends TaskFilterEvent {}

class TaskFilterSetFullSizeEvent extends TaskFilterEvent {}

class TaskFilterHideEvent extends TaskFilterEvent {}
