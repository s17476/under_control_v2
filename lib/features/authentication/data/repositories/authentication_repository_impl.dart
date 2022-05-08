import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.firebaseAuth,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> signin(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return Right(Future.value());
      } on FirebaseAuthException catch (e) {
        return const Left(AuthenticationFailure());
      } catch (e) {
        return const Left(UnsuspectedFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signout() async {
    if (await networkInfo.isConnected) {
      await firebaseAuth.signOut();
      return Right(Future.value());
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signup(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        return Right(Future.value());
      } on FirebaseAuthException catch (e) {
        return const Left(AuthenticationFailure());
      } catch (e) {
        return const Left(UnsuspectedFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Stream<User?> get user => firebaseAuth.userChanges();
}
