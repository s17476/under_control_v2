part of 'activity_bloc_bloc.dart';

abstract class ActivityBlocEvent extends Equatable {
  final List properties;
  const ActivityBlocEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetActivitiesEvent extends ActivityBlocEvent {}

class ResetEvent extends ActivityBlocEvent {}

class UpdateWorkRequestsEvent extends ActivityBlocEvent {
  final List<WorkRequest> workRequests;
  UpdateWorkRequestsEvent({
    required this.workRequests,
  }) : super(properties: [workRequests]);
}

class UpdateWorkRequestsArchiveEvent extends ActivityBlocEvent {
  final List<WorkRequest> workRequests;
  UpdateWorkRequestsArchiveEvent({
    required this.workRequests,
  }) : super(properties: [workRequests]);
}

class UpdateTasksEvent extends ActivityBlocEvent {
  final List<Task> tasks;
  UpdateTasksEvent({
    required this.tasks,
  }) : super(properties: [tasks]);
}

class UpdateTasksArchiveEvent extends ActivityBlocEvent {
  final List<Task> tasks;
  UpdateTasksArchiveEvent({
    required this.tasks,
  }) : super(properties: [tasks]);
}

class UpdateTaskActionsEvent extends ActivityBlocEvent {
  final List<TaskAction> taskActions;
  UpdateTaskActionsEvent({
    required this.taskActions,
  }) : super(properties: [taskActions]);
}
