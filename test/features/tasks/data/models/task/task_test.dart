import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/tasks/data/models/task/task_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/task.dart';

import '../../../t_task_instance.dart';

void main() {
  group('TaskModel', () {
    test('should be a subclass of [Task] entity', () async {
      // assert
      expect(tTaskModel, isA<Task>());
    });
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = TaskModel.fromMap(tTaskModelFromMap, 'id');
        // assert
        expect(result, tTaskModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tTaskModel.toMap();
        // assert
        expect(result, tTaskModelToMap);
      },
    );
  });
}
