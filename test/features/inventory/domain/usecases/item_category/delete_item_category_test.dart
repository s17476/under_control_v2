import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category/item_category.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart';

class MockItemCategoryRepository extends Mock
    implements ItemCategoryRepository {}

void main() {
  late DeleteItemCategory usecase;
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
    usecase = DeleteItemCategory(repository: repository);
  });

  group('Inventory', () {
    test(
      'should return [VoidResult] from repository when DeleteItemCategory is called',
      () async {
        // arrange
        when(() => repository.deleteItemCategory(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tItemCategoryParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
