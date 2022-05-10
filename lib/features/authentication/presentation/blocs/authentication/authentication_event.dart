part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([this.email = '', this.password = '']);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SigninEvent extends AuthenticationEvent {
  const SigninEvent(String email, String password) : super(email, password);
}

class SignupEvent extends AuthenticationEvent {
  const SignupEvent(String email, String password) : super(email, password);
}

class SignoutEvent extends AuthenticationEvent {}
