import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetDashboardAssetActionsStream extends Mock
    implements GetDashboardAssetActionsStream {}

class MockGetDashboardLastFiveAssetActionsStream extends Mock
    implements GetDashboardLastFiveAssetActionsStream {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockFilterBloc mockFilterBloc;

  late MockGetDashboardAssetActionsStream mockGetDashboardAssetActionsStream;
  late MockGetDashboardLastFiveAssetActionsStream
      mockGetDashboardLastFiveAssetActionsStream;

  late DashboardAssetActionBloc dashboardAssetActionBloc;

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

    mockGetDashboardAssetActionsStream = MockGetDashboardAssetActionsStream();
    mockGetDashboardLastFiveAssetActionsStream =
        MockGetDashboardLastFiveAssetActionsStream();

    dashboardAssetActionBloc = DashboardAssetActionBloc(
      authenticationBloc: mockAuthenticationBloc,
      filterBloc: mockFilterBloc,
      getDashboardAssetActionsStream: mockGetDashboardAssetActionsStream,
      getDashboardLastFiveAssetActionsStream:
          mockGetDashboardLastFiveAssetActionsStream,
    );
  });

  setUpAll(
    () {
      registerFallbackValue(
        const ItemsInLocationsParams(
          locations: ['loc1', 'loc2'],
          companyId: 'companyId',
        ),
      );
    },
  );

  group(
    'Dashboard Assets BLoC',
    () {
      test(
        'should emit [DashboardAssetActionEmptyState] as initial state',
        () async {
          // assert
          expect(
              dashboardAssetActionBloc.state, DashboardAssetActionEmptyState());
        },
      );

      group(
        'GetDashboardAssetActionsStream',
        () {
          blocTest<DashboardAssetActionBloc, DashboardAssetActionState>(
            'should emit [DashboardAssetActionLoadedState]  when GetDashboardAssetActionsEvent is called',
            build: () => dashboardAssetActionBloc,
            act: (bloc) async {
              bloc.add(GetDashboardAssetActionsEvent());
              when(() => mockGetDashboardAssetActionsStream(any())).thenAnswer(
                (_) async => Right(
                  AssetActionsStream(
                    allAssetActions: Stream.fromIterable([]),
                  ),
                ),
              );
            },
            expect: () => [isA<DashboardAssetActionLoadedState>()],
          );
          // blocTest<DashboardItemActionBloc, DashboardItemActionState>(
          //   'should emit [DashboardItemActionErrorState]  when GetDashboardItemActionsEvent is called',
          //   build: () => dashboardItemActionBloc,
          //   act: (bloc) async {
          //     bloc.add(GetDashboardItemActionsEvent());
          //     when(() => mockGetDashboardItemsActionsStream(any())).thenAnswer(
          //       (_) async => const Left(
          //         DatabaseFailure(),
          //       ),
          //     );
          //   },
          //   expect: () => [DashboardItemActionLoadingState()],
          // );
        },
      );
      group(
        'GetDashboardLastFiveAssetActionsStream',
        () {
          blocTest<DashboardAssetActionBloc, DashboardAssetActionState>(
            'should emit [DashboardAssetActionLoadingState]  when GetDashboardLastFiveAssetActionsEvent is called',
            build: () => dashboardAssetActionBloc,
            act: (bloc) async {
              bloc.add(GetDashboardAssetActionsEvent());
              when(() => mockGetDashboardLastFiveAssetActionsStream(any()))
                  .thenAnswer(
                (_) async => Right(
                  AssetActionsStream(
                    allAssetActions: Stream.fromIterable([]),
                  ),
                ),
              );
            },
            expect: () => [isA<DashboardAssetActionLoadedState>()],
          );
          // blocTest<DashboardItemActionBloc, DashboardItemActionState>(
          //   'should emit [DashboardItemActionErrorState]  when GetDashboardLastFiveItemActionsEvent is called',
          //   build: () => dashboardItemActionBloc,
          //   act: (bloc) async {
          //     bloc.add(GetDashboardItemActionsEvent());
          //     when(() => mockGetDashboardLastFiveItemsActionsStream(any()))
          //         .thenAnswer(
          //       (_) async => const Left(
          //         DatabaseFailure(),
          //       ),
          //     );
          //   },
          //   expect: () => [DashboardItemActionLoadingState()],
          // );
        },
      );
    },
  );
}
