import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../core/usecases/usecase.dart';
import '../../../user_profile/data/models/user_profile_model.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../../core/error/failures.dart';
// import '../../../core/network/network_info.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  // final NetworkInfo networkInfo;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMessaging firebaseMessaging;
  final FirebaseStorage firebaseStorage;

  AuthenticationRepositoryImpl({
    required this.firebaseAuth,
    // required this.networkInfo,
    required this.firebaseFirestore,
    required this.firebaseMessaging,
    required this.firebaseStorage,
  });

  @override
  Stream<User?> get user => firebaseAuth.authStateChanges();

  @override
  bool get isEmailVerified => firebaseAuth.currentUser!.emailVerified;

  Future<String?> _getDeviceToken() async => await firebaseMessaging.getToken();

  @override
  Future<Either<Failure, VoidResult>> signin(
      {required String email, required String password}) async {
    // if (await networkInfo.isConnected) {
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
    // } else {
    //   return const Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, VoidResult>> signout() async {
    // if (await networkInfo.isConnected) {
    final token = await _getDeviceToken();
    if (token != null) {
      final userReference = FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid);

      await firebaseFirestore.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userReference);

        if (userSnapshot.exists) {
          final user = UserProfileModel.fromSnapshot(userSnapshot);
          final deviceTokens = user.deviceTokens;
          deviceTokens.remove(token);
          final deviceTokensMap = {'deviceTokens': deviceTokens};

          transaction.update(userReference, deviceTokensMap);
        }
      });
    }

    await firebaseAuth.signOut();
    return Right(VoidResult());
    // } else {
    //   return const Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, VoidResult>> signup(
      {required String email, required String password}) async {
    // if (await networkInfo.isConnected) {
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
    // } else {
    //   return const Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, VoidResult>> sendVerificationEmail() async {
    try {
      if (firebaseAuth.currentUser != null &&
          !firebaseAuth.currentUser!.emailVerified) {
        await firebaseAuth.currentUser!.sendEmailVerification();
      }
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

  @override
  Future<Either<Failure, VoidResult>> deleteAccount(
    String password,
  ) async {
    try {
      final user = firebaseAuth.currentUser!;
      // reauthenticate with credencial
      final credential =
          EmailAuthProvider.credential(email: user.email!, password: password);
      final authResult = await user.reauthenticateWithCredential(credential);

      // delete avatar
      final userAvatar = firebaseStorage
          .ref()
          .child('avatars')
          .child('${firebaseAuth.currentUser!.uid}.jpg');
      await userAvatar.delete();

      // delete user profile
      final userProfile = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid);
      await userProfile.delete();

      // delete user account
      await authResult.user!.delete();

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
