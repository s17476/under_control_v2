import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_model.dart';
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instructions_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badkFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late CollectionReference mockCollectionReference;
  late InstructionRepositoryImpl repository;
  late InstructionRepositoryImpl badRepository;
  late InstructionParams tInstructionParams;
  late InstructionsInLocationsParams tInstructionsInLocationsParams;

  const companyId = 'companyId';

  const tInstructionModel = InstructionModel(
    id: 'id',
    name: 'name',
    description: 'description',
    category: 'category',
    steps: [],
    locations: [],
    userId: 'userId',
    lastEdited: [],
    isPublished: true,
  );

  setUp(
    () async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      badkFirebaseFirestore = MockFirebaseFirestore();
      mockFirebaseStorage = MockFirebaseStorage();

      mockCollectionReference = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('instructions');

      repository = InstructionRepositoryImpl(
          firebaseFirestore: fakeFirebaseFirestore,
          firebaseStorage: mockFirebaseStorage);

      badRepository = InstructionRepositoryImpl(
        firebaseFirestore: badkFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
      );

      final documentReference =
          await mockCollectionReference.add(tInstructionModel.toMap());

      tInstructionParams = InstructionParams(
        instruction: tInstructionModel.copyWith(id: documentReference.id),
        companyId: companyId,
      );

      tInstructionsInLocationsParams = const InstructionsInLocationsParams(
        locations: [],
        companyId: companyId,
      );
    },
  );

  group(
    'Instruction repository',
    () {
      group('successful DB response', () {
        test(
          'should return [String] containing instruction id when addInstruction is called',
          () async {
            // act
            final result = await repository.addInstruction(tInstructionParams);
            // assert
            expect(result, isA<Right<Failure, String>>());
          },
        );
        test(
          'should return [VoidResult] when updateInstruction is called',
          () async {
            // act
            final result =
                await repository.updateInstruction(tInstructionParams);
            // assert
            expect(result, isA<Right<Failure, VoidResult>>());
          },
        );
        // test(
        //   'should return [VoidResult] when deleteinstruction is called',
        //   () async {
        //     // act
        //     final result =
        //         await repository.deleteInstruction(tInstructionParams);
        //     // assert
        //     expect(result, isA<Right<Failure, VoidResult>>());
        //   },
        // );
        test(
          'should return [InstructionsStream] when getInstructionsStream is called',
          () async {
            // act
            final result = await repository
                .getInstructionsStream(tInstructionsInLocationsParams);
            // assert
            expect(result, isA<Right<Failure, InstructionsStream>>());
          },
        );
      });
      group('unsuccessful DB response', () {
        test(
          'should return [DatabaseFailure] when addInstruction is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.addInstruction(tInstructionParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [DatabaseFailure] when updateInstruction is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.updateInstruction(tInstructionParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when deleteinstruction is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result =
                await badRepository.deleteInstruction(tInstructionParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [DatabaseFailure] when getInstructionsStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              FirebaseException(plugin: 'Bad Firebase'),
            );
            // act
            final result = await badRepository
                .getInstructionsStream(tInstructionsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, InstructionsStream>>());
          },
        );
      });
      group('unsuspected error', () {
        test(
          'should return [UnsuspectedFailure]  when addInstruction is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.addInstruction(tInstructionParams);
            // assert
            expect(result, isA<Left<Failure, String>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when updateinstruction is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.updateInstruction(tInstructionParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when deleteInstruction is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result =
                await badRepository.deleteInstruction(tInstructionParams);
            // assert
            expect(result, isA<Left<Failure, VoidResult>>());
          },
        );
        test(
          'should return [UnsuspectedFailure] when getInstructionsStream is called',
          () async {
            // arrange
            when(() => badkFirebaseFirestore.collection(any())).thenThrow(
              Exception(),
            );
            // act
            final result = await badRepository
                .getInstructionsStream(tInstructionsInLocationsParams);
            // assert
            expect(result, isA<Left<Failure, InstructionsStream>>());
          },
        );
      });
    },
  );
}
