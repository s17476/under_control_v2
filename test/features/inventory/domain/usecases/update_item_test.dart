import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  late UpdateItem usecase;
  late MockItemRepository repository;

  const tItemParams = ItemParams(
    item: Item(
      id: 'id',
      producer: 'producer',
      name: 'name',
      description: 'description',
      category: 'category',
      price: 0,
      alertQuantity: 0,
      itemPhoto: 'itemPhoto',
      itemCode: 'itemCode',
      itemBarCode: 'itemBarCode',
      sparePartFor: [],
      itemUnit: ItemUnit.pcs,
      locations: [],
      amountInLocations: [],
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemParams);
  });

  setUp(() {
    repository = MockItemRepository();
    usecase = UpdateItem(repository: repository);
  });

  group('Inventory', () {
    test(
      'should return [String] from repository when UpdateItem is called',
      () async {
        // arrange
        when(() => repository.updateItem(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tItemParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
