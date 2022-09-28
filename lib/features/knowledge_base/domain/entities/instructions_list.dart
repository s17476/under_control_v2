import 'package:equatable/equatable.dart';

import 'instruction.dart';

class InstructionsList extends Equatable {
  final List<Instruction> allInstructions;

  const InstructionsList({
    required this.allInstructions,
  });

  @override
  List<Object> get props => [allInstructions];

  @override
  String toString() => 'InstructionsList(allInstructions: $allInstructions)';
}
