import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late AddAsset usecase;
  late MockAssetRepository repository;

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

  final tAssetParams = AssetParams(asset: tAsset, companyId: tCompanyId);

  setUpAll(() {
    registerFallbackValue(tAssetParams);
  });

  setUp(() {
    repository = MockAssetRepository();
    usecase = AddAsset(repository: repository);
  });

  group('Assets', () {
    test(
      'should return [String] from repository when AddAsset is called',
      () async {
        // arrange
        when(() => repository.addAsset(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tAssetParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
