import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';

void main() {
  const tItemModel = ItemModel(
    id: 'id',
    name: 'name',
    description: 'description',
    itemPhoto: 'itemPhoto',
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [],
  );

  final tItemModelMap = {
    'name': 'name',
    'description': 'description',
    'itemPhoto': 'itemPhoto',
    'itemUnit': ItemUnit.pcs.name,
    'locations': [],
    'amountInLocations': [],
  };

  group('Inventory', () {
    test(
      'should be a subclass of [Item] entity',
      () async {
        // assert
        expect(tItemModel, isA<Item>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = ItemModel.fromMap(tItemModelMap, 'id');
        // assert
        expect(result, tItemModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tItemModel.toMap();
        // assert
        expect(result, tItemModelMap);
      },
    );
  });
}
