import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockSignin extends Mock implements Signin {}

class MockSignup extends Mock implements Signup {}

class MockSignout extends Mock implements Signout {}

void main() {
  late AuthenticationBloc bloc;
  late MockSignin mockSignin;
  late MockSignup mockSignup;
  late MockSignout mockSignout;

  const String email = 'test@test.com';
  const String password = '1234567';

  setUp(
    () {
      mockSignin = MockSignin();
      mockSignup = MockSignup();
      mockSignout = MockSignout();
      bloc = AuthenticationBloc(
        signin: mockSignin,
        signup: mockSignup,
        signout: mockSignout,
      );
    },
  );

  setUpAll(() {
    registerFallbackValue(const AuthParams(email: email, password: password));
    registerFallbackValue(NoParams());
  });

  test(
    'Initial state should be [Empty]',
    () {
      expect(bloc.state, equals(Empty()));
    },
  );

  group(
    'Signin',
    () {
      const AuthParams authParams =
          AuthParams(email: email, password: password);
      test(
        'should call Signin method',
        () async {
          // arrange
          when(() => mockSignin(any()))
              .thenAnswer((_) async => Right(Future.value()));
          // act
          bloc.add(const SigninEvent(email, password));
          await untilCalled(
            () => mockSignin(any()),
          );
          // assert
          verify(
            () => mockSignin(authParams),
          );
        },
      );

      test(
        'should emit [Submitting, Error] states when authentication fails',
        () async {
          // arrange
          when(
            () => mockSignin(any()),
          ).thenAnswer((_) async => const Left(AuthenticationFailure()));
          // assert later
          final expected = [
            Submitting(),
            Error(message: 'Authentication failure')
          ];
          expectLater(
            bloc.stream,
            emitsInOrder(expected),
          );
          // act
          bloc.add(const SigninEvent(email, password));
        },
      );

      test(
        'should emit [Submitting, Success] when authentication is successful',
        () async {
          // arrange
          when(
            () => mockSignin(any()),
          ).thenAnswer((_) async => Right(Future.value()));
          // assert later
          final expected = [
            Submitting(),
            Success(),
          ];
          expectLater(
            bloc.stream,
            emitsInOrder(expected),
          );
          // act
          bloc.add(const SigninEvent(email, password));
        },
      );
    },
  );

  group(
    'Signup',
    () {
      const AuthParams authParams =
          AuthParams(email: email, password: password);
      test(
        'should call Signup method',
        () async {
          // arrange
          when(() => mockSignup(any()))
              .thenAnswer((_) async => Right(Future.value()));
          // act
          bloc.add(const SignupEvent(email, password));
          await untilCalled(
            () => mockSignup(any()),
          );
          // assert
          verify(
            () => mockSignup(authParams),
          );
        },
      );

      test(
        'should emit [Submitting, Error] states when authentication fails',
        () async {
          // arrange
          when(
            () => mockSignup(any()),
          ).thenAnswer((_) async => const Left(AuthenticationFailure()));
          // assert later
          final expected = [
            Submitting(),
            Error(message: 'Registration failure')
          ];
          expectLater(
            bloc.stream,
            emitsInOrder(expected),
          );
          // act
          bloc.add(const SignupEvent(email, password));
        },
      );

      test(
        'should emit [Submitting, Registration] when authentication is successful',
        () async {
          // arrange
          when(
            () => mockSignup(any()),
          ).thenAnswer((_) async => Right(Future.value()));
          // assert later
          final expected = [
            Submitting(),
            Registration(),
          ];
          expectLater(
            bloc.stream,
            emitsInOrder(expected),
          );
          // act
          bloc.add(const SignupEvent(email, password));
        },
      );
    },
  );

  group(
    'Signout',
    () {
      NoParams noParams = NoParams();
      const AuthParams authParams =
          AuthParams(email: email, password: password);
      test(
        'should call Signout method',
        () async {
          // arrange
          when(() => mockSignout(any()))
              .thenAnswer((_) async => Right(Future.value()));
          // act
          bloc.add(SignoutEvent());
          await untilCalled(
            () => mockSignout(noParams),
          );
          // assert
          verify(
            () => mockSignout(noParams),
          );
        },
      );

      test(
        'should emit [Submitting, Error] states when signout fails',
        () async {
          // arrange
          when(
            () => mockSignout(noParams),
          ).thenAnswer((_) async => const Left(AuthenticationFailure()));
          // assert later
          final expected = [Submitting(), Error(message: 'Signout failure')];
          expectLater(
            bloc.stream,
            emitsInOrder(expected),
          );
          // act
          bloc.add(SignoutEvent());
        },
      );

      test(
        'should emit [Submitting, Empty] when signout is successful',
        () async {
          // arrange
          when(
            () => mockSignout(noParams),
          ).thenAnswer((_) async => Right(Future.value()));
          // assert later
          final expected = [
            Submitting(),
            Empty(),
          ];
          expectLater(
            bloc.stream,
            emitsInOrder(expected),
          );
          // act
          bloc.add(SignoutEvent());
        },
      );
    },
  );
}
