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
