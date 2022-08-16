import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_category_model.dart';
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category.dart';
import 'package:under_control_v2/features/inventory/domain/entities/items_categories_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockCollectionReferance;
  late ItemCategoryRepositoryImpl repository;
  late ItemCategoryRepositoryImpl badRepository;
  late ItemCategoryParams tParams;

  const String companyId = 'companyId';

  const tItemCategory = ItemCategoryModel(
    id: 'id',
    name: 'name',
  );

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReferance = fakeFirebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('itemsCategories');
    repository = ItemCategoryRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badRepository = ItemCategoryRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
    );
    final documentReference = await mockCollectionReferance.add(
      tItemCategory.toMap(),
    );

    tParams = ItemCategoryParams(
      itemCategory: tItemCategory.copyWith(
        id: documentReference.id,
      ),
      companyId: companyId,
    );
  });

  group('Inventory ItemCategoryRepositoryImpl', () {
    group('successful database response', () {
      test(
        'should return [String] containing item category id when addItemCategory is called',
        () async {
          // act
          final result = await repository.addItemCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [VoidResult]  when deleteItemCategory is called',
        () async {
          // act
          final result = await repository.deleteItemCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult]  when updateItemCategory is called',
        () async {
          // act
          final result = await repository.updateItemCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [ItemsCategoriesStream]  when getItemsCategoriesStream is called',
        () async {
          // act
          final result = await repository.getItemsCategoriesStream(companyId);
          // assert
          expect(result, isA<Right<Failure, ItemsCategoriesStream>>());
        },
      );
    });
    group('unsuccessful database response', () {
      test(
        'should return [DatabaseFailure]  when addItemCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.addItemCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when deleteItemCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.deleteItemCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when updateItemCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.updateItemCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when getItemsCategoriesStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result =
              await badRepository.getItemsCategoriesStream(companyId);
          // assert
          expect(result, isA<Left<Failure, ItemsCategoriesStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should return [UnsuspectedFailure]  when addItemCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addItemCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when deleteItemCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.deleteItemCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when updateItemCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.updateItemCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when getItemsCategoriesStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.getItemsCategoriesStream(companyId);
          // assert
          expect(result, isA<Left<Failure, ItemsCategoriesStream>>());
        },
      );
    });
  });
}
