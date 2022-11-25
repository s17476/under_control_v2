import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/task_actions_stream.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart';

class MockTaskActionRepository extends Mock implements TaskActionRepository {}

void main() {
  late GetLatestTaskActionsStream usecase;
  late MockTaskActionRepository repository;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    repository = MockTaskActionRepository();
    usecase = GetLatestTaskActionsStream(repository: repository);
  });

  group('TaskAction', () {
    test(
      'should return [TaskActionsStream] from repository when GetLatestTaskActionsStream is called',
      () async {
        // arrange
        when(() => repository.getLatestTaskActionsStream(any())).thenAnswer(
            (_) async => Right(
                TaskActionsStream(allTaskActions: Stream.fromIterable([]))));
        // act
        final result = await usecase(NoParams());
        // assert
        expect(result, isA<Right<Failure, TaskActionsStream>>());
      },
    );
  });
}
