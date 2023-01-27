import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/settings/domain/entities/notification_settings.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

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
