import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/locations/domain/entities/location.dart';

import 'step.dart';

class Instruction extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<Step> steps;
  final List<Location> locations;
  final bool isPublished;

  const Instruction({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    required this.locations,
    required this.isPublished,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      steps,
      locations,
      isPublished,
    ];
  }

  @override
  String toString() {
    return 'Instruction(id: $id, name: $name, description: $description, steps: $steps, locations: $locations, isPublished: $isPublished)';
  }
}
