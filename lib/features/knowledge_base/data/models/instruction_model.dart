import '../../../core/data/models/last_edit_model.dart';
import '../../domain/entities/instruction.dart';
import 'instruction_step_model.dart';

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
    List<InstructionStepModel>? steps,
    List<String>? locations,
    String? userId,
    List<LastEditModel>? lastEdited,
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
    result.addAll({'steps': steps.map((x) => x.toMap()).toList()});
    result.addAll({'locations': locations});
    result.addAll({'userId': userId});
    result.addAll({'lastEdited': lastEdited.map((x) => x.toMap()).toList()});
    result.addAll({'isPublished': isPublished});

    return result;
  }

  factory InstructionModel.fromMap(Map<String, dynamic> map, String id) {
    return InstructionModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      steps: List<InstructionStepModel>.from(
        map['steps']?.map(
          (x) => InstructionStepModel.fromMap(x),
        ),
      ),
      locations: List<String>.from(map['locations']),
      userId: map['userId'] ?? '',
      lastEdited: List<LastEditModel>.from(
        map['lastEdited']?.map(
          (x) => LastEditModel.fromMap(x),
        ),
      ),
      isPublished: map['isPublished'] ?? false,
    );
  }

  factory InstructionModel.fromInstruction(Instruction instruction) {
    return InstructionModel(
      id: instruction.id,
      name: instruction.name,
      description: instruction.description,
      category: instruction.category,
      steps: instruction.steps,
      locations: instruction.locations,
      userId: instruction.userId,
      lastEdited: instruction.lastEdited,
      isPublished: instruction.isPublished,
    );
  }

  InstructionModel deepCopy() {
    return copyWith(
      locations: [...locations],
      steps: steps.map((e) => e.copyWith()).toList(),
    );
  }
}
