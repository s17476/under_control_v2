import 'package:equatable/equatable.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';

import '../../../core/domain/entities/last_edit.dart';
import 'instruction_step.dart';

class Instruction extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final List<InstructionStep> steps;
  final List<String> locations;
  final String userId;
  final List<LastEdit> lastEdited;
  final bool isPublished;

  const Instruction({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.steps,
    required this.locations,
    required this.userId,
    required this.lastEdited,
    required this.isPublished,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      category,
      steps,
      locations,
      userId,
      lastEdited,
      isPublished,
    ];
  }

  @override
  String toString() {
    return 'Instruction(id: $id, name: $name, description: $description, category: $category, steps: $steps, locations: $locations, userId: $userId, lastEdited: $lastEdited, isPublished: $isPublished)';
  }
}
