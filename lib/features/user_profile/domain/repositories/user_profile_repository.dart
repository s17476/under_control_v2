import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../entities/user_profile.dart';
import '../../../core/error/failures.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> getUserById(String userId);

  Future<Either<Failure, VoidResult>> assignUserToCompany(
      AssignParams assignParams);

  Future<Either<Failure, VoidResult>> resetCompany(String userId);

  Future<Either<Failure, VoidResult>> addUser(UserProfile userProfile);

  Future<Either<Failure, VoidResult>> approveUser(String userId);

  Future<Either<Failure, VoidResult>> approveUserAndMakeAdmin(String userId);

  Future<Either<Failure, VoidResult>> rejectUser(String userId);

  Future<Either<Failure, VoidResult>> suspendUser(String userId);

  Future<Either<Failure, VoidResult>> updateUserdata(UserProfile userProfile);

  Future<Either<Failure, VoidResult>> assignUserToGroup(
    UserAndGroupParams params,
  );

  Future<Either<Failure, VoidResult>> unassignUserFromGroup(
    UserAndGroupParams params,
  );

  Future<Either<Failure, VoidResult>> assignGroupAdmin(
    AssignGroupAdminParams params,
  );

  Future<Either<Failure, VoidResult>> unassignGroupAdmin(
    AssignGroupAdminParams params,
  );
}
