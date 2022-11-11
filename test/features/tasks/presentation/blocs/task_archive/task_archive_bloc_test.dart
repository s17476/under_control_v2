import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/tasks_stream.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetArchiveTasksStream extends Mock implements GetArchiveTasksStream {}

void main() {
  late MockFilterBloc mockFilterBloc;

  late MockGetArchiveTasksStream mockGetArchiveTasksStream;

  late TaskArchiveBloc workRequestArchiveBloc;

  setUp(() {
    mockFilterBloc = MockFilterBloc();

    when(() => mockFilterBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(
          FilterEmptyState(),
        ),
      ),
    );
    when(() => mockFilterBloc.state).thenAnswer(
      (_) => FilterEmptyState(),
    );

    mockGetArchiveTasksStream = MockGetArchiveTasksStream();
    workRequestArchiveBloc = TaskArchiveBloc(
      filterBloc: mockFilterBloc,
      getArchiveTasksStream: mockGetArchiveTasksStream,
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const ItemsInLocationsParams(
        locations: ['loc1', 'loc2'],
        companyId: 'companyId',
      ),
    );
  });

  group('Work Request Archive BLoC', () {
    test(
      'should emit [TaskArchiveEmptyState] as an initial state',
      () async {
        // assert
        expect(workRequestArchiveBloc.state, TaskArchiveEmptyState());
      },
    );

    group('GetTasksStream', () {
      blocTest<TaskArchiveBloc, TaskArchiveState>(
        'should emit [TaskLoadedState] when GetTasksStream is called',
        build: () => workRequestArchiveBloc,
        act: (bloc) async {
          bloc.add(GetTasksArchiveStreamEvent());
          when(() => mockGetArchiveTasksStream(any())).thenAnswer(
            (_) async => Right(
              TasksStream(
                allTasks: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<TaskArchiveLoadedState>()],
      );
    });
  });
}
