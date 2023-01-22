part of 'instruction_bloc.dart';

abstract class InstructionEvent extends Equatable {
  final List properties;

  const InstructionEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetInstructionsStreamEvent extends InstructionEvent {}

class ResetEvent extends InstructionEvent {}

class UpdateInstructionsListEvent extends InstructionEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateInstructionsListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
