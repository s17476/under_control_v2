import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/data/models/work_order/work_order_model.dart';
import 'package:under_control_v2/features/tasks/data/repositories/work_order_repository_impl.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_orders_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badkFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late CollectionReference mockCollectionReference;
  late WorkOrdersRepositoryImpl repository;
  late WorkOrdersRepositoryImpl badRepository;
  late WorkOrderParams tWorkOrderParams;
  late ItemsInLocationsParams tItemsInLocationsParams;

  const companyId = 'companyId';

  final tWorkOrderModel = WorkOrderModel(
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
          .collection('workOrders');
      mockFirebaseStorage = MockFirebaseStorage();
      repository = WorkOrdersRepositoryImpl(
        firebaseFirestore: fakeFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
      );
      badRepository = WorkOrdersRepositoryImpl(
        firebaseFirestore: badkFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
      );

      final documentReference =
          await mockCollectionReference.add(tWorkOrderModel.toMap());

      tWorkOrderParams = WorkOrderParams(
        workOrder: tWorkOrderModel.copyWith(id: documentReference.id),
        companyId: companyId,
      );

      tItemsInLocationsParams =
          const ItemsInLocationsParams(locations: [], companyId: companyId);
    },
  );

  group(
    'WorkOrders repository',
    () {
      group('successful DB response', () {
        test(
          'should return [String] containing work order id when addWorkOrder is called',
          () async {
            // act
            final result = await repository.addWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Right<Failure, String>>());
          },
        );
        test(
          'should return [VoidResult]  when cancelWorkOrder is called',
          () async {
            // act
            final result = await repository.cancelWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Right<Failure, VoidResult>>());
          },
        );
        test(
          'should return [WorkOrdersStream] when getWorkOrdersStream is called',
          () async {
            // act
            final result =
                await repository.getWorkOrdersStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Right<Failure, WorkOrdersStream>>());
          },
        );
      });
      group('unsuccessful DB response', () {
        test(
          'should return [DatabaseFailure] when addWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.addWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [DatabaseFailure] when updateWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.updateWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when deleteWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.deleteWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when cancelWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.cancelWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when getWorkOrdersStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository
                .getWorkOrdersStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, WorkOrdersStream>>());
          },
        );
      });
      group('unsuspected error', () {
        test(
          'should return [UnsuspectedFailure]  when addWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.addWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when updateWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.updateWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when deleteWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.deleteWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when cancelWorkOrder is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.cancelWorkOrder(tWorkOrderParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when getWorkOrdersStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository
                .getWorkOrdersStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, WorkOrdersStream>>());
          },
        );
      });
    },
  );
}
