import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../domain/usecases/signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Signin signin;
  final Signup signup;
  final Signout signout;

  AuthenticationBloc({
    required this.signin,
    required this.signup,
    required this.signout,
  }) : super(Empty()) {
    on<SigninEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signin(AuthParams(
        email: event.email,
        password: event.password,
      ));

      failureOrVoid.fold(
          (failure) => emit(Error(message: 'Authentication failure')),
          (_) => emit(Success()));
    });

    on<SignupEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signup(AuthParams(
        email: event.email,
        password: event.password,
      ));

      failureOrVoid.fold(
          (failure) => emit(Error(message: 'Registration failure')),
          (_) => emit(Registration()));
    });

    on<SignoutEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signout(NoParams());

      failureOrVoid.fold((failure) => emit(Error(message: 'Signout failure')),
          (_) => emit(Empty()));
    });
  }
}
