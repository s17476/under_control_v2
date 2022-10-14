import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/asset_category.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAssetCategoryRepository extends Mock
    implements AssetCategoryRepository {}

void main() {
  late DeleteAssetCategory usecase;
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
    usecase = DeleteAssetCategory(repository: repository);
  });

  group('Asset', () {
    test(
      'should return [VoidResult] from repository when DeleteAssetCategory is called',
      () async {
        // arrange
        when(() => repository.deleteAssetCategory(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tAssetCategoryParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
