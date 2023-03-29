part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
}

class EmptyAuthenticationState extends AuthenticationState {}

class Submitting extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userId;
  final String email;
  final String message;

  Authenticated({
    required this.userId,
    required this.email,
    this.message = '',
  }) : super([
          userId,
          email,
          message,
        ]);

  Authenticated copyWith({
    String? userId,
    String? email,
    String? message,
  }) {
    return Authenticated(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }
}

class AwaitingVerification extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Error extends AuthenticationState {
  final String message;
  Error({
    required this.message,
  }) : super([message]);
}
