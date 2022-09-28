part of 'instruction_category_management_bloc.dart';

abstract class InstructionCategoryManagementState extends Equatable {
  final InstructionCategoryMessage message;
  final bool error;
  final List properties;

  const InstructionCategoryManagementState({
    this.message = InstructionCategoryMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class InstructionCategoryManagementEmptyState
    extends InstructionCategoryManagementState {}

class InstructionCategoryManagementLoadingState
    extends InstructionCategoryManagementState {}

class InstructionCategoryManagementErrorState
    extends InstructionCategoryManagementState {
  InstructionCategoryManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class InstructionCategoryManagementSuccessState
    extends InstructionCategoryManagementState {
  InstructionCategoryManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
