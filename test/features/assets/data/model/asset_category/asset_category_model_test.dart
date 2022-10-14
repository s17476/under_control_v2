import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/assets/data/models/asset_category/asset_category_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/asset_category.dart';

void main() {
  const tAssetCategoryModel = AssetCategoryModel(
    id: 'id',
    name: 'name',
  );

  final tAssetCategoryModelMap = {
    'name': 'name',
  };

  group('Asset', () {
    test(
      'should be a subclass of [AssetCategory] entity',
      () async {
        // assert
        expect(tAssetCategoryModel, isA<AssetCategory>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = AssetCategoryModel.fromMap(tAssetCategoryModelMap, 'id');
        // assert
        expect(result, tAssetCategoryModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tAssetCategoryModel.toMap();
        // assert
        expect(result, tAssetCategoryModelMap);
      },
    );
  });
}
