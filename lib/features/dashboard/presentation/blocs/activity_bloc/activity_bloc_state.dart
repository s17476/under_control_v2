part of 'activity_bloc_bloc.dart';

class ActivityBlocState extends Equatable {
  final bool isLoading;
  final int maxValue;
  final List<WorkRequest> workRequests;
  final List<WorkRequest> workRequestsArchive;
  final List<Task> tasks;
  final List<Task> tasksArchive;
  final List<TaskAction> taskActions;
  Map<String, int> get getActivities => _getActivitiesMap();
  const ActivityBlocState({
    required this.isLoading,
    required this.maxValue,
    required this.workRequests,
    required this.workRequestsArchive,
    required this.tasks,
    required this.tasksArchive,
    required this.taskActions,
  });

  factory ActivityBlocState.empty() {
    return const ActivityBlocState(
      isLoading: true,
      maxValue: 0,
      workRequests: [],
      workRequestsArchive: [],
      tasks: [],
      tasksArchive: [],
      taskActions: [],
    );
  }

  @override
  List<Object> get props {
    return [
      isLoading,
      maxValue,
      workRequests,
      workRequestsArchive,
      tasks,
      tasksArchive,
      taskActions,
    ];
  }

  ActivityBlocState copyWith({
    bool? isLoading,
    int? maxValue,
    List<WorkRequest>? workRequests,
    List<WorkRequest>? workRequestsArchive,
    List<Task>? tasks,
    List<Task>? tasksArchive,
    List<TaskAction>? taskActions,
    Map<String, int>? activities,
  }) {
    return ActivityBlocState(
      isLoading: isLoading ?? this.isLoading,
      maxValue: maxValue ?? this.maxValue,
      workRequests: workRequests ?? this.workRequests,
      workRequestsArchive: workRequestsArchive ?? this.workRequestsArchive,
      tasks: tasks ?? this.tasks,
      tasksArchive: tasksArchive ?? this.tasksArchive,
      taskActions: taskActions ?? this.taskActions,
    );
  }

  Map<String, int> _getActivitiesMap() {
    Map<String, int> activities = {};
    final DateFormat dateFormat = DateFormat('dd-MM');
    // work requests
    for (var workRequest in workRequests) {
      final key = dateFormat.format(workRequest.date);
      activities[key] = (activities[key] ?? 0) + 1;
    }
    // work requests archive
    for (var workRequest in workRequestsArchive) {
      final key = dateFormat.format(workRequest.date);
      activities[key] = (activities[key] ?? 0) + 1;
    }
    // tasks
    for (var task in tasks) {
      final key = dateFormat.format(task.date);
      activities[key] = (activities[key] ?? 0) + 1;
    }
    // tasks archive
    for (var task in tasksArchive) {
      final key = dateFormat.format(task.executionDate);
      activities[key] = (activities[key] ?? 0) + 1;
    }
    // tasks actions
    for (var taskAction in taskActions) {
      final key = dateFormat.format(taskAction.stopTime);
      activities[key] = (activities[key] ?? 0) + 1;
    }
    return activities;
  }
}
