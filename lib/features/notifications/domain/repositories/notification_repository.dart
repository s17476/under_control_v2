import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class NotificationRepository {
  ///Register device token in the DB.
  ///
  ///Returns [VoidResult] containing generated by BD location id.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> registerDeviceToken(
    UserProfileParams params,
  );

  ///Remove device token from the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> removeDeviceToken(
    UserProfileParams params,
  );
}
