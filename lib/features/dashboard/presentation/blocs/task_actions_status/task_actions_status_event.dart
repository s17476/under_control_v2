part of 'task_actions_status_bloc.dart';

abstract class TaskActionsStatusEvent extends Equatable {
  final List properties;

  const TaskActionsStatusEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTaskActionsStatusEvent extends TaskActionsStatusEvent {}

class ResetEvent extends TaskActionsStatusEvent {}

class UpdateStatusEvent extends TaskActionsStatusEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateStatusEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
