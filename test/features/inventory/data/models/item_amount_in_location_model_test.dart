import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/inventory/data/models/item_amount_in_location_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_amount_in_location.dart';

void main() {
  const tItemAmountInLocationModel = ItemAmountInLocationModel(
    amount: 100,
    locationId: 'locationId',
  );

  const tItemAmountInLocationModelMap = {
    'amount': 100,
    'locationId': 'locationId',
  };

  group('Inventory', () {
    test(
      'should be a subclass of [ItemAmountInLocation] entity',
      () async {
        // assert
        expect(tItemAmountInLocationModel, isA<ItemAmountInLocation>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result =
            ItemAmountInLocationModel.fromMap(tItemAmountInLocationModelMap);
        // assert
        expect(result, tItemAmountInLocationModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tItemAmountInLocationModel.toMap();
        // assert
        expect(result, tItemAmountInLocationModelMap);
      },
    );
  });
}
