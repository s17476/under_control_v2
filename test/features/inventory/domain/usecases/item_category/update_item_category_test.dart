import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category/item_category.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart';

class MockItemCategoryRepository extends Mock
    implements ItemCategoryRepository {}

void main() {
  late UpdateItemCategory usecase;
  late MockItemCategoryRepository repository;

  const tItemCategoryParams = CategoryParams(
    category: ItemCategory(id: 'id', name: 'name'),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemCategoryParams);
  });

  setUp(() {
    repository = MockItemCategoryRepository();
    usecase = UpdateItemCategory(repository: repository);
  });

  group('Inventory', () {
    test(
      'should return [VoidResult] from repository when UpdateItemCategory is called',
      () async {
        // arrange
        when(() => repository.updateItemCategory(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tItemCategoryParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
