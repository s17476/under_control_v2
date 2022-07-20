import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late UserProfileRepositoryImpl repository;
  late CollectionReference mockCollectionReference;
  late UserProfileRepositoryImpl badRepository;
  late MockFirebaseFirestore badFirebaseFirestoreInstance;

  setUp(
    () {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      repository = UserProfileRepositoryImpl(
        firebaseFirestore: fakeFirebaseFirestore,
      );
      mockCollectionReference = fakeFirebaseFirestore.collection('users');
      badFirebaseFirestoreInstance = MockFirebaseFirestore();
      badRepository = UserProfileRepositoryImpl(
          firebaseFirestore: badFirebaseFirestoreInstance);
    },
  );

  const tUserProfile = UserProfileModel(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    phoneNumber: 'phoneNumber',
    avatarUrl: 'avatarUrl',
    userGroups: ['userGroups'],
    locations: ['locations'],
    companyId: 'companyId',
    approved: false,
    rejected: false,
    suspended: false,
    administrator: false,
  );

  group(
    'UserPorfile successful database response',
    () {
      test(
        'should return a [VoidResult] with user id when addUser is called',
        () async {
          // act
          final result = await repository.addUser(tUserProfile);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return a [VoidResult] with user id when resetCompany is called',
        () async {
          // act
          final result = await repository.resetCompany(tUserProfile.id);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [VoidResult] when approveUser is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          // act
          final result = await repository.approveUser(userReferance.id);
          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );

      test(
        'should return a [VoidResult] when approveUserAndMakeAdmin is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          // act
          final result =
              await repository.approveUserAndMakeAdmin(userReferance.id);
          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );

      test(
        'should return a [VoidResult] when assignUserToCompany is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          // act
          final result = await repository.assignUserToCompany(
              AssignParams(userId: userReferance.id, companyId: 'companyId'));
          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );

      test(
        'should return a [UserProfile] when getuserById is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          final UserProfileModel tUserProfileWithGeneratedId =
              tUserProfile.copyWith(id: userReferance.id);
          // act
          final result = await repository.getUserById(userReferance.id);

          // assert
          expect(
              result, Right<Failure, UserProfile>(tUserProfileWithGeneratedId));
        },
      );

      test(
        'should return a [VoidResult] when rejectUser is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          // act
          final result = await repository.rejectUser(userReferance.id);
          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );

      test(
        'should return a [VoidResult] when suspendUser is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          // act
          final result = await repository.suspendUser(userReferance.id);
          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );

      test(
        'should return a [Voidresult] when updateUserData is called',
        () async {
          // arrange
          final userReferance =
              await mockCollectionReference.add(tUserProfile.toMap());
          final UserProfileModel tUserProfileWithGeneratedId =
              tUserProfile.copyWith(id: userReferance.id);
          // act
          final result =
              await repository.updateUserdata(tUserProfileWithGeneratedId);
          // assert
          expect(result, Right<Failure, VoidResult>(VoidResult()));
        },
      );
    },
  );

  group(
    'UserPorfile unsuccessful database response',
    () {
      test(
        'should return a [DatabaseFailure] when addUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.addUser(tUserProfile);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when resetCompany is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.resetCompany('');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return a [DatabaseFailure] when approveUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.approveUser('');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when approveUserAndMakeAdmin is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.approveUserAndMakeAdmin('');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when assignUserToCompany is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.assignUserToCompany(
              const AssignParams(userId: 'userId', companyId: 'companyId'));
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when getuserById is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.getUserById('userReferance.id');

          // assert
          expect(result, isA<Left<Failure, UserProfile>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when rejectUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.rejectUser('userReferance.id');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when suspendUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.suspendUser('userReferance.id');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [DatabaseFailure] when updateUserData is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badRepository.updateUserdata(tUserProfile);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    },
  );

  group(
    'UserPorfile unsuspected error',
    () {
      test(
        'should return a [UnsuspectedFailure] when addUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.addUser(tUserProfile);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when resetCompany is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.resetCompany('');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when approveUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.approveUser('');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when approveUserAndmakeAdmin is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.approveUserAndMakeAdmin('');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when assignUserToCompany is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.assignUserToCompany(
              const AssignParams(userId: 'userId', companyId: 'companyId'));
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when getuserById is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.getUserById('userReferance.id');

          // assert
          expect(result, isA<Left<Failure, UserProfile>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when rejectUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.rejectUser('userReferance.id');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when suspendUser is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.suspendUser('userReferance.id');
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return a [UnsuspectedFailure] when updateUserData is called',
        () async {
          // arrange
          when(
            () => badFirebaseFirestoreInstance.collection(any()),
          ).thenThrow(Exception());
          // act
          final result = await badRepository.updateUserdata(tUserProfile);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    },
  );
}
