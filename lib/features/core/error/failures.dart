import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({this.message = ''});

  @override
  List<Object?> get props => [message];
}

/// Authentication service failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({message = ''}) : super(message: message);
}

/// General failures
class UnsuspectedFailure extends Failure {
  const UnsuspectedFailure({message = ''}) : super(message: message);
}

class DeleteFailure extends Failure {
  const DeleteFailure({message = ''}) : super(message: message);
}

class CategoryNotEmptyFailure extends Failure {
  const CategoryNotEmptyFailure({message = ''}) : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({message = ''}) : super(message: message);
}

class ValidationFailure extends Failure {
  const ValidationFailure({message = ''}) : super(message: message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({message = ''}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({message = ''}) : super(message: message);
}
