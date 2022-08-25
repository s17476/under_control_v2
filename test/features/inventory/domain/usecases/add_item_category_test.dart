import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category/item_category.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_category.dart';

class MockItemCategoryRepository extends Mock
    implements ItemCategoryRepository {}

void main() {
  late AddItemCategory usecase;
  late MockItemCategoryRepository repository;

  const tItemCategoryParams = ItemCategoryParams(
    itemCategory: ItemCategory(
      id: 'id',
      name: 'name',
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemCategoryParams);
  });

  setUp(() {
    repository = MockItemCategoryRepository();
    usecase = AddItemCategory(repository: repository);
  });

  group('Inventory', () {
    test(
      'should return [String] from repository when AddItemCategory is called',
      () async {
        // arrange
        when(() => repository.addItemCategory(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tItemCategoryParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
