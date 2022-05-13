import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';

abstract class AuthenticationRepository {
  Stream<User?> get user;

  bool get isEmailVerified;

  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signout();

  Future<Either<Failure, void>> sendVerificationEmail();
}
