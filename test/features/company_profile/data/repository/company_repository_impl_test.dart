import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_user_model.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_users_model.dart';
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/network/network_info.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  final dateTime = DateTime.now();

  // final List<Company> companies = [tCompanyModel];

  // late MockFirebaseFirestore mockFirebaseFirstore;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockNetworkInfo mockNetworkInfo;
  late CompanyRepositoryImpl repository;
  late CollectionReference mockCollectionReference;

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    mockNetworkInfo = MockNetworkInfo();
    repository = CompanyRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
      networkInfo: mockNetworkInfo,
    );
    mockCollectionReference = fakeFirebaseFirestore.collection('companies');
  });

  group('device is offline', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    final tCompanyModel = CompanyModel(
      id: 'id',
      name: 'name',
      address: 'address',
      postCode: 'postCode',
      city: 'city',
      country: 'country',
      vatNumber: 'vatNumber',
      phoneNumber: 'phoneNumber',
      email: 'email',
      homepage: 'homepage',
      joinDate: dateTime,
    );

    test(
      'should check if device is offline',
      () async {
        // act
        await repository.fetchAllCompanies();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return [NetworkFailure] if called fetchAllCompanies method',
      () async {
        // act
        final result = await repository.fetchAllCompanies();
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );

    test(
      'should return [NetworkFailure] if called getCompanyById method',
      () async {
        // act
        final result = await repository.getCompanyById('');
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );

    test(
      'should return [NetworkFailure] if called addCompany method',
      () async {
        // act
        final result = await repository.addCompany(tCompanyModel);
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );

    test(
      'should return [NetworkFailure] if called updateCompany method',
      () async {
        // act
        final result = await repository.updateCompany(tCompanyModel);
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );

    test(
      'should return [NetworkFailure] if called fetchAllCompanyUsers method',
      () async {
        // act
        final result = await repository.fetchAllCompanyUsers('');
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );
  });

  group('device is online', () {
    late String companyId;

    CompanyModel tCompanyModel = CompanyModel(
      id: 'id',
      name: 'name',
      address: 'address',
      postCode: 'postCode',
      city: 'city',
      country: 'country',
      vatNumber: 'vatNumber',
      phoneNumber: 'phoneNumber',
      email: 'email',
      homepage: 'homepage',
      joinDate: dateTime,
    );

    CompanyUserModel tCompanyUserModel = const CompanyUserModel(
      id: 'id',
      firstName: 'firstName',
      lastName: 'lastName',
      avatarUrl: 'avatarUrl',
    );

    setUp(() async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // adds a company with known document id to fake Firebase Firestore
      final DocumentReference documentReferance =
          await mockCollectionReference.add(tCompanyModel.toMap());
      companyId = documentReferance.id;
      tCompanyModel = tCompanyModel.copyWith(id: companyId);

      // adds a user with known company id to fake Firebase Firestore
      final Map<String, dynamic> tUser = tCompanyUserModel.toMap();
      tUser.addAll({'companyId': companyId});
      fakeFirebaseFirestore.collection('users').add(tUser);
    });

    group('successful database response', () {
      test(
        'should check if device is online',
        () async {
          // act
          await repository.fetchAllCompanies();
          // assert
          verify(() => mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return [Companies] if called fetchAllCompanies method',
        () async {
          // act
          final result = await repository.fetchAllCompanies();
          // assert
          expect(
              result,
              equals(
                  Right<Failure, Companies>(Companies(data: [tCompanyModel]))));
        },
      );

      test(
        'should return [Company] if called getCompanyById method',
        () async {
          // act
          final result = await repository.getCompanyById(companyId);
          // assert
          expect(result, Right<Failure, Company>(tCompanyModel));
        },
      );

      test(
        'should return [VoidResult] if called updateCompany method',
        () async {
          // act
          final result = await repository.updateCompany(tCompanyModel);

          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );

      test(
        'should return from database all users with concrete companyId',
        () async {
          // act
          final result = await repository.fetchAllCompanyUsers(companyId);
          // assert
          expect(
            result,
            Right<Failure, CompanyUsers>(
              CompanyUsersModel(allUsers: [tCompanyUserModel]),
            ),
          );
        },
      );

      test(
        'should return document id [String] if called addCompany method',
        () async {
          // act
          fakeFirebaseFirestore.collection('companies').doc(companyId).delete();
          final result = await repository.addCompany(tCompanyModel);
          final snapshot =
              (await fakeFirebaseFirestore.collection('companies').get())
                  .docs
                  .first;

          // assert
          expect(result, Right<Failure, String>(snapshot.id));
        },
      );
    });
  });
}
