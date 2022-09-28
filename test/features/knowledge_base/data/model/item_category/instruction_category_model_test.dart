import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/item_category/instruction_category_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_category/instruction_category.dart';

void main() {
  const tInstructionCategoryModel = InstructionCategoryModel(
    id: 'id',
    name: 'name',
  );

  final tInstructionCategoryModelMap = {
    'name': 'name',
  };

  group('Knowledge Base', () {
    test(
      'should be a subclass of [InstructionCategory] entity',
      () async {
        // assert
        expect(tInstructionCategoryModel, isA<InstructionCategory>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = InstructionCategoryModel.fromMap(
            tInstructionCategoryModelMap, 'id');
        // assert
        expect(result, tInstructionCategoryModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tInstructionCategoryModel.toMap();
        // assert
        expect(result, tInstructionCategoryModelMap);
      },
    );
  });
}
