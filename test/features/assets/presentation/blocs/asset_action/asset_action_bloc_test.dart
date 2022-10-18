import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockGetAssetActionsStream extends Mock implements GetAssetActionsStream {}

class MockGetLastFiveAssetActionsStream extends Mock
    implements GetLastFiveAssetActionsStream {}

void main() {
  late MockGetAssetActionsStream mockGetAssetActionsStream;
  late MockGetLastFiveAssetActionsStream mockGetLastFiveAssetActionsStream;
  late AssetActionBloc assetActionBloc;

  const tCompanyId = 'companyId';

  final tAsset = AssetModel(
    id: 'id',
    producer: 'producer',
    model: 'model',
    description: 'description',
    categoryId: 'categoryId',
    locationId: 'locationId',
    internalCode: 'internalCode',
    barCode: 'barCode',
    isInUse: true,
    addDate: DateTime.now(),
    currentStatus: AssetStatus.ok,
    lastInspection: DateTime.now(),
    durationUnit: DurationUnit.year,
    duration: 1,
    images: const [],
    doucments: const [],
    spareParts: const [],
    currentParentId: 'currentParentId',
    isSparePart: true,
  );

  final tAssetParams = AssetParams(
    asset: tAsset,
    companyId: tCompanyId,
  );

  setUp(() {
    mockGetAssetActionsStream = MockGetAssetActionsStream();
    mockGetLastFiveAssetActionsStream = MockGetLastFiveAssetActionsStream();

    assetActionBloc = AssetActionBloc(
      getAssetActionsStream: mockGetAssetActionsStream,
      getLastFiveAssetActionsStream: mockGetLastFiveAssetActionsStream,
    );
  });

  setUpAll(() {
    registerFallbackValue(tAssetParams);
  });

  group('AssetAction BLoC', () {
    test(
      'should emit [AssetActionEmptyState] as an initial state',
      () async {
        // assert
        expect(assetActionBloc.state, AssetActionEmptyState());
      },
    );

    group(
      'GetAssetActionsStream',
      () {
        blocTest<AssetActionBloc, AssetActionState>(
          'should emit [AssetActionLoadingState]  when GetAssetActionsEvent is called',
          build: () => assetActionBloc,
          act: (bloc) async {
            bloc.add(
              GetAssetActionsEvent(
                asset: tAsset,
                companyId: tCompanyId,
              ),
            );
            when(() => mockGetAssetActionsStream(any())).thenAnswer(
              (_) async => Right(
                AssetActionsStream(
                  allAssetActions: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            AssetActionLoadingState(),
          ],
        );
        blocTest<AssetActionBloc, AssetActionState>(
          'should emit [AssetActionErrorState] when GetAssetActionsEvent is called',
          build: () => assetActionBloc,
          act: (bloc) async {
            bloc.add(
              GetAssetActionsEvent(
                asset: tAsset,
                companyId: tCompanyId,
              ),
            );
            when(() => mockGetAssetActionsStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            AssetActionLoadingState(),
            isA<AssetActionErrorState>(),
          ],
        );
      },
    );
    group(
      'GetLastFiveAssetActionsStream',
      () {
        blocTest<AssetActionBloc, AssetActionState>(
          'should emit [AssetActionLoadingState]  when GetLastFiveAssetActionsEvent is called',
          build: () => assetActionBloc,
          act: (bloc) async {
            bloc.add(
              GetLastFiveAssetActionsEvent(
                asset: tAsset,
                companyId: tCompanyId,
              ),
            );
            when(() => mockGetLastFiveAssetActionsStream(any())).thenAnswer(
              (_) async => Right(
                AssetActionsStream(
                  allAssetActions: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            AssetActionLoadingState(),
          ],
        );
        blocTest<AssetActionBloc, AssetActionState>(
          'should emit [AssetActionErrorState] when GetLastFiveAssetActionsEvent is called',
          build: () => assetActionBloc,
          act: (bloc) async {
            bloc.add(
              GetLastFiveAssetActionsEvent(
                asset: tAsset,
                companyId: tCompanyId,
              ),
            );
            when(() => mockGetLastFiveAssetActionsStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            AssetActionLoadingState(),
            isA<AssetActionErrorState>(),
          ],
        );
      },
    );
  });
}
