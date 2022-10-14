import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/asset_category.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAssetCategoryRepository extends Mock
    implements AssetCategoryRepository {}

void main() {
  late AddAssetCategory usecase;
  late MockAssetCategoryRepository repository;

  const tAssetCategoryParams = AssetCategoryParams(
    assetCategory: AssetCategory(
      id: 'id',
      name: 'name',
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tAssetCategoryParams);
  });

  setUp(() {
    repository = MockAssetCategoryRepository();
    usecase = AddAssetCategory(repository: repository);
  });

  group('Asset', () {
    test(
      'should return [String] from repository when AddAssetCategory is called',
      () async {
        // arrange
        when(() => repository.addAssetCategory(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tAssetCategoryParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
