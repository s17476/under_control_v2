import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class AuthenticationRepository {
  Stream<User?> get user;

  bool get isEmailVerified;

  Future<Either<Failure, VoidResult>> signup({
    required String email,
    required String password,
  });

  Future<Either<Failure, VoidResult>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, VoidResult>> sendPasswordResetEmail({
    required String email,
    String password,
  });

  Future<Either<Failure, VoidResult>> signout();

  Future<Either<Failure, VoidResult>> sendVerificationEmail();
}
