import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_requests_stream.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetWorkRequestsStream extends Mock implements GetWorkRequestsStream {}

void main() {
  late MockFilterBloc mockFilterBloc;

  late MockGetWorkRequestsStream mockGetWorkRequestsStream;

  late WorkRequestBloc workRequestBloc;

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

    mockGetWorkRequestsStream = MockGetWorkRequestsStream();
    workRequestBloc = WorkRequestBloc(
      filterBloc: mockFilterBloc,
      getWorkRequestsStream: mockGetWorkRequestsStream,
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

  group('Work Request BLoC', () {
    test(
      'should emit [WorkRequestEmptyState] as an initial state',
      () async {
        // assert
        expect(workRequestBloc.state, WorkRequestEmptyState());
      },
    );

    group('GetWorkRequestsStream', () {
      blocTest<WorkRequestBloc, WorkRequestState>(
        'should emit [WorkRequestLoadedState] when GetWorkRequestsStream is called',
        build: () => workRequestBloc,
        act: (bloc) async {
          bloc.add(GetWorkRequestsStreamEvent());
          when(() => mockGetWorkRequestsStream(any())).thenAnswer(
            (_) async => Right(
              WorkRequestsStream(
                allWorkRequests: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<WorkRequestLoadedState>()],
      );
    });
  });
}
