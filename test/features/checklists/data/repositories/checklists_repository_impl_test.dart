import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklists_stream.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockCollectionReferance;
  late ChecklistsRepositoryImpl repository;
  late ChecklistsRepositoryImpl badRepository;
  late ChecklistParams tChecklistParams;

  const String companyId = 'companyId';

  const tCheckpointModel = CheckpointModel(
    title: 'title',
    isChecked: false,
  );

  const tChecklistmodel = ChecklistModel(
    id: 'id',
    title: 'title',
    allCheckpoints: [tCheckpointModel],
  );

  setUp(
    () async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      badFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReferance = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('checklists');
      repository = ChecklistsRepositoryImpl(
        firebaseFirestore: fakeFirebaseFirestore,
      );
      badRepository = ChecklistsRepositoryImpl(
        firebaseFirestore: badFirebaseFirestore,
      );
      final documentReferance =
          await mockCollectionReferance.add(tChecklistmodel.toMap());

      tChecklistParams = ChecklistParams(
        checklist: tChecklistmodel.copyWith(id: documentReferance.id),
        companyId: companyId,
      );
    },
  );

  group('Checklists Repository', () {
    group('successful DB response', () {
      test(
        'should should return [String] containing checklist id when addChecklist is called',
        () async {
          // act
          final result = await repository.addChecklist(tChecklistParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should should return [VoidResult] when updateChecklist is called',
        () async {
          // act
          final result = await repository.updateChecklist(tChecklistParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should should return [VoidResult] when deleteChecklist is called',
        () async {
          // act
          final result = await repository.deleteChecklist(tChecklistParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should should return [ChecklistsStream] when getChecklistStream is called',
        () async {
          // act
          final result = await repository.getChecklistsStream(companyId);
          // assert
          expect(result, isA<Right<Failure, ChecklistsStream>>());
        },
      );
    });
    group('unsuccessful DB response', () {
      test(
        'should should return [DatabaseFailure] when addChecklist is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.addChecklist(tChecklistParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should should return [DatabaseFailure] when updateChecklist is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.updateChecklist(tChecklistParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should should return [DatabaseFailure] when deleteChecklist is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.deleteChecklist(tChecklistParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should should return [DatabaseFailure] when getChecklistStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.getChecklistsStream(companyId);
          // assert
          expect(result, isA<Left<Failure, ChecklistsStream>>());
        },
      );
    });
    group('unsuspected error', () {
      test(
        'should should return [UnsuspectedFailure] when addChecklist is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badRepository.addChecklist(tChecklistParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should should return [UnsuspectedFailure] when updateChecklist is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badRepository.updateChecklist(tChecklistParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should should return [UnsuspectedFailure] when deleteChecklist is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badRepository.deleteChecklist(tChecklistParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should should return [UnsuspectedFailure] when getChecklistStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badRepository.getChecklistsStream(companyId);
          // assert
          expect(result, isA<Left<Failure, ChecklistsStream>>());
        },
      );
    });
  });
}
