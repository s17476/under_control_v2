part of 'work_request_management_bloc.dart';

abstract class WorkRequestManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const WorkRequestManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkRequestManagementEmptyState extends WorkRequestManagementState {}

class WorkRequestManagementLoadingState extends WorkRequestManagementState {}

class WorkRequestManagementErrorState extends WorkRequestManagementState {
  WorkRequestManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class WorkRequestManagementSuccessState extends WorkRequestManagementState {
  WorkRequestManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
