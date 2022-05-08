import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class AuthenticationRepository {
  Stream get user;

  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signout();
}
