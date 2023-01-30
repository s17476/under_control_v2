import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/uc_notifications_stream.dart';

abstract class UcNotificationRepository {
  ///Get user's notifications.
  ///
  ///Returns [UcNotificationsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, UcNotificationsStream>> getNotifications(
    UserProfileParams params,
  );

  ///Mark notification as read.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> markAsRead(
    UcNotificationParams params,
  );

  ///Mark notification as unread.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> markAsUnread(
    UcNotificationParams params,
  );

  ///Delete notification
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteNotification(
    UcNotificationParams params,
  );
}
