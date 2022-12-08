part of 'task_action_management_bloc.dart';

abstract class TaskActionManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const TaskActionManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskActionManagementEmptyState extends TaskActionManagementState {}

class TaskActionManagementLoadingState extends TaskActionManagementState {}

class TaskActionManagementErrorState extends TaskActionManagementState {
  TaskActionManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class TaskActionManagementSuccessState extends TaskActionManagementState {
  TaskActionManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
