part of 'instruction_bloc.dart';

abstract class InstructionState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const InstructionState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class InstructionEmptyState extends InstructionState {}

class InstructionLoadingState extends InstructionState {}

class InstructionErrorState extends InstructionState {
  const InstructionErrorState({
    super.message,
    super.error = true,
  });
}

class InstructionLoadedState extends InstructionState {
  final InstructionsListModel allInstructions;

  InstructionLoadedState({
    required this.allInstructions,
  }) : super(properties: [allInstructions]);
}
