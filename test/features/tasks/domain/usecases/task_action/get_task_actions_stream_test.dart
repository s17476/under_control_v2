import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/task_actions_stream.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart';

import '../../../t_task_instance.dart';

class MockTaskActionRepository extends Mock implements TaskActionRepository {}

void main() {
  late GetTaskActionsStream usecase;
  late MockTaskActionRepository repository;

  setUpAll(() {
    registerFallbackValue(tTaskParams);
  });

  setUp(() {
    repository = MockTaskActionRepository();
    usecase = GetTaskActionsStream(repository: repository);
  });

  group('TaskAction', () {
    test(
      'should return [TaskActionsStream] from repository when GetTaskActionsForTaskStream is called',
      () async {
        // arrange
        when(() => repository.getTaskActionsForTaskStream(any())).thenAnswer(
            (_) async => Right(
                TaskActionsStream(allTaskActions: Stream.fromIterable([]))));
        // act
        final result = await usecase(tTaskParams);
        // assert
        expect(result, isA<Right<Failure, TaskActionsStream>>());
      },
    );
  });
}
