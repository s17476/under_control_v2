import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart';

class MockItemActionRepository extends Mock implements ItemActionRepository {}

void main() {
  late AddItemAction usecase;
  late MockItemActionRepository repository;

  const companyId = 'companyId';

  const tItem = Item(
    id: 'id',
    name: 'name',
    description: 'description',
    category: 'category',
    itemPhoto: 'itemPhoto',
    itemCode: 'itemCode',
    sparePartFor: [],
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [],
  );

  final tItemAction = ItemAction(
    id: 'id',
    title: 'title',
    description: 'description',
    ammount: 1,
    itemUnit: ItemUnit.pcs,
    locationId: 'locationId',
    date: DateTime.now(),
    itemId: 'itemId',
  );

  final tItemActionParams = ItemActionParams(
    item: tItem,
    itemAction: tItemAction,
    companyId: companyId,
  );

  setUpAll(() {
    registerFallbackValue(tItemActionParams);
  });

  setUp(() {
    repository = MockItemActionRepository();
    usecase = AddItemAction(repository: repository);
  });

  group('Inventory Actions', () {
    test(
      'should return [String] from repository when AddItemAction is called',
      () async {
        // arrange
        when(() => repository.addItemAction(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tItemActionParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
