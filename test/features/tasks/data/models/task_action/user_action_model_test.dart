import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/user_action_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/user_action.dart';

import '../../../t_task_instance.dart';

void main() {
  test(
    'should be a subclass of [UserAction] entity',
    () async {
      // assert
      expect(tUserActionModel, isA<UserAction>());
    },
  );

  test(
    'should return valid model from a map',
    () async {
      // act
      final result = UserActionModel.fromMap(tUserActionModelFromMap);
      // assert
      expect(result, tUserActionModel);
    },
  );

  test(
    'should return a map containing proper data',
    () async {
      // act
      final result = tUserActionModel.toMap();
      // assert
      expect(result, tUserActionModelToMap);
    },
  );
}
