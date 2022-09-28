import '../../../core/data/models/last_edit_model.dart';
import '../../../core/domain/entities/last_edit.dart';
import '../../domain/entities/instruction.dart';
import '../../domain/entities/step.dart';
import 'step_model.dart';

class InstructionModel extends Instruction {
  const InstructionModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.steps,
    required super.locations,
    required super.userId,
    required super.lastEdited,
    required super.isPublished,
  });

  InstructionModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    List<Step>? steps,
    List<String>? locations,
    String? userId,
    List<LastEdit>? lastEdited,
    bool? isPublished,
  }) {
    return InstructionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      steps: steps ?? this.steps,
      locations: locations ?? this.locations,
      userId: userId ?? this.userId,
      lastEdited: lastEdited ?? this.lastEdited,
      isPublished: isPublished ?? this.isPublished,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'category': category});
    result
        .addAll({'steps': steps.map((x) => (x as StepModel).toMap()).toList()});
    result.addAll({'locations': locations});
    result.addAll({'userId': userId});
    result.addAll({
      'lastEdited': lastEdited.map((x) => (x as LastEditModel).toMap()).toList()
    });
    result.addAll({'isPublished': isPublished});

    return result;
  }

  factory InstructionModel.fromMap(Map<String, dynamic> map, String id) {
    return InstructionModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      steps: List<Step>.from(
        map['steps']?.map(
          (x) => StepModel.fromMap(x),
        ),
      ),
      locations: List<String>.from(map['locations']),
      userId: map['userId'] ?? '',
      lastEdited: List<LastEdit>.from(
        map['lastEdited']?.map(
          (x) => LastEditModel.fromMap(x),
        ),
      ),
      isPublished: map['isPublished'] ?? false,
    );
  }
}
