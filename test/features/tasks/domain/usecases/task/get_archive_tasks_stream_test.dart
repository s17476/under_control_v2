import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/tasks_stream.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetArchiveTasksStream usecase;
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
    usecase = GetArchiveTasksStream(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [TasksStream] from repository when GetArchiveTasksStream is called',
      () async {
        // arrange
        when(() => repository.getArchiveTasksStream(any())).thenAnswer(
            (_) async => Right(TasksStream(allTasks: Stream.fromIterable([]))));
        // act
        final result = await usecase(tItemsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, TasksStream>>());
      },
    );
  });
}
