import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart';

class MockItemActionRepository extends Mock implements ItemActionRepository {}

void main() {
  late GetItemsActionsStream usecase;
  late MockItemActionRepository repository;

  const companyId = 'companyId';

  const tItemParams = ItemParams(
    item: Item(
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
    ),
    companyId: companyId,
  );

  setUpAll(() {
    registerFallbackValue(tItemParams);
  });

  setUp(() {
    repository = MockItemActionRepository();
    usecase = GetItemsActionsStream(repository: repository);
  });

  group('Inventory Actions', () {
    test(
      'should return [ItemActionsStream] from repository when GetItemActionStream is called',
      () async {
        // arrange
        when(() => repository.getItemActionsStream(any())).thenAnswer(
          (_) async => Right(
            ItemActionsStream(
              allItemActions: Stream.fromIterable([]),
            ),
          ),
        );
        // act
        final result = await usecase(tItemParams);
        // assert
        expect(result, isA<Right<Failure, ItemActionsStream>>());
      },
    );
  });
}
