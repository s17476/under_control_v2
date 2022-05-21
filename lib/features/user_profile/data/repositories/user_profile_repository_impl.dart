import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl extends UserProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  UserProfileRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addUser(UserProfile userProfile) async {
    try {
      final usersReference = firebaseFirestore.collection('users');
      final userMap = (userProfile as UserProfileModel).toMap();
      final documentReferance = await usersReference.add(userMap);
      final String generatedUserId = documentReferance.id;
      return Right(generatedUserId);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> approveUser(String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
        'approved': true,
        'rejected': false,
        'suspended': false,
      });
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> assignUserToCompany(
      AssignParams assignParams) async {
    try {
      final userReference =
          firebaseFirestore.collection('users').doc(assignParams.userId);
      await userReference.update({'companyId': assignParams.companyId});
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getUserById(String userId) async {
    try {
      final userSnapshot =
          await firebaseFirestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        final UserProfile userProfile =
            UserProfileModel.fromMap(userSnapshot.data()!, userSnapshot.id);
        return Right(userProfile);
      } else {
        throw Exception(['No user found for the given ID']);
      }
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> rejectUser(String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
        'approved': false,
        'rejected': true,
        'suspended': false,
      });
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> suspendUser(String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
        'suspended': true,
      });
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateUserdata(
      UserProfile userProfile) async {
    try {
      final userReference =
          firebaseFirestore.collection('users').doc(userProfile.id);
      await userReference.update((userProfile as UserProfileModel).toMap());
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }
}
