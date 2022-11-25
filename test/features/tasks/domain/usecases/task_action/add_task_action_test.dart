import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart';

import '../../../t_task_instance.dart';

class MockTaskActionRepository extends Mock implements TaskActionRepository {}

void main() {
  late AddTaskAction usecase;
  late MockTaskActionRepository repository;

  setUpAll(() {
    registerFallbackValue(tTaskActionParams);
  });

  setUp(() {
    repository = MockTaskActionRepository();
    usecase = AddTaskAction(repository: repository);
  });

  group('TasksAction', () {
    test(
      'should return [String] from repository when AddTaskAction is called',
      () async {
        // arrange
        when(() => repository.addTaskAction(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tTaskActionParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
