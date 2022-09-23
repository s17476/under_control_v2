import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetDashboardItemsActionsStream extends Mock
    implements GetDashboardItemsActionsStream {}

class MockGetDashboardLastFiveItemsActionsStream extends Mock
    implements GetDashboardLastFiveItemsActionsStream {}

void main() {
  late MockFilterBloc mockFilterBloc;

  late MockGetDashboardItemsActionsStream mockGetDashboardItemsActionsStream;
  late MockGetDashboardLastFiveItemsActionsStream
      mockGetDashboardLastFiveItemsActionsStream;

  late DashboardItemActionBloc dashboardItemActionBloc;

  setUp(() {
    mockFilterBloc = MockFilterBloc();

    when(() => mockFilterBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(
          FilterEmptyState(),
        ),
      ),
    );

    mockGetDashboardItemsActionsStream = MockGetDashboardItemsActionsStream();
    mockGetDashboardLastFiveItemsActionsStream =
        MockGetDashboardLastFiveItemsActionsStream();

    dashboardItemActionBloc = DashboardItemActionBloc(
      filterBloc: mockFilterBloc,
      getDashboardItemsActionsStream: mockGetDashboardItemsActionsStream,
      getDashboardLastFiveItemsActionsStream:
          mockGetDashboardLastFiveItemsActionsStream,
    );
  });

  setUpAll(
    () {
      registerFallbackValue(
        const ItemsInLocationsParams(
          locations: [],
          companyId: 'companyId',
        ),
      );
    },
  );

  group(
    'Dashboard Inventory BLoC',
    () {
      test(
        'should emit [Dashboard]',
        () async {
          // assert
          expect(
              dashboardItemActionBloc.state, DashboardItemActionEmptyState());
        },
      );

      group(
        'GetDashboardItemsActionsStream',
        () {
          blocTest<DashboardItemActionBloc, DashboardItemActionState>(
            'should emit [DashboardItemActionLoadingState]  when GetDashboardItemActionsEvent is called',
            build: () => dashboardItemActionBloc,
            act: (bloc) async {
              bloc.add(GetDashboardItemActionsEvent());
              when(() => mockGetDashboardItemsActionsStream(any())).thenAnswer(
                (_) async => Right(
                  ItemActionsStream(
                    allItemActions: Stream.fromIterable([]),
                  ),
                ),
              );
            },
            expect: () => [DashboardItemActionLoadingState()],
          );
          blocTest<DashboardItemActionBloc, DashboardItemActionState>(
            'should emit [DashboardItemActionErrorState]  when GetDashboardItemActionsEvent is called',
            build: () => dashboardItemActionBloc,
            act: (bloc) async {
              bloc.add(GetDashboardItemActionsEvent());
              when(() => mockGetDashboardItemsActionsStream(any())).thenAnswer(
                (_) async => const Left(
                  DatabaseFailure(),
                ),
              );
            },
            expect: () => [DashboardItemActionLoadingState()],
          );
        },
      );
      group(
        'GetDashboardLastFiveItemsActionsStream',
        () {
          blocTest<DashboardItemActionBloc, DashboardItemActionState>(
            'should emit [DashboardItemActionLoadingState]  when GetDashboardLastFiveItemActionsEvent is called',
            build: () => dashboardItemActionBloc,
            act: (bloc) async {
              bloc.add(GetDashboardItemActionsEvent());
              when(() => mockGetDashboardLastFiveItemsActionsStream(any()))
                  .thenAnswer(
                (_) async => Right(
                  ItemActionsStream(
                    allItemActions: Stream.fromIterable([]),
                  ),
                ),
              );
            },
            expect: () => [DashboardItemActionLoadingState()],
          );
          blocTest<DashboardItemActionBloc, DashboardItemActionState>(
            'should emit [DashboardItemActionErrorState]  when GetDashboardLastFiveItemActionsEvent is called',
            build: () => dashboardItemActionBloc,
            act: (bloc) async {
              bloc.add(GetDashboardItemActionsEvent());
              when(() => mockGetDashboardLastFiveItemsActionsStream(any()))
                  .thenAnswer(
                (_) async => const Left(
                  DatabaseFailure(),
                ),
              );
            },
            expect: () => [DashboardItemActionLoadingState()],
          );
        },
      );
    },
  );
}
