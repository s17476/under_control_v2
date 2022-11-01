import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_orders_stream.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_orders_stream.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_order/work_order_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetWorkOrdersStream extends Mock implements GetWorkOrdersStream {}

void main() {
  late MockFilterBloc mockFilterBloc;

  late MockGetWorkOrdersStream mockGetWorkOrdersStream;

  late WorkOrderBloc workOrderBloc;

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

    mockGetWorkOrdersStream = MockGetWorkOrdersStream();
    workOrderBloc = WorkOrderBloc(
      filterBloc: mockFilterBloc,
      getWorkOrdersStream: mockGetWorkOrdersStream,
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

  group('Work Order BLoC', () {
    test(
      'should emit [WorkOrderEmptyState] as an initial state',
      () async {
        // assert
        expect(workOrderBloc.state, WorkOrderEmptyState());
      },
    );

    group('GetWorkOrdersStream', () {
      blocTest<WorkOrderBloc, WorkOrderState>(
        'should emit [WorkOrderLoadedState] when GetWorkOrdersStream is called',
        build: () => workOrderBloc,
        act: (bloc) async {
          bloc.add(GetWorkOrdersStreamEvent());
          when(() => mockGetWorkOrdersStream(any())).thenAnswer(
            (_) async => Right(
              WorkOrdersStream(
                allWorkOrders: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<WorkOrderLoadedState>()],
      );
    });
  });
}
