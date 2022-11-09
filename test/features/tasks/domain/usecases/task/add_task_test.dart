import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart';

import '../../../t_task_instance.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late AddTask usecase;
  late MockTaskRepository repository;

  setUpAll(() {
    registerFallbackValue(tTaskParams);
  });

  setUp(() {
    repository = MockTaskRepository();
    usecase = AddTask(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [String] from repository when AddTask is called',
      () async {
        // arrange
        when(() => repository.addTask(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tTaskParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
