import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/data/models/work_request/work_request_model.dart';
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_requests_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badkFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late CollectionReference mockCollectionReference;
  late WorkRequestsRepositoryImpl repository;
  late WorkRequestsRepositoryImpl badRepository;
  late WorkRequestParams tWorkRequestParams;
  late ItemsInLocationsParams tItemsInLocationsParams;

  const companyId = 'companyId';

  final tWorkRequestModel = WorkRequestModel(
    id: 'id',
    title: 'title',
    description: 'description',
    date: DateTime.now(),
    locationId: 'locationId',
    userId: 'userId',
    assetId: 'assetId',
    images: const [],
    video: 'video',
    priority: TaskPriority.low,
    count: 0,
    taskId: 'taskId',
    assetStatus: AssetStatus.ok,
    cancelled: false,
  );

  setUp(
    () async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      badkFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('workRequests');
      mockFirebaseStorage = MockFirebaseStorage();
      repository = WorkRequestsRepositoryImpl(
        firebaseFirestore: fakeFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
      );
      badRepository = WorkRequestsRepositoryImpl(
        firebaseFirestore: badkFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
      );
      await fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .set({'name': 'name'});
      await fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('assets')
          .doc(tWorkRequestModel.assetId)
          .set({'name': 'name'});
      final documentReference =
          await mockCollectionReference.add(tWorkRequestModel.toMap());

      tWorkRequestParams = WorkRequestParams(
        workRequest: tWorkRequestModel.copyWith(id: documentReference.id),
        companyId: companyId,
      );

      tItemsInLocationsParams =
          const ItemsInLocationsParams(locations: [], companyId: companyId);
    },
  );

  group(
    'WorkRequests repository',
    () {
      group('successful DB response', () {
        test(
          'should return [String] containing work order id when addWorkRequest is called',
          () async {
            // act
            final result = await repository.addWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Right<Failure, String>>());
          },
        );
        test(
          'should return [VoidResult]  when cancelWorkRequest is called',
          () async {
            // act
            final result =
                await repository.cancelWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Right<Failure, VoidResult>>());
          },
        );
        test(
          'should return [WorkRequestsStream] when getWorkRequestsStream is called',
          () async {
            // act
            final result =
                await repository.getWorkRequestsStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Right<Failure, WorkRequestsStream>>());
          },
        );
      });
      group('unsuccessful DB response', () {
        test(
          'should return [DatabaseFailure] when addWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.addWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [DatabaseFailure] when updateWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.updateWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when deleteWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.deleteWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when cancelWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.cancelWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when getWorkRequestsStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository
                .getWorkRequestsStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, WorkRequestsStream>>());
          },
        );
      });
      group('unsuspected error', () {
        test(
          'should return [UnsuspectedFailure]  when addWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.addWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when updateWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.updateWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when deleteWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.deleteWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when cancelWorkRequest is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.cancelWorkRequest(tWorkRequestParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when getWorkRequestsStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository
                .getWorkRequestsStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, WorkRequestsStream>>());
          },
        );
      });
    },
  );
}
