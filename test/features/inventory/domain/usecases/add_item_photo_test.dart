import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart';

class MockItemFilesRepository extends Mock implements ItemFilesRepository {}

void main() {
  late AddItemPhoto usecase;
  late MockItemFilesRepository repository;

  const tItemParams = ItemParams(
    item: Item(
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
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemParams);
  });

  setUp(() {
    repository = MockItemFilesRepository();
    usecase = AddItemPhoto(repository: repository);
  });

  group('Inventory Files', () {
    test(
      'should return [String] from repository when AddItemPhoto is called',
      () async {
        // arrange
        when(() => repository.addItemPhoto(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tItemParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
