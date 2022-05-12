import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../domain/usecases/signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

const String AUTHENTICATION_FAILURE = 'Authentication failure';
const String REGISTRATION_FAILURE = 'Registration failure';
const String SIGNOUT_FAILURE = 'Signout failure';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late StreamSubscription streamSubscription;
  final AuthenticationRepository repository;
  final Signin signin;
  final Signup signup;
  final Signout signout;

  AuthenticationBloc({
    required this.repository,
    required this.signin,
    required this.signup,
    required this.signout,
  }) : super(Empty()) {
    streamSubscription = repository.user.listen((user) {
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
      final failureOrVoid = await signin(AuthParams(
        email: event.email,
        password: event.password,
      ));

      failureOrVoid.fold(
          (failure) => emit(Error(message: AUTHENTICATION_FAILURE)),
          (_) => emit(Authenticated()));
    });

    on<SignupEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signup(AuthParams(
        email: event.email,
        password: event.password,
      ));

      failureOrVoid.fold(
          (failure) => emit(Error(message: REGISTRATION_FAILURE)),
          (_) => emit(Registration()));
    });

    on<SignoutEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signout(NoParams());

      failureOrVoid.fold((failure) => emit(Error(message: SIGNOUT_FAILURE)),
          (_) => emit(Empty()));
    });
  }
}
