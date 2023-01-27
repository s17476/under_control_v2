import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/network/network_info.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockNetworkInfo mockNetworkInfo;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late AuthenticationRepositoryImpl repository;
  late FakeFirebaseFirestore fakeFirebaseFirestore;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockNetworkInfo = MockNetworkInfo();
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    mockFirebaseMessaging = MockFirebaseMessaging();
    repository = AuthenticationRepositoryImpl(
      firebaseFirestore: fakeFirebaseFirestore,
      firebaseMessaging: mockFirebaseMessaging,
      firebaseAuth: mockFirebaseAuth,
      networkInfo: mockNetworkInfo,
    );
  });

  group('Authentication device is offline', () {
    setUp(
      () {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      },
    );
    AuthParams tAuthParams =
        const AuthParams(email: 'test@test.com', password: '1234567');
    test(
      'should check if device is offline',
      () async {
        // act
        await repository.signin(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return [NetworkFailure] if called signin method',
      () async {
        // arrange

        // act
        final result = await repository.signin(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );

    test(
      'should return NetworkFailure if called signup method',
      () async {
        // act
        final result = await repository.signup(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );

    test(
      'should return NetworkFailure if called signout method',
      () async {
        // act
        final result = await repository.signout();
        // assert
        expect(result, const Left(NetworkFailure()));
      },
    );
  });

  group('Authentication device is online and error is thrown', () {
    setUp(
      () {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      },
    );
    AuthParams tAuthParams =
        const AuthParams(email: 'test@test.com', password: '1234567');
    test(
      'should check if device is online',
      () async {
        // act
        await repository.signin(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return AuthenticationFailure if called signin method and FirebaseAuthException is thrown',
      () async {
        // arrange
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: ''));
        // act
        final result = await repository.signin(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        verify(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tAuthParams.email,
            password: tAuthParams.password,
          ),
        );
        expect(
          result,
          const Left<Failure, VoidResult>(
            AuthenticationFailure(message: 'Authentication error'),
          ),
        );
      },
    );

    test(
      'should return UnsuspectedFailure if called signin method and Exception is thrown',
      () async {
        // arrange
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        // act
        final result = await repository.signin(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        verify(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tAuthParams.email,
            password: tAuthParams.password,
          ),
        );
        expect(
          result,
          const Left<Failure, VoidResult>(
            UnsuspectedFailure(message: 'Unsuspected error'),
          ),
        );
      },
    );

    test(
      'should return AuthenticationFailure if called signup method and FirebaseAuthException is thrown',
      () async {
        // arrange
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: ''));
        // act
        final result = await repository.signup(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        verify(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tAuthParams.email,
            password: tAuthParams.password,
          ),
        );
        expect(
          result,
          const Left<Failure, VoidResult>(
            AuthenticationFailure(message: 'Authentication error'),
          ),
        );
      },
    );

    test(
      'should return UnsuspectedFailure if called signup method and Exception is thrown',
      () async {
        // arrange
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        // act
        final result = await repository.signup(
          email: tAuthParams.email,
          password: tAuthParams.password,
        );
        // assert
        verify(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tAuthParams.email,
            password: tAuthParams.password,
          ),
        );
        expect(
          result,
          const Left<Failure, VoidResult>(
            UnsuspectedFailure(message: 'Unsuspected error'),
          ),
        );
      },
    );
  });
}
