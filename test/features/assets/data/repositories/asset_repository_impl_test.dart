import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:under_control_v2/features/assets/domain/entities/assets_stream.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late CollectionReference mockCollectionReference;
  late AssetRepositoryImpl repository;
  late AssetRepositoryImpl badRepository;
  late AssetParams tAssetParams;
  late AssetsInLocationsParams tAssetsInLocationsParams;

  const tCompanyId = 'companyId';

  final tAssetModel = AssetModel(
    id: 'id',
    producer: 'producer',
    model: 'model',
    description: 'description',
    categoryId: 'categoryId',
    locationId: 'locationId',
    internalCode: 'internalCode',
    barCode: 'barCode',
    price: 0,
    isInUse: true,
    addDate: DateTime.now(),
    currentStatus: AssetStatus.ok,
    lastInspection: DateTime.now(),
    durationUnit: DurationUnit.year,
    duration: 1,
    images: const [],
    documents: const [],
    spareParts: const [],
    instructions: const [],
    currentParentId: 'currentParentId',
    isSparePart: true,
  );

  const tCodeParams = CodeParams(
    internalCode: 'internalCode',
    companyId: tCompanyId,
  );

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockFirebaseStorage = MockFirebaseStorage();

    mockCollectionReference = fakeFirebaseFirestore
        .collection('companies')
        .doc(tCompanyId)
        .collection('assets');

    repository = AssetRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
      firebaseStorage: mockFirebaseStorage,
    );

    badRepository = AssetRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
      firebaseStorage: mockFirebaseStorage,
    );

    final documentReference = await mockCollectionReference.add(
      tAssetModel.toMap(),
    );

    tAssetParams = AssetParams(
      asset: tAssetModel.copyWith(id: documentReference.id),
      companyId: tCompanyId,
    );

    tAssetsInLocationsParams = const AssetsInLocationsParams(
      locations: [],
      companyId: tCompanyId,
    );
  });

  group('AssetRepository', () {
    group('successful DB response', () {
      // test(
      //   'should return [String] containing asset id when addAsset is called',
      //   () async {
      //     // act
      //     final result = await repository.addAsset(tAssetParams);
      //     // assert
      //     expect(result, isA<Right<Failure, String>>());
      //   },
      // );
      // test(
      //   'should return [VoidResult] when updateAsset is called',
      //   () async {
      //     // act
      //     final result = await repository.updateAsset(tAssetParams);
      //     // assert
      //     expect(result, isA<Right<Failure, VoidResult>>());
      //   },
      // );
      // test(
      //   'should return [VoidResult] when deleteAsset is called',
      //   () async {
      //     // act
      //     final result = await repository.deleteAsset(tAssetParams);
      //     // assert
      //     expect(result, isA<Right<Failure, VoidResult>>());
      //   },
      // );
      test(
        'should return [AssetsStream] when getAssetsStream is called',
        () async {
          // act
          final result =
              await repository.getAssetsStream(tAssetsInLocationsParams);
          // assert
          expect(result, isA<Right<Failure, AssetsStream>>());
        },
      );
      test(
        'should return [bool] when checkCodeAvailability is called',
        () async {
          // act
          final result = await repository.checkCodeAvailability(tCodeParams);
          // assert
          expect(result, isA<Right<Failure, bool>>());
        },
      );
    });
    group('unsuccessful DB response', () {
      test(
        'should return [DatabaseFailure] when addAsset is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.addAsset(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure] when updateAsset is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.updateAsset(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when deleteAsset is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.deleteAsset(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when getAssetsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.getAssetsStream(tAssetsInLocationsParams);
          // assert
          expect(result, isA<Left<Failure, AssetsStream>>());
        },
      );
      test(
        'should return [DatabaseFailure] when checkCodeAvailability is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.checkCodeAvailability(tCodeParams);
          // assert
          expect(result, isA<Left<Failure, bool>>());
        },
      );
    });
    group('unexpected error', () {
      test(
        'should return [UnsuspectedFailure]  when addAsset is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addAsset(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when updateAsset is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.updateAsset(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when deleteAsset is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.deleteAsset(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when getAssetsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.getAssetsStream(tAssetsInLocationsParams);
          // assert
          expect(result, isA<Left<Failure, AssetsStream>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when checkCodeAvailability is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.checkCodeAvailability(tCodeParams);
          // assert
          expect(result, isA<Left<Failure, bool>>());
        },
      );
    });
  });
}
