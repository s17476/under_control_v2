import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/notification_settings.dart';

abstract class NotificationSettingsRepository {
  ///Gets notification settings.
  ///
  ///Returns [NotificationSettings] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, NotificationSettings>> getNotificationSettings(
    UserProfileParams params,
  );

  ///Updates notifications settings is DB.
  ///
  ///Returns [Voidresult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateNotificationSettings(
    NotificationSettingsParams params,
  );
}
