import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart';

class MockItemActionRepository extends Mock implements ItemActionRepository {}

void main() {
  late UpdateItemAction usecase;
  late MockItemActionRepository repository;

  const companyId = 'companyId';

  const tItem = Item(
    id: 'id',
    producer: 'producer',
    name: 'name',
    description: 'description',
    category: 'category',
    price: 0,
    itemPhoto: 'itemPhoto',
    itemCode: 'itemCode',
    itemBarCode: 'itemBarCode',
    sparePartFor: [],
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [],
  );

  final tItemAction = ItemAction(
    id: 'id',
    type: ItemActionType.add,
    description: 'description',
    ammount: 1,
    itemUnit: ItemUnit.pcs,
    locationId: 'locationId',
    date: DateTime.now(),
    itemId: 'itemId',
    userId: 'userId',
  );

  final tItemActionParams = ItemActionParams(
    updatedItem: tItem,
    itemAction: tItemAction,
    companyId: companyId,
  );

  setUpAll(() {
    registerFallbackValue(tItemActionParams);
  });

  setUp(() {
    repository = MockItemActionRepository();
    usecase = UpdateItemAction(repository: repository);
  });

  group('Inventory Actions', () {
    test(
      'should return [VoidResult] from repository when UpdateItemAction is called',
      () async {
        // arrange
        when(() => repository.updateItemAction(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tItemActionParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
