import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/inventory/data/models/item_category_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category.dart';

void main() {
  const tItemCategoryModel = ItemCategoryModel(
    id: 'id',
    name: 'name',
  );

  final tItemCategoryModelMap = {
    'name': 'name',
  };

  group('Inventory', () {
    test(
      'should be a subclass of [ItemCategory] entity',
      () async {
        // assert
        expect(tItemCategoryModel, isA<ItemCategory>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = ItemCategoryModel.fromMap(tItemCategoryModelMap, 'id');
        // assert
        expect(result, tItemCategoryModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tItemCategoryModel.toMap();
        // assert
        expect(result, tItemCategoryModelMap);
      },
    );
  });
}
