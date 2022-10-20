import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_action/asset_action_model.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockActionsCollectionReference;
  late CollectionReference mockAssetsCollectionReference;
  late AssetActionRepositoryImpl repository;
  late AssetActionRepositoryImpl badRepository;

  late AssetParams tAssetParams;
  late AssetActionParams tAssetActionParams;

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

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockActionsCollectionReference = fakeFirebaseFirestore
        .collection('companies')
        .doc(tCompanyId)
        .collection('assetsActions');
    mockAssetsCollectionReference = fakeFirebaseFirestore
        .collection('companies')
        .doc(tCompanyId)
        .collection('assets');
    repository = AssetActionRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badRepository = AssetActionRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
    );

    final assetReference =
        await mockAssetsCollectionReference.add(tAssetModel.toMap());

    final tAssetActionModel = AssetActionModel(
      id: 'id',
      assetId: assetReference.id,
      dateTime: DateTime.now(),
      description: 'description',
      isAssetInUse: true,
      assetStatus: AssetStatus.ok,
      connectedTask: 'connectedTask',
    );

    final actionReference =
        await mockActionsCollectionReference.add(tAssetActionModel.toMap());

    tAssetParams = AssetParams(
      asset: tAssetModel.copyWith(id: assetReference.id),
      companyId: tCompanyId,
    );

    tAssetActionParams = AssetActionParams(
      updatedAsset: tAssetModel.copyWith(id: assetReference.id),
      assetAction: tAssetActionModel.copyWith(id: actionReference.id),
      companyId: tCompanyId,
    );
  });

  group('Asset Actions Repository', () {
    group('successful DB response', () {
      test(
        'should return [String] containing action id when addAssetAction is called',
        () async {
          // act
          final result = await repository.addAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [VoidResult] when deleteAssetAction is called',
        () async {
          // act
          final result = await repository.deleteAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult] when updateAssetAction is called',
        () async {
          // act
          final result = await repository.updateAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [ItemActionStream] when getAssetActionsStream is called',
        () async {
          // act
          final result = await repository.getAssetActionsStream(tAssetParams);
          // assert
          expect(result, isA<Right<Failure, AssetActionsStream>>());
        },
      );
      test(
        'should return [ItemActionStream] when getLastFiveAssetActionsStream is called',
        () async {
          // act
          final result =
              await repository.getLastFiveAssetActionsStream(tAssetParams);
          // assert
          expect(result, isA<Right<Failure, AssetActionsStream>>());
        },
      );
    });
    group('unsuccessful DB response', () {
      test(
        'should return [DatabaseFailure] when addAssetAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.addAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure] when deleteAssetAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.deleteAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when updateAssetAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.updateAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when getAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.getAssetActionsStream(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
      test(
        'should return [DatabaseFailure] when getLastFiveAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.getLastFiveAssetActionsStream(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should return [UnsuspectedFailure] when addAssetAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when deleteAssetAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.deleteAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when updateAssetAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.updateAssetAction(tAssetActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when getAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.getAssetActionsStream(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when getLastFiveAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.getLastFiveAssetActionsStream(tAssetParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
    });
  });
}
