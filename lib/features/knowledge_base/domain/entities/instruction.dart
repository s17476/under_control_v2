import 'package:equatable/equatable.dart';

import '../../../core/domain/entities/last_edit.dart';
import 'step.dart';

class Instruction extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final List<Step> steps;
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
