import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_orders_stream.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_orders_stream.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_orders_stream.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_order/work_order_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_order_archive/work_order_archive_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetArchiveWorkOrdersStream extends Mock
    implements GetArchiveWorkOrdersStream {}

void main() {
  late MockFilterBloc mockFilterBloc;

  late MockGetArchiveWorkOrdersStream mockGetArchiveWorkOrdersStream;

  late WorkOrderArchiveBloc workOrderArchiveBloc;

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

    mockGetArchiveWorkOrdersStream = MockGetArchiveWorkOrdersStream();
    workOrderArchiveBloc = WorkOrderArchiveBloc(
      filterBloc: mockFilterBloc,
      getArchiveWorkOrdersStream: mockGetArchiveWorkOrdersStream,
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

  group('Work Order Archive BLoC', () {
    test(
      'should emit [WorkOrderArchiveEmptyState] as an initial state',
      () async {
        // assert
        expect(workOrderArchiveBloc.state, WorkOrderArchiveEmptyState());
      },
    );

    group('GetWorkOrdersStream', () {
      blocTest<WorkOrderArchiveBloc, WorkOrderArchiveState>(
        'should emit [WorkOrderLoadedState] when GetWorkOrdersStream is called',
        build: () => workOrderArchiveBloc,
        act: (bloc) async {
          bloc.add(GetWorkOrdersArchiveStreamEvent());
          when(() => mockGetArchiveWorkOrdersStream(any())).thenAnswer(
            (_) async => Right(
              WorkOrdersStream(
                allWorkOrders: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<WorkOrderArchiveLoadedState>()],
      );
    });
  });
}
