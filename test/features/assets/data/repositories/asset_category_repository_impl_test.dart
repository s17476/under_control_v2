import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_category/asset_category_model.dart';
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/assets_categories_stream.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockCollectionReferance;
  late AssetCategoryRepositoryImpl repository;
  late AssetCategoryRepositoryImpl badRepository;
  late AssetCategoryParams tParams;

  const String companyId = 'companyId';

  const tAssetCategory = AssetCategoryModel(
    id: 'id',
    name: 'name',
  );

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReferance = fakeFirebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('assetsCategories');
    repository = AssetCategoryRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badRepository = AssetCategoryRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
    );
    final documentReference = await mockCollectionReferance.add(
      tAssetCategory.toMap(),
    );

    tParams = AssetCategoryParams(
      assetCategory: tAssetCategory.copyWith(
        id: documentReference.id,
      ),
      companyId: companyId,
    );
  });

  group('Assets AssetCategoryRepositoryImpl', () {
    group('successful database response', () {
      test(
        'should return [String] containing asset category id when addAssetCategory is called',
        () async {
          // act
          final result = await repository.addAssetCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [VoidResult]  when deleteAssetCategory is called',
        () async {
          // act
          final result = await repository.deleteAssetCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult]  when updateAssetCategory is called',
        () async {
          // act
          final result = await repository.updateAssetCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [AssetsCategoriesStream]  when getAssetsCategoriesStream is called',
        () async {
          // act
          final result = await repository.getAssetsCategoriesStream(companyId);
          // assert
          expect(result, isA<Right<Failure, AssetsCategoriesStream>>());
        },
      );
    });
    group('unsuccessful database response', () {
      test(
        'should return [DatabaseFailure]  when addAssetCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.addAssetCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when deleteAssetCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.deleteAssetCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when updateAssetCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.updateAssetCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when getAssetsCategoriesStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result =
              await badRepository.getAssetsCategoriesStream(companyId);
          // assert
          expect(result, isA<Left<Failure, AssetsCategoriesStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should return [UnsuspectedFailure]  when addAssetCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addAssetCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when deleteAssetCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.deleteAssetCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when updateAssetCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.updateAssetCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when getAssetsCategoriesStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.getAssetsCategoriesStream(companyId);
          // assert
          expect(result, isA<Left<Failure, AssetsCategoriesStream>>());
        },
      );
    });
  });
}
