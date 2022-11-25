import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart';

import '../../../t_task_instance.dart';

class MockTaskActionRepository extends Mock implements TaskActionRepository {}

void main() {
  late DeleteTaskAction usecase;
  late MockTaskActionRepository repository;

  setUpAll(() {
    registerFallbackValue(tTaskActionParams);
  });

  setUp(() {
    repository = MockTaskActionRepository();
    usecase = DeleteTaskAction(repository: repository);
  });

  group('TaskAction', () {
    test(
      'should return [VoidResult] from repository when DeleteTaskAction is called',
      () async {
        // arrange
        when(() => repository.deleteTaskAction(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tTaskActionParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
