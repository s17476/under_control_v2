import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/tasks_stream.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTasksStream usecase;
  late MockTaskRepository repository;

  const tItemsInLocationsParams = ItemsInLocationsParams(
    locations: [],
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemsInLocationsParams);
  });

  setUp(() {
    repository = MockTaskRepository();
    usecase = GetTasksStream(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [TasksStream] from repository when GetTasksStream is called',
      () async {
        // arrange
        when(() => repository.getTasksStream(any())).thenAnswer(
            (_) async => Right(TasksStream(allTasks: Stream.fromIterable([]))));
        // act
        final result = await usecase(tItemsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, TasksStream>>());
      },
    );
  });
}
