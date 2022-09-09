import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_action/item_action_model.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_actions_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockActionsCollectionReference;
  late CollectionReference mockItemsCollectionReference;
  late ItemActionRepositoryImpl repository;
  late ItemActionRepositoryImpl badRepository;
  late ItemParams tItemParams;
  late ItemActionParams tItemActionParams;

  const companyId = 'companyId';

  const tItemModel = ItemModel(
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

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockActionsCollectionReference = fakeFirebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('actions');
    mockItemsCollectionReference = fakeFirebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('items');
    repository = ItemActionRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badRepository = ItemActionRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
    );

    final itemReference =
        await mockItemsCollectionReference.add(tItemModel.toMap());

    final tItemAction = ItemActionModel(
      id: 'id',
      title: 'title',
      description: 'description',
      ammount: 1,
      itemUnit: ItemUnit.pcs,
      locationId: 'locationId',
      date: DateTime.now(),
      itemId: itemReference.id,
    );

    final actionReference =
        await mockActionsCollectionReference.add(tItemAction.toMap());

    tItemParams = ItemParams(
      item: tItemModel.copyWith(id: itemReference.id),
      companyId: companyId,
    );

    tItemActionParams = ItemActionParams(
      updatedItem: tItemModel.copyWith(id: itemReference.id),
      itemAction: tItemAction.copyWith(id: actionReference.id),
      companyId: companyId,
    );
  });

  group('Inventory Actions repository', () {
    group('successful DB response', () {
      test(
        'should return [String] containing action id when addItemAction is called',
        () async {
          // act
          final result = await repository.addItemAction(tItemActionParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [VoidResult] when deleteItemAction is called',
        () async {
          // act
          final result = await repository.deleteItemAction(tItemActionParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult] when updateItemAction is called',
        () async {
          // act
          final result = await repository.updateItemAction(tItemActionParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [ItemActionStream] when getItemActionsStream is called',
        () async {
          // act
          final result = await repository.getItemActionsStream(tItemParams);
          // assert
          expect(result, isA<Right<Failure, ItemActionsStream>>());
        },
      );
    });
    group('unsuccessful DB response', () {
      test(
        'should return [DatabaseFailure] when addItemAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.addItemAction(tItemActionParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure] when deleteItemAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.deleteItemAction(tItemActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when updateItemAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.updateItemAction(tItemActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when getItemActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.getItemActionsStream(tItemParams);
          // assert
          expect(result, isA<Left<Failure, ItemActionsStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should return [UnsuspectedFailure] when addItemAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addItemAction(tItemActionParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when deleteItemAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.deleteItemAction(tItemActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when updateItemAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.updateItemAction(tItemActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when getItemActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.getItemActionsStream(tItemParams);
          // assert
          expect(result, isA<Left<Failure, ItemActionsStream>>());
        },
      );
    });
  });
}
