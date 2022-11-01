part of 'work_order_management_bloc.dart';

abstract class WorkOrderManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const WorkOrderManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkOrderManagementEmptyState extends WorkOrderManagementState {}

class WorkOrderManagementLoadingState extends WorkOrderManagementState {}

class WorkOrderManagementErrorState extends WorkOrderManagementState {
  WorkOrderManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class WorkOrderManagementSuccessState extends WorkOrderManagementState {
  WorkOrderManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
