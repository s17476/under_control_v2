import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late CompanyManagementRepositoryImpl repository;
  late CompanyManagementRepositoryImpl badRepository;
  late MockFirebaseFirestore badFirebaseFirestoreInstance;
  late MockFirebaseStorage mockFirebaseStorage;

  fakeFirebaseFirestore = FakeFirebaseFirestore();
  mockFirebaseStorage = MockFirebaseStorage();
  repository = CompanyManagementRepositoryImpl(
    firebaseFirestore: fakeFirebaseFirestore,
    firebaseStorage: mockFirebaseStorage,
  );
  badFirebaseFirestoreInstance = MockFirebaseFirestore();
  badRepository = CompanyManagementRepositoryImpl(
    firebaseFirestore: badFirebaseFirestoreInstance,
    firebaseStorage: mockFirebaseStorage,
  );

  final tCompany = CompanyModel.initial();

  group('successful database response', () {
    test(
      'should return [String] when addCompany is called',
      () async {
        // act
        final result = await repository.addCompany(tCompany);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );

    test(
      'should return [Companies] when fetchAllCompanies is called',
      () async {
        // act
        final result = await repository.fetchAllCompanies();
        // assert
        expect(result, isA<Right<Failure, Companies>>());
      },
    );
  });

  group('unsuccessful database response', () {
    test(
      'should return [DatabaseFailure] when addCompany is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(FirebaseException(plugin: 'test'));
        // act
        final result = await badRepository.addCompany(tCompany);
        // assert
        expect(result, isA<Left<Failure, String>>());
      },
    );

    test(
      'should return [DatabaseFailure] when fetchAllCompanies is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(FirebaseException(plugin: 'test'));
        // act
        final result = await badRepository.fetchAllCompanies();
        // assert
        expect(result, isA<Left<Failure, Companies>>());
      },
    );
  });

  group('unsuspected error', () {
    test(
      'should return [UnsuspectedFailure] when addCompany is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(Exception());
        // act
        final result = await badRepository.addCompany(tCompany);
        // assert
        expect(result, isA<Left<Failure, String>>());
      },
    );

    test(
      'should return [UnsuspectedFailure] when fetchAllCompanies is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(Exception());
        // act
        final result = await badRepository.fetchAllCompanies();
        // assert
        expect(result, isA<Left<Failure, Companies>>());
      },
    );
  });
}
