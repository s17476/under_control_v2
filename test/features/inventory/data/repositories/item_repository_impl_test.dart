import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/items_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badkFirebaseFirestore;
  late CollectionReference mockCollectionReference;
  late ItemRepositoryImpl repository;
  late ItemRepositoryImpl badRepository;
  late ItemParams tItemParams;
  late ItemsInLocationsParams tItemsInLocationsParams;

  const companyId = 'companyId';

  const tItemModel = ItemModel(
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
  );

  setUp(
    () async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      badkFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('items');
      repository = ItemRepositoryImpl(firebaseFirestore: fakeFirebaseFirestore);
      badRepository =
          ItemRepositoryImpl(firebaseFirestore: badkFirebaseFirestore);

      final documentReference =
          await mockCollectionReference.add(tItemModel.toMap());

      tItemParams = ItemParams(
        item: tItemModel.copyWith(id: documentReference.id),
        companyId: companyId,
      );

      tItemsInLocationsParams =
          const ItemsInLocationsParams(locations: [], companyId: companyId);
    },
  );

  group(
    'Inventory repository',
    () {
      group('successful DB response', () {
        test(
          'should return [String] containing item id when addItem is called',
          () async {
            // act
            final result = await repository.addItem(tItemParams);
            // assert
            expect(result, isA<Right<Failure, String>>());
          },
        );
        test(
          'should return [VoidResult] when updateItem is called',
          () async {
            // act
            final result = await repository.updateItem(tItemParams);
            // assert
            expect(result, isA<Right<Failure, VoidResult>>());
          },
        );
        test(
          'should return [VoidResult] when deleteItem is called',
          () async {
            // act
            final result = await repository.deleteItem(tItemParams);
            // assert
            expect(result, isA<Right<Failure, VoidResult>>());
          },
        );
        test(
          'should return [ItemsStream] when getItemsStream is called',
          () async {
            // act
            final result =
                await repository.getItemsStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Right<Failure, ItemsStream>>());
          },
        );
      });
      group('unsuccessful DB response', () {
        test(
          'should return [DatabaseFailure] when addItem is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.addItem(tItemParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [DatabaseFailure] when updateItem is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.updateItem(tItemParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when deleteItem is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.deleteItem(tItemParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when getItemsStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.getItemsStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, ItemsStream>>());
          },
        );
      });
      group('unsuspected error', () {
        test(
          'should return [UnsuspectedFailure]  when addItem is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.addItem(tItemParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when updateItem is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.updateItem(tItemParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when deleteItem is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.deleteItem(tItemParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when getItemsStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.getItemsStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, ItemsStream>>());
          },
        );
      });
    },
  );
}
