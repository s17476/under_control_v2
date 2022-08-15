part of 'checklist_management_bloc.dart';

abstract class ChecklistManagementState extends Equatable {
  final ChecklistMessage message;
  final bool error;
  final List properties;

  const ChecklistManagementState({
    this.message = ChecklistMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ChecklistManagementEmptyState extends ChecklistManagementState {}

class ChecklistManagementLoadingState extends ChecklistManagementState {}

class ChecklistManagementErrorState extends ChecklistManagementState {
  ChecklistManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class ChecklistManagementSuccessState extends ChecklistManagementState {
  ChecklistManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
