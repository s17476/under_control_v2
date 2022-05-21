import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/check_email_verification.dart';
import '../../../domain/usecases/send_password_reset_email.dart';
import '../../../domain/usecases/send_verification_email.dart';
import '../../../domain/usecases/auto_signin.dart';
import '../../../domain/usecases/signin.dart';
import '../../../domain/usecases/signout.dart';
import '../../../domain/usecases/signup.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/input_validator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

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
  final SendPasswordResetEmail sendPasswordResetEmail;
  final InputValidator inputValidator;

  AuthenticationBloc({
    required this.signin,
    required this.signup,
    required this.signout,
    required this.autoSignin,
    required this.sendVerificationEmail,
    required this.checkEmailVerification,
    required this.sendPasswordResetEmail,
    required this.inputValidator,
  }) : super(EmptyAuthenticationState()) {
    streamSubscription = autoSignin().listen((user) {
      add(AutoSigninEvent(user));
    });

    on<AutoSigninEvent>(
      (event, emit) async {
        if (event.user == null) {
          emit(Unauthenticated());
        } else if (event.user != null) {
          if (checkEmailVerification()) {
            emit(Authenticated(userId: event.user!.uid));
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
                emit(Authenticated(userId: event.user!.uid));
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
                emit(Authenticated(userId: event.user!.uid));
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

    on<SendPasswordResetEmailEvent>((event, emit) async {
      final failureOrVoid = await sendPasswordResetEmail(
          AuthParams(email: event.email, password: ''));

      failureOrVoid.fold(
        (failure) => emit(Error(message: failure.message)),
        (_) => emit(Error(message: 'password-reset')),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
