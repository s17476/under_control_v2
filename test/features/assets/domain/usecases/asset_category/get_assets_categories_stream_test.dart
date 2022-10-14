import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/asset_category.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/assets_categories_stream.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAssetCategoryRepository extends Mock
    implements AssetCategoryRepository {}

void main() {
  late GetAssetsCategoriesStream usecase;
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
    usecase = GetAssetsCategoriesStream(repository: repository);
  });

  group('Asset', () {
    test(
      'should return [VoidResult] from repository when GetAssetsCategoriesStream is called',
      () async {
        // arrange
        when(() => repository.getAssetsCategoriesStream(any())).thenAnswer(
            (_) async => Right(AssetsCategoriesStream(
                allAssetsCategories: Stream.fromIterable([]))));
        // act
        final result = await usecase('companyId');
        // assert
        expect(result, isA<Right<Failure, AssetsCategoriesStream>>());
      },
    );
  });
}
