import 'package:flutter/material.dart';

import '../../../data/models/instruction_step_model.dart';
import '../../../domain/entities/instruction_step.dart';

class TextStep extends StatelessWidget {
  const TextStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStep step;

  final Function(InstructionStep) updateStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('data'),
    );
  }
}
