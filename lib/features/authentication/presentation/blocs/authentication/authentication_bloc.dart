import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart';
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
  final SendVerificationEmail sendVerificationEmail;
  final CheckEmailVerification checkEmailVerification;
  final InputValidator inputValidator;

  AuthenticationBloc({
    required this.signin,
    required this.signup,
    required this.signout,
    required this.autoSignin,
    required this.sendVerificationEmail,
    required this.checkEmailVerification,
    required this.inputValidator,
  }) : super(Empty()) {
    streamSubscription = autoSignin().listen((user) {
      add(AutoSigninEvent(user));
    });

    on<AutoSigninEvent>(
      (event, emit) async {
        if (event.user == null) {
          emit(Unauthenticated());
        } else if (event.user != null) {
          if (checkEmailVerification()) {
            emit(Authenticated());
          } else {
            emit(AwaitingVerification());
          }
        }
      },
    );

    on<ResendVerificationEmailEvent>((event, emit) {
      sendVerificationEmail(NoParams());
    });

    on<SigninEvent>((event, emit) async {
      emit(Submitting());
      final failureOrAuthParam =
          inputValidator.signinAndSignupValidator(event.email, event.password);
      await failureOrAuthParam.fold(
        (failure) async => emit(Error(message: failure.message)),
        (authParams) async {
          final failureOrVoid = await signin(authParams);

          failureOrVoid
              .fold((failure) async => emit(Error(message: failure.message)),
                  (_) async {
            if (event.user != null) {
              if (checkEmailVerification()) {
                emit(Authenticated());
              } else {
                emit(AwaitingVerification());
              }
            }
          });
        },
      );
    });

    on<SignupEvent>((event, emit) async {
      emit(Submitting());
      final failureOrAuthParam =
          inputValidator.signinAndSignupValidator(event.email, event.password);
      await failureOrAuthParam.fold(
        (failure) async => emit(Error(message: failure.message)),
        (authParams) async {
          final failureOrVoid = await signup(authParams);

          failureOrVoid
              .fold((failure) async => emit(Error(message: failure.message)),
                  (_) async {
            if (event.user != null) {
              if (checkEmailVerification()) {
                emit(Authenticated());
              } else {
                sendVerificationEmail(NoParams());
                emit(AwaitingVerification());
              }
            }
          });
        },
      );
    });

    on<SignoutEvent>((event, emit) async {
      emit(Submitting());
      final failureOrVoid = await signout(NoParams());

      failureOrVoid.fold(
        (failure) => emit(Error(message: failure.message)),
        (_) => emit(Unauthenticated()),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
