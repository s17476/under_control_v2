import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/utils/input_validator.dart';

import '../../../domain/usecases/auto_signin.dart';
import '../../../domain/usecases/signin.dart';
import '../../../domain/usecases/signout.dart';
import '../../../../core/usecases/usecase.dart';

import '../../../domain/usecases/signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// const String AUTHENTICATION_FAILURE = 'Authentication failurexxxx';
const String REGISTRATION_FAILURE = 'Registration failure';
const String SIGNOUT_FAILURE = 'Signout failure';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late StreamSubscription streamSubscription;
  final Signin signin;
  final Signup signup;
  final Signout signout;
  final AutoSignin autoSignin;
  final InputValidator inputValidator;

  AuthenticationBloc({
    required this.signin,
    required this.signup,
    required this.signout,
    required this.autoSignin,
    required this.inputValidator,
  }) : super(Empty()) {
    streamSubscription = autoSignin().listen((user) {
      add(AutoSigninEvent(user));
    });

    on<AutoSigninEvent>(
      (event, emit) {
        if (event.user == null) {
          emit(Unauthenticated());
        } else {
          emit(Authenticated());
        }
      },
    );

    on<SigninEvent>((event, emit) async {
      emit(Submitting());
      final failureOrAuthParam =
          inputValidator.signinAndSignupValidator(event.email, event.password);
      print(failureOrAuthParam);
      await failureOrAuthParam.fold(
        (failure) async => emit(Error(message: failure.message)),
        (authParams) async {
          final failureOrVoid = await signin(authParams);

          failureOrVoid.fold(
              (failure) async => emit(Error(message: failure.message)),
              (_) async => emit(Authenticated()));
        },
      );
    });

    on<SignupEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signup(
        AuthParams(
          email: event.email,
          password: event.password,
        ),
      );

      failureOrVoid.fold((failure) => emit(Error(message: failure.message)),
          (_) => emit(Registration()));
    });

    on<SignoutEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signout(NoParams());

      failureOrVoid.fold(
        (failure) => emit(Error(message: failure.message)),
        (_) => emit(Empty()),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
