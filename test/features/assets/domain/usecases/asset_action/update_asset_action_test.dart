import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_action.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockAssetActionRepository extends Mock implements AssetActionRepository {}

void main() {
  late UpdateAssetAction usecase;
  late MockAssetActionRepository repository;

  const tCompanyId = 'companyId';

  final tAsset = Asset(
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

  final tAssetAction = AssetAction(
    id: 'id',
    assetId: 'assetId',
    dateTime: DateTime.now(),
    description: 'description',
    isAssetInUse: true,
    assetStatus: AssetStatus.ok,
    connectedTask: 'connectedTask',
  );

  final tAssetActionParams = AssetActionParams(
    updatedAsset: tAsset,
    assetAction: tAssetAction,
    companyId: tCompanyId,
  );

  setUpAll(() {
    registerFallbackValue(tAssetActionParams);
  });

  setUp(() {
    repository = MockAssetActionRepository();
    usecase = UpdateAssetAction(repository: repository);
  });

  group('Asset Actions', () {
    test(
      'should return [VoidResult] from repository when UpdateAssetAction is called',
      () async {
        // arrange
        when(() => repository.updateAssetAction(any())).thenAnswer(
          (_) async => Right(VoidResult()),
        );
        // act
        final result = await usecase(tAssetActionParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
