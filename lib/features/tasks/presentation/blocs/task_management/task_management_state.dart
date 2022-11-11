part of 'task_management_bloc.dart';

abstract class TaskManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const TaskManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskManagementEmptyState extends TaskManagementState {}

class TaskManagementLoadingState extends TaskManagementState {}

class TaskManagementErrorState extends TaskManagementState {
  TaskManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class TaskManagementSuccessState extends TaskManagementState {
  TaskManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
