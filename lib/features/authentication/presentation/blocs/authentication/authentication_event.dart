part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent({this.email = '', this.password = '', this.user});

  final String email;
  final String password;
  final User? user;

  @override
  List<Object> get props => [email, password];
}

class SigninEvent extends AuthenticationEvent {
  const SigninEvent({super.email, super.password});
}

class SignupEvent extends AuthenticationEvent {
  const SignupEvent({super.email, super.password});
}

class SendPasswordResetEmailEvent extends AuthenticationEvent {
  const SendPasswordResetEmailEvent({super.email});
}

class SignoutEvent extends AuthenticationEvent {}

class DeleteAccountEvent extends AuthenticationEvent {
  const DeleteAccountEvent({super.password});
}

class ResendVerificationEmailEvent extends AuthenticationEvent {}

class AutoSigninEvent extends AuthenticationEvent {
  const AutoSigninEvent({super.user});
}
