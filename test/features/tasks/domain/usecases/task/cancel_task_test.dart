import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart';

import '../../../t_task_instance.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late CancelTask usecase;
  late MockTaskRepository repository;

  setUpAll(() {
    registerFallbackValue(tTaskParams);
  });

  setUp(() {
    repository = MockTaskRepository();
    usecase = CancelTask(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [VoidResult] from repository when CancelTask is called',
      () async {
        // arrange
        when(() => repository.cancelTask(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tTaskParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
