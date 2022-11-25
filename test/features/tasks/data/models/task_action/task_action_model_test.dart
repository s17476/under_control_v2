import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/task_action_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/task_action.dart';

import '../../../t_task_instance.dart';

void main() {
  test(
    'should be a subclass of [TaskAction] entity',
    () async {
      // assert
      expect(tTaskActionModel, isA<TaskAction>());
    },
  );

  test(
    'should return valid model from a map',
    () async {
      // act
      final result = TaskActionModel.fromMap(tTaskActionModelFromMap, 'id');
      // assert
      expect(result, tTaskActionModel);
    },
  );

  test(
    'should return a map containing proper data',
    () async {
      // act
      final result = tTaskActionModel.toMap();
      // assert
      expect(result, tTaskActionModelToMap);
    },
  );
}
