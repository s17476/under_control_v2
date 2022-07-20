import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late CompanyRepositoryImpl repository;
  late CompanyRepositoryImpl badRepository;
  late MockFirebaseFirestore badFirebaseFirestoreInstance;
  late CollectionReference mockCollectionReference;

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    repository = CompanyRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
    );
    badFirebaseFirestoreInstance = MockFirebaseFirestore();
    badRepository = CompanyRepositoryImpl(
      firebaseFirestore: badFirebaseFirestoreInstance,
    );
    mockCollectionReference = fakeFirebaseFirestore.collection('companies');
  });

  final tCompany = CompanyModel.initial();

  group('Company Profile successful database response', () {
    test(
      'should return [Company] when getCompanyById is called',
      () async {
        // arrange
        final companyReferance =
            await mockCollectionReference.add(tCompany.toMap());
        // act
        final result = await repository.getCompanyById(companyReferance.id);
        // assert
        expect(result, isA<Right<Failure, Company>>());
      },
    );

    test(
      'should return [VoidResult] when updateCompany is called',
      () async {
        // arrange
        final companyReferance =
            await mockCollectionReference.add(tCompany.toMap());
        // act
        final result = await repository
            .updateCompany(tCompany.copyWith(id: companyReferance.id));
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );

    test(
      'should return [CompanyUsers] when fetchAllCompanyUsers is called',
      () async {
        // arrange
        final companyReferance =
            await mockCollectionReference.add(tCompany.toMap());
        // act
        final result =
            await repository.fetchAllCompanyUsers(companyReferance.id);
        // assert
        expect(result, isA<Right<Failure, CompanyUsers>>());
      },
    );
  });

  group('Company Profile unsuccessful database response', () {
    test(
      'should return [DatabaseFailure] when getCompanyById is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(FirebaseException(plugin: 'test'));
        // act
        final result = await badRepository.getCompanyById('');
        // assert
        expect(result, isA<Left<Failure, Company>>());
      },
    );

    test(
      'should return [DatabaseFailure] when updateCompany is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(FirebaseException(plugin: 'test'));
        // act
        final result = await badRepository.updateCompany(tCompany);
        // assert
        expect(result, isA<Left<Failure, VoidResult>>());
      },
    );

    test(
      'should return [DatabaseFailure] when fetchAllCompanyUsers is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(FirebaseException(plugin: 'test'));
        // act
        final result = await badRepository.fetchAllCompanyUsers('');
        // assert
        expect(result, isA<Left<Failure, CompanyUsers>>());
      },
    );
  });

  group('Company Profile unsuspected failure', () {
    test(
      'should return [unsuspectedFailure] when getCompanyById is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(Exception());
        // act
        final result = await badRepository.getCompanyById('');
        // assert
        expect(result, isA<Left<Failure, Company>>());
      },
    );

    test(
      'should return [UnsuspectedFailure] when updateCompany is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(Exception());
        // act
        final result = await badRepository.updateCompany(tCompany);
        // assert
        expect(result, isA<Left<Failure, VoidResult>>());
      },
    );

    test(
      'should return [UnsuspectedFailure] when fetchAllCompanyUsers is called',
      () async {
        // arrange
        when(() => badFirebaseFirestoreInstance.collection(any()))
            .thenThrow(Exception());
        // act
        final result = await badRepository.fetchAllCompanyUsers('');
        // assert
        expect(result, isA<Left<Failure, CompanyUsers>>());
      },
    );
  });
}
