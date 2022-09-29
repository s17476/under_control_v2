part of 'instruction_management_bloc.dart';

abstract class InstructionManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const InstructionManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class InstructionManagementEmptyState extends InstructionManagementState {}

class InstructionManagementLoadingState extends InstructionManagementState {}

class InstructionManagementErrorState extends InstructionManagementState {
  const InstructionManagementErrorState({
    required super.message,
    super.error = true,
  });
}

class InstructionManagementSuccessState extends InstructionManagementState {
  const InstructionManagementSuccessState({
    required super.message,
  });
}
