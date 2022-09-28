import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction.dart';

void main() {
  const tInstructionModel = InstructionModel(
    id: 'id',
    name: 'name',
    description: 'description',
    category: 'category',
    steps: [],
    locations: [],
    userId: 'userId',
    lastEdited: [],
    isPublished: true,
  );

  const tInstructionMap = {
    'name': 'name',
    'description': 'description',
    'category': 'category',
    'steps': [],
    'locations': [],
    'userId': 'userId',
    'lastEdited': [],
    'isPublished': true,
  };

  test(
    'should ba a subclass of [Instruction] entity',
    () async {
      // assert
      expect(tInstructionModel, isA<Instruction>());
    },
  );

  test(
    'should return a map containing proper data',
    () async {
      // act
      final result = tInstructionModel.toMap();
      // assert
      expect(result, tInstructionMap);
    },
  );

  test(
    'should return a model containing proper data',
    () async {
      // act
      final result = InstructionModel.fromMap(tInstructionMap, 'id');
      // assert
      expect(result, tInstructionModel);
    },
  );
}
