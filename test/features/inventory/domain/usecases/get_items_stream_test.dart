import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/items_stream.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  late GetItemsStream usecase;
  late MockItemRepository repository;

  const tItemsInLocationsParams = ItemsInLocationsParams(
    locations: [],
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemsInLocationsParams);
  });

  setUp(() {
    repository = MockItemRepository();
    usecase = GetItemsStream(repository: repository);
  });

  group('Inventory', () {
    test(
      'should return [ItemsStream] from repository when GetItemsStream is called',
      () async {
        // arrange
        when(() => repository.getItemsStream(any())).thenAnswer(
            (_) async => Right(ItemsStream(allItems: Stream.fromIterable([]))));
        // act
        final result = await usecase(tItemsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, ItemsStream>>());
      },
    );
  });
}
