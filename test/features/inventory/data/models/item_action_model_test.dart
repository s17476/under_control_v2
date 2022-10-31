import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/inventory/data/models/item_action/item_action_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';

void main() {
  final date = DateTime.now();

  final tItemActionModel = ItemActionModel(
    id: 'id',
    type: ItemActionType.add,
    description: 'description',
    ammount: 0,
    itemUnit: ItemUnit.kg,
    locationId: 'locationId',
    date: date,
    taskId: 'taskId',
    itemId: 'itemId',
    userId: 'userId',
  );

  final tItemActionModelToMap = {
    'type': ItemActionType.add.name,
    'description': 'description',
    'ammount': 0,
    'itemUnit': ItemUnit.kg.name,
    'locationId': 'locationId',
    'date': date,
    'taskId': 'taskId',
    'itemId': 'itemId',
    'userId': 'userId',
  };
  final tItemActionModelFromMap = {
    'type': ItemActionType.add.name,
    'description': 'description',
    'ammount': 0,
    'itemUnit': ItemUnit.kg.name,
    'locationId': 'locationId',
    'date': Timestamp.fromDate(date),
    'taskId': 'taskId',
    'itemId': 'itemId',
    'userId': 'userId',
  };

  group('ItemActionModel', () {
    test(
      'should be a subclass of [ItemAction] entity',
      () async {
        // assert
        expect(tItemActionModel, isA<ItemAction>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = ItemActionModel.fromMap(tItemActionModelFromMap, 'id');
        // assert
        expect(result, tItemActionModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tItemActionModel.toMap();
        // assert
        expect(result, tItemActionModelToMap);
      },
    );
  });
}
