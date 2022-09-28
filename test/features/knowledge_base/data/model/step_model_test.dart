import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/step.dart';

void main() {
  const tStepModel = StepModel(
    id: 0,
    contentType: ContentType.image,
    contentSource: 'contentSource',
    description: 'description',
    title: 'title',
  );

  final tStepMap = {
    'id': 0,
    'contentType': ContentType.image.name,
    'contentSource': 'contentSource',
    'description': 'description',
    'title': 'title',
  };

  test(
    'should be a subclass of [Step] entity',
    () async {
      // assert
      expect(tStepModel, isA<Step>());
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
      final result = StepModel.fromMap(tStepMap);
      // assert
      expect(result, tStepModel);
    },
  );
}
