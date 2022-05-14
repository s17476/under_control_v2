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
  const SigninEvent(String email, String password)
      : super(email: email, password: password);
}

class SignupEvent extends AuthenticationEvent {
  const SignupEvent(String email, String password)
      : super(email: email, password: password);
}

class SendPasswordResetEmailEvent extends AuthenticationEvent {
  const SendPasswordResetEmailEvent(String email) : super(email: email);
}

class SignoutEvent extends AuthenticationEvent {}

class ResendVerificationEmailEvent extends AuthenticationEvent {}

class AutoSigninEvent extends AuthenticationEvent {
  const AutoSigninEvent(User? user) : super(user: user);
}
