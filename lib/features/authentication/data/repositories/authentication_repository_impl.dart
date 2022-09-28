import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/usecases/usecase.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.firebaseAuth,
    required this.networkInfo,
  });

  @override
  Stream<User?> get user => firebaseAuth.userChanges();

  @override
  bool get isEmailVerified => firebaseAuth.currentUser!.emailVerified;

  @override
  Future<Either<Failure, VoidResult>> signin(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return Right(VoidResult());
      } on FirebaseAuthException catch (e) {
        return Left(
          AuthenticationFailure(message: e.message ?? 'Authentication error'),
        );
      } catch (e) {
        return const Left(
          UnsuspectedFailure(message: 'Unsuspected error'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, VoidResult>> signout() async {
    if (await networkInfo.isConnected) {
      await firebaseAuth.signOut();
      return Right(VoidResult());
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, VoidResult>> signup(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        return Right(VoidResult());
      } on FirebaseAuthException catch (e) {
        return Left(
          AuthenticationFailure(message: e.message ?? 'Authentication error'),
        );
      } catch (e) {
        return const Left(
          UnsuspectedFailure(message: 'Unsuspected error'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, VoidResult>> sendVerificationEmail() async {
    try {
      if (firebaseAuth.currentUser != null &&
          !firebaseAuth.currentUser!.emailVerified) {
        await firebaseAuth.currentUser!.sendEmailVerification();
      } else {}
      return Right(VoidResult());
    } on FirebaseAuthException catch (e) {
      return Left(
        AuthenticationFailure(message: e.message ?? 'Authentication error'),
      );
    } catch (e) {
      return const Left(UnsuspectedFailure(message: 'Unsuspected error'));
    }
  }

  @override
  Future<Either<Failure, VoidResult>> sendPasswordResetEmail(
      {required String email, String password = ''}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Right(VoidResult());
    } on FirebaseAuthException catch (e) {
      return Left(
        AuthenticationFailure(message: e.message ?? 'Authentication error'),
      );
    } catch (e) {
      return const Left(UnsuspectedFailure(message: 'Unsuspected error'));
    }
  }
}
