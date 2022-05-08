import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

/// Authentication service failure
class AuthenticationFailure extends Failure {
  final List properties;
  const AuthenticationFailure([this.properties = const []]) : super(properties);

  @override
  List<Object?> get props => properties;
}

/// General failures
class UnsuspectedFailure extends Failure {
  final List properties;
  const UnsuspectedFailure([this.properties = const []]) : super(properties);

  @override
  List<Object?> get props => properties;
}

class NetworkFailure extends Failure {
  final List properties;
  const NetworkFailure([this.properties = const []]) : super(properties);

  @override
  List<Object?> get props => properties;
}
