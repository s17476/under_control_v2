import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/tasks_stream.dart';

import '../../t_task_instance.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badkFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late CollectionReference mockCollectionReference;
  late TaskRepositoryImpl repository;
  late TaskRepositoryImpl badRepository;
  late ItemsInLocationsParams tItemsInLocationsParams;

  const companyId = 'companyId';

  setUp(
    () async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      badkFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('workOrders');
      mockFirebaseStorage = MockFirebaseStorage();
      repository = TaskRepositoryImpl(
        firebaseFirestore: fakeFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
      );
      badRepository = TaskRepositoryImpl(
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
          .doc(tTaskParams.task.assetId)
          .set({'name': 'name'});

      final documentReference =
          await mockCollectionReference.add(tTaskModel.toMap());

      tItemsInLocationsParams =
          const ItemsInLocationsParams(locations: [], companyId: companyId);
    },
  );

  group(
    'Task repository',
    () {
      group('successful DB response', () {
        test(
          'should return [String] containing work order id when addTask is called',
          () async {
            // act
            final result = await repository.addTask(tTaskParams);
            // assert
            expect(result, isA<Right<Failure, String>>());
          },
        );
        test(
          'should return [VoidResult]  when cancelTask is called',
          () async {
            // act
            final result = await repository.cancelTask(tTaskParams);
            // assert
            expect(result, isA<Right<Failure, VoidResult>>());
          },
        );
        test(
          'should return [TasksStream] when getTaskStream is called',
          () async {
            // act
            final result =
                await repository.getTasksStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Right<Failure, TasksStream>>());
          },
        );
      });
      group('unsuccessful DB response', () {
        test(
          'should return [DatabaseFailure] when addTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.addTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [DatabaseFailure] when updateTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.updateTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when deleteTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.deleteTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when cancelTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository.cancelTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when getTasksStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.getTasksStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, TasksStream>>());
          },
        );
      });
      group('unsuspected error', () {
        test(
          'should return [UnsuspectedFailure]  when addTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.addTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when updateTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.updateTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when deleteTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.deleteTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when cancelTask is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository.cancelTask(tTaskParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when getTasksStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.getTasksStream(tItemsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, TasksStream>>());
          },
        );
      });
    },
  );
}
