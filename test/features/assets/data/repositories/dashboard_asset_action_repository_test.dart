import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_actions_stream.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  // late CollectionReference mockActionsCollectionReference;
  late DashboardAssetActionRepositoryImpl repository;
  late DashboardAssetActionRepositoryImpl badRepository;
  late ItemsInLocationsParams tItemsInLocationsParams;

  const companyId = 'companyId';

  const loc1 = 'loc1';
  const loc2 = 'loc2';

  const tLocations = [loc1, loc2];

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    // mockActionsCollectionReference = fakeFirebaseFirestore
    //     .collection('companies')
    //     .doc(companyId)
    //     .collection('actions');

    repository = DashboardAssetActionRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badRepository = DashboardAssetActionRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
    );

    // final tItemAction = ItemActionModel(
    //   id: 'id',
    //   type: ItemActionType.add,
    //   description: 'description',
    //   ammount: 1,
    //   itemUnit: ItemUnit.pcs,
    //   locationId: '',
    //   date: DateTime.now(),
    //   itemId: 'itemId',
    //   userId: 'userId',
    // );

    // final action1Reference = await mockActionsCollectionReference
    //     .add(tItemAction.copyWith(locationId: loc1).toMap());
    // final action2Reference = await mockActionsCollectionReference
    //     .add(tItemAction.copyWith(locationId: loc2).toMap());

    tItemsInLocationsParams = const ItemsInLocationsParams(
        locations: tLocations, companyId: companyId);
  });

  group('Dashboard Assets Actions repository', () {
    group('successful DB response', () {
      test(
        'should return [AssetActionsStream] when getDashboardAssetActionsStream is called',
        () async {
          // act
          final result = await repository
              .getDashboardAssetActionsStream(tItemsInLocationsParams);
          // assert
          expect(result, isA<Right<Failure, AssetActionsStream>>());
        },
      );
      test(
        'should return [AssetActionsStream] when getDashboardLastFiveAssetActionsStream is called',
        () async {
          // act
          final result = await repository
              .getDashboardLastFiveAssetActionsStream(tItemsInLocationsParams);
          // assert
          expect(result, isA<Right<Failure, AssetActionsStream>>());
        },
      );
    });
    group('unsuccessful DB response', () {
      test(
        'should return [DatabaseFailure] when getDashboardAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository
              .getDashboardAssetActionsStream(tItemsInLocationsParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
      test(
        'should return [DatabaseFailure] when getDashboardLastFiveAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository
              .getDashboardLastFiveAssetActionsStream(tItemsInLocationsParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should return [DatabaseFailure] when getDashboardAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository
              .getDashboardAssetActionsStream(tItemsInLocationsParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
      test(
        'should return [DatabaseFailure] when getDashboardLastFiveAssetActionsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository
              .getDashboardLastFiveAssetActionsStream(tItemsInLocationsParams);
          // assert
          expect(result, isA<Left<Failure, AssetActionsStream>>());
        },
      );
    });
  });
}
