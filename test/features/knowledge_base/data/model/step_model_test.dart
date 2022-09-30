import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_step.dart';

void main() {
  const tStepModel = InstructionStepModel(
    id: 0,
    contentType: ContentType.image,
    contentUrl: 'contentUrl',
    description: 'description',
    title: 'title',
  );

  final tStepMap = {
    'id': 0,
    'contentType': ContentType.image.name,
    'contentUrl': 'contentUrl',
    'description': 'description',
    'title': 'title',
  };

  test(
    'should be a subclass of [Step] entity',
    () async {
      // assert
      expect(tStepModel, isA<InstructionStep>());
    },
  );

  test(
    'should return a map containing proper data',
    () async {
      // act
      final result = tStepModel.toMap();
      // assert
      expect(result, tStepMap);
    },
  );

  test(
    'should return a model containing proper data',
    () async {
      // act
      final result = InstructionStepModel.fromMap(tStepMap);
      // assert
      expect(result, tStepModel);
    },
  );
}
