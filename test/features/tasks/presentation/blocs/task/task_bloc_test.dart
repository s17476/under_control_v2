import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/tasks_stream.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetTasksStream extends Mock implements GetTasksStream {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockFilterBloc mockFilterBloc;

  late MockGetTasksStream mockGetTasksStream;

  late TaskBloc workRequestBloc;

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

    mockAuthenticationBloc = MockAuthenticationBloc();
    when(() => mockAuthenticationBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(EmptyAuthenticationState()),
      ),
    );

    mockGetTasksStream = MockGetTasksStream();
    workRequestBloc = TaskBloc(
      authenticationBloc: mockAuthenticationBloc,
      filterBloc: mockFilterBloc,
      getTasksStream: mockGetTasksStream,
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

  group('Task BLoC', () {
    test(
      'should emit [TaskEmptyState] as an initial state',
      () async {
        // assert
        expect(workRequestBloc.state, TaskEmptyState());
      },
    );

    group('GetTasksStream', () {
      blocTest<TaskBloc, TaskState>(
        'should emit [TaskLoadedState] when GetTasksStream is called',
        build: () => workRequestBloc,
        act: (bloc) async {
          bloc.add(GetTasksStreamEvent(isAllTasks: true));
          when(() => mockGetTasksStream(any())).thenAnswer(
            (_) async => Right(
              TasksStream(
                allTasks: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<TaskLoadedState>()],
      );
    });
  });
}
