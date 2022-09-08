import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart';

class MockItemFilesRepository extends Mock implements ItemFilesRepository {}

void main() {
  late DeleteItemPhoto usecase;
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
    usecase = DeleteItemPhoto(repository: repository);
  });

  group('Inventory Files', () {
    test(
      'should return [String] from repository when DeleteItemPhoto is called',
      () async {
        // arrange
        when(() => repository.deleteItemPhoto(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tItemParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
