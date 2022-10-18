import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockAssetActionRepository extends Mock implements AssetActionRepository {}

void main() {
  late GetLastFiveAssetActionsStream usecase;
  late MockAssetActionRepository repository;

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

  setUpAll(() {
    registerFallbackValue(tAssetParams);
  });

  setUp(() {
    repository = MockAssetActionRepository();
    usecase = GetLastFiveAssetActionsStream(repository: repository);
  });

  group('Asset Actions', () {
    test(
      'should return [AssetActionsStream] from repository when GetlastFiveAssetActionsStream is called',
      () async {
        // arrange
        when(() => repository.getLastFiveAssetActionsStream(any())).thenAnswer(
          (_) async => Right(
            AssetActionsStream(
              allAssetActions: Stream.fromIterable([]),
            ),
          ),
        );
        // act
        final result = await usecase(tAssetParams);
        // assert
        expect(result, isA<Right<Failure, AssetActionsStream>>());
      },
    );
  });
}
