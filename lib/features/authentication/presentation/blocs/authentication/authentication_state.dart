part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
}

class Empty extends AuthenticationState {}

class Submitting extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class AwaitingVerification extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Error extends AuthenticationState {
  final String message;
  Error({
    required this.message,
  }) : super([message]);
}
