part of 'task_templates_management_bloc.dart';

abstract class TaskTemplatesManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const TaskTemplatesManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class TaskTemplatesManagementEmptyState extends TaskTemplatesManagementState {}

class TaskTemplatesManagementLoadingState extends TaskTemplatesManagementState {
}

class TaskTemplatesManagementErrorState extends TaskTemplatesManagementState {
  TaskTemplatesManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class TaskTemplatesManagementSuccessState extends TaskTemplatesManagementState {
  TaskTemplatesManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
