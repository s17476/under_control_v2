part of 'task_filter_bloc.dart';

abstract class TaskFilterState extends Equatable {
  final TaskOrRequest taskOrRequest;
  final TaskOwner taskOwner;
  final TaskPriority taskPriority;
  final TaskType taskType;
  final List<Task> tasks;
  final List<WorkRequest> workRequests;

  const TaskFilterState({
    this.taskOrRequest = TaskOrRequest.all,
    this.taskOwner = TaskOwner.all,
    this.taskPriority = TaskPriority.unknown,
    this.taskType = TaskType.unknown,
    this.tasks = const [],
    this.workRequests = const [],
  });

  @override
  List<Object> get props => [
        taskOrRequest,
        taskOwner,
        taskPriority,
        taskType,
        tasks,
        workRequests,
      ];
}

class TaskFilterInitialState extends TaskFilterState {
  const TaskFilterInitialState();
}

class TaskFilterSelectedState extends TaskFilterState {
  const TaskFilterSelectedState({
    required super.taskOrRequest,
    required super.taskOwner,
    required super.taskPriority,
    required super.taskType,
    required super.tasks,
    required super.workRequests,
  });
}

class TaskFilterNothingSelectedState extends TaskFilterState {
  const TaskFilterNothingSelectedState({
    required super.tasks,
    required super.workRequests,
  });
}
