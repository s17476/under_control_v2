import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
