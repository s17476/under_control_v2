part of 'task_filter_bloc.dart';

abstract class TaskFilterState extends Equatable {
  final double filterHeight;
  final bool isFilterVisible;
  final bool isMiniSize;
  final TaskOrRequest taskOrRequest;
  final TaskOwner taskOwner;
  final TaskPriority taskPriority;
  final TaskType taskType;
  final List<Task> tasks;
  final List<WorkRequest> workRequests;

  const TaskFilterState({
    this.filterHeight = 350,
    this.isFilterVisible = false,
    this.isMiniSize = false,
    this.taskOrRequest = TaskOrRequest.all,
    this.taskOwner = TaskOwner.all,
    this.taskPriority = TaskPriority.unknown,
    this.taskType = TaskType.unknown,
    this.tasks = const [],
    this.workRequests = const [],
  });

  @override
  List<Object> get props => [
        filterHeight,
        isFilterVisible,
        isMiniSize,
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
    required super.filterHeight,
    required super.isFilterVisible,
    required super.isMiniSize,
    required super.taskOrRequest,
    required super.taskOwner,
    required super.taskPriority,
    required super.taskType,
    required super.tasks,
    required super.workRequests,
  });

  TaskFilterSelectedState copyWith({
    double? filterHeight,
    bool? isFilterVisible,
    bool? isMiniSize,
    TaskOrRequest? taskOrRequest,
    TaskOwner? taskOwner,
    TaskPriority? taskPriority,
    TaskType? taskType,
    List<Task>? tasks,
    List<WorkRequest>? workRequests,
  }) {
    return TaskFilterSelectedState(
      filterHeight: filterHeight ?? this.filterHeight,
      isFilterVisible: isFilterVisible ?? this.isFilterVisible,
      isMiniSize: isMiniSize ?? this.isMiniSize,
      taskOrRequest: taskOrRequest ?? this.taskOrRequest,
      taskOwner: taskOwner ?? this.taskOwner,
      taskPriority: taskPriority ?? this.taskPriority,
      taskType: taskType ?? this.taskType,
      tasks: tasks ?? this.tasks,
      workRequests: workRequests ?? this.workRequests,
    );
  }
}

class TaskFilterNothingSelectedState extends TaskFilterState {
  const TaskFilterNothingSelectedState({
    required super.filterHeight,
    required super.isFilterVisible,
    required super.isMiniSize,
    required super.tasks,
    required super.workRequests,
  });

  TaskFilterNothingSelectedState copyWith({
    double? filterHeight,
    bool? isFilterVisible,
    bool? isMiniSize,
    List<Task>? tasks,
    List<WorkRequest>? workRequests,
  }) {
    return TaskFilterNothingSelectedState(
      filterHeight: filterHeight ?? this.filterHeight,
      isFilterVisible: isFilterVisible ?? this.isFilterVisible,
      isMiniSize: isMiniSize ?? this.isMiniSize,
      tasks: tasks ?? this.tasks,
      workRequests: workRequests ?? this.workRequests,
    );
  }
}
