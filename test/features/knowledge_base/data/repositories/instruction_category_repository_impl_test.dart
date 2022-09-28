import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/item_category/instruction_category_model.dart';
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_category/instructions_categories_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockCollectionReferance;
  late InstructionCategoryRepositoryImpl repository;
  late InstructionCategoryRepositoryImpl badRepository;
  late InstructionCategoryParams tParams;

  const String companyId = 'companyId';

  const tInstructionCategory = InstructionCategoryModel(
    id: 'id',
    name: 'name',
  );

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReferance = fakeFirebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('instructionsCategories');
    repository = InstructionCategoryRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badRepository = InstructionCategoryRepositoryImpl(
      firebaseFirestore: badFirebaseFirestore,
    );
    final documentReference = await mockCollectionReferance.add(
      tInstructionCategory.toMap(),
    );

    tParams = InstructionCategoryParams(
      instructionCategory: tInstructionCategory.copyWith(
        id: documentReference.id,
      ),
      companyId: companyId,
    );
  });

  group('Knowledge Base InstructionCategoryRepositoryImpl', () {
    group('successful database response', () {
      test(
        'should return [String] containing item category id when addInstructionCategory is called',
        () async {
          // act
          final result = await repository.addInstructionCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [VoidResult]  when deleteInstructionCategory is called',
        () async {
          // act
          final result = await repository.deleteInstructionCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult]  when updateInstructionCategory is called',
        () async {
          // act
          final result = await repository.updateInstructionCategory(tParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [InstructionsCategoriesStream]  when getInstructionsCategoriesStream is called',
        () async {
          // act
          final result =
              await repository.getInstructionsCategoriesStream(companyId);
          // assert
          expect(result, isA<Right<Failure, InstructionsCategoriesStream>>());
        },
      );
    });
    group('unsuccessful database response', () {
      test(
        'should return [DatabaseFailure]  when addInstructionCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.addInstructionCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when deleteInstructionCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.deleteInstructionCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when updateInstructionCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result = await badRepository.updateInstructionCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]  when getInstructionsCategoriesStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            FirebaseException(plugin: 'Bad Firestore'),
          );
          // act
          final result =
              await badRepository.getInstructionsCategoriesStream(companyId);
          // assert
          expect(result, isA<Left<Failure, InstructionsCategoriesStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should return [UnsuspectedFailure]  when addInstructionCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.addInstructionCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when deleteInstructionCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.deleteInstructionCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when updateInstructionCategory is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result = await badRepository.updateInstructionCategory(tParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]  when getInstructionsCategoriesStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any())).thenThrow(
            Exception(),
          );
          // act
          final result =
              await badRepository.getInstructionsCategoriesStream(companyId);
          // assert
          expect(result, isA<Left<Failure, InstructionsCategoriesStream>>());
        },
      );
    });
  });
}
