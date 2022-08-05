import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_stream.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../models/user_profile_model.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl extends UserProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  UserProfileRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, VoidResult>> addUser(UserProfile userProfile) async {
    try {
      final usersReference =
          firebaseFirestore.collection('users').doc(userProfile.id);
      final userMap = (userProfile as UserProfileModel).toMap();
      await usersReference.set(userMap);
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
  Future<Either<Failure, VoidResult>> makeUserAdministrator(
      String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
        'administrator': true,
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
  Future<Either<Failure, VoidResult>> unmakeUserAdministrator(
      String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
        'administrator': false,
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
  Future<Either<Failure, VoidResult>> approveUserAndMakeAdmin(
      String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
        'approved': true,
        'administrator': true,
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
  Future<Either<Failure, VoidResult>> resetCompany(String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({'companyId': ''});
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
  Future<Either<Failure, UserStream>> getUserStreamById(String userId) async {
    try {
      final userSnapshot =
          firebaseFirestore.collection('users').doc(userId).snapshots();

      return Right(UserStream(userStream: userSnapshot));
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
  Future<Either<Failure, VoidResult>> unsuspendUser(String userId) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(userId);
      await userReference.update({
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

  @override
  Future<Either<Failure, VoidResult>> assignUserToGroup(
      UserAndGroupParams params) async {
    final groupMap = {
      'userGroups': FieldValue.arrayUnion([params.groupId])
    };
    try {
      final userReference =
          firebaseFirestore.collection('users').doc(params.userId);
      await userReference.update(groupMap);
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
  Future<Either<Failure, VoidResult>> unassignUserFromGroup(
      UserAndGroupParams params) async {
    final groupMap = {
      'userGroups': FieldValue.arrayRemove([params.groupId])
    };
    try {
      final userReference =
          firebaseFirestore.collection('users').doc(params.userId);
      await userReference.update(groupMap);
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
  Future<Either<Failure, VoidResult>> assignGroupAdmin(
      AssignGroupAdminParams params) async {
    final adminMap = {
      'groupAdministrators': FieldValue.arrayUnion([params.userId])
    };
    try {
      final groupReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('groups')
          .doc(params.groupId);
      await groupReference.update(adminMap);
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
  Future<Either<Failure, VoidResult>> unassignGroupAdmin(
      AssignGroupAdminParams params) async {
    final adminMap = {
      'groupAdministrators': FieldValue.arrayRemove([params.userId])
    };
    try {
      final groupReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('groups')
          .doc(params.groupId);
      await groupReference.update(adminMap);
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
