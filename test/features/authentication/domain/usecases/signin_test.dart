import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late Signin usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = Signin(authenticationRepository: mockAuthenticationRepository);
  });

  AuthParams authParams =
      const AuthParams(email: 'test@test.com', password: '1234567');

  test(
    'should only call signin method in repository',
    () async {
      // arrange
      when(
        () => mockAuthenticationRepository.signin(
            email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async => Right(VoidResult()));
      // act
      await usecase(authParams);
      // assert

      verify(
        () => mockAuthenticationRepository.signin(
            email: authParams.email, password: authParams.password),
      );
      verifyNoMoreInteractions(mockAuthenticationRepository);
    },
  );
}
