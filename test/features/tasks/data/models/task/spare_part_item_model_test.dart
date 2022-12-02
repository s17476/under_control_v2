import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/spare_part_item.dart';

void main() {
  const tSparePartItemModel = SparePartItemModel(
    itemId: 'itemId',
    locationId: 'locationId',
    quantity: 1,
  );

  const tSparePartItemModelMap = {
    'itemId': 'itemId',
    'locationId': 'locationId',
    'quantity': 1,
  };

  group('SparPartItemModel', () {
    test(
      'should be a subclass of [SparePartItem] entity',
      () async {
        // assert
        expect(tSparePartItemModel, isA<SparePartItem>());
      },
    );

    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = tSparePartItemModel.toMap();
        // assert
        expect(result, tSparePartItemModelMap);
      },
    );
    test(
      'should return a map containing propper data',
      () async {
        // act
        final result = SparePartItemModel.fromMap(tSparePartItemModelMap);
        // assert
        expect(result, tSparePartItemModel);
      },
    );
  });
}
