import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({this.message = ''});
}

/// Authentication service failure
class AuthenticationFailure extends Failure {
  final String message;
  const AuthenticationFailure({this.message = ''}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

/// General failures
class UnsuspectedFailure extends Failure {
  final String message;
  const UnsuspectedFailure({this.message = ''}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;
  const NetworkFailure({this.message = ''}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure({this.message = ''}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class DataBaseFailure extends Failure {
  final String message;
  const DataBaseFailure({this.message = ''}) : super(message: message);

  @override
  List<Object?> get props => [message];
}
