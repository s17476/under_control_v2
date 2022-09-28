import '../../../domain/entities/instruction_category/instruction_category.dart';

class InstructionCategoryModel extends InstructionCategory {
  const InstructionCategoryModel({
    required super.id,
    required super.name,
  });

  InstructionCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return InstructionCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});

    return result;
  }

  factory InstructionCategoryModel.fromMap(
      Map<String, dynamic> map, String id) {
    return InstructionCategoryModel(
      id: id,
      name: map['name'] ?? '',
    );
  }
}
