import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late Signup usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = Signup(authenticationRepository: mockAuthenticationRepository);
  });

  AuthParams authParams =
      const AuthParams(email: 'test@test.com', password: '1234567');

  test(
    'Authentication should only call signup method in repository',
    () async {
      // arrange
      when(
        () => mockAuthenticationRepository.signup(
            email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async => Right(VoidResult()));
      // act
      await usecase(authParams);
      // assert

      verify(
        () => mockAuthenticationRepository.signup(
            email: authParams.email, password: authParams.password),
      );
      verifyNoMoreInteractions(mockAuthenticationRepository);
    },
  );
}
