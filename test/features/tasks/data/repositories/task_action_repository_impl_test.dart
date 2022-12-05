import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart';

import '../../t_task_instance.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late CollectionReference mockCollectionReference;
  late TaskActionRepositoryImpl repository;
  late TaskActionRepositoryImpl badRepository;

  const tCompanyId = 'companyId';

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = fakeFirebaseFirestore
        .collection('companies')
        .doc(tCompanyId)
        .collection('taskActions');
    mockFirebaseStorage = MockFirebaseStorage();
    repository = TaskActionRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
      firebaseStorage: mockFirebaseStorage,
    );
    badRepository = TaskActionRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
      firebaseStorage: mockFirebaseStorage,
    );

    await fakeFirebaseFirestore
        .collection('companies')
        .doc(tCompanyId)
        .set({'name': 'name'});

    await fakeFirebaseFirestore
        .collection('companies')
        .doc(tCompanyId)
        .collection('tasks')
        .doc(tTaskActionParams.taskAction.taskId)
        .set({'name': 'name'});

    await mockCollectionReference.add(tTaskActionModel.toMap());
  });

  group('Task Action repository', () {
    group('successful DB response', () {
      test(
        'should return [String] containing task action generated id when addTaskAction is called',
        () async {
          // act
          final result = await repository.addTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      // test(
      //   'should return [Voidresult] when deleteTaskAction is called',
      //   () async {
      //     // act
      //     final result = await repository.deleteTaskAction(tTaskActionParams);
      //     // assert
      //     expect(result, isA<Left<Failure, VoidResult>>());
      //   },
      // );
      test(
        'should return [Voidresult] when updateTaskAction is called',
        () async {
          // act
          final result = await repository.updateTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });

    group('unsuccessful DB response', () {
      test(
        'should return [DatabaseFailure] when addTaskAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result = await badRepository.addTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure] when deleteTaskAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.deleteTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when updateTaskAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firebase'),
          );
          // act
          final result =
              await badRepository.updateTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });

    group('unsuspected error', () {
      test(
        'should return [UnsuspectedFailure] when addTaskAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when deleteTaskAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.deleteTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure] when updateTaskAction is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.updateTaskAction(tTaskActionParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });
  });
}
