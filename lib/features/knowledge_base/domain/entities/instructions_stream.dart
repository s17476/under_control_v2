import 'package:equatable/equatable.dart';

class InstructionsStream extends Equatable {
  final Stream allInstructions;

  const InstructionsStream({
    required this.allInstructions,
  });

  @override
  List<Object> get props => [allInstructions];

  @override
  String toString() => 'InstructionsStream(allInstructions: $allInstructions)';
}
