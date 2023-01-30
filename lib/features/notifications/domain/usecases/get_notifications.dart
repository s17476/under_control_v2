import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/uc_notifications_stream.dart';
import '../repositories/uc_notification_repository.dart';

@lazySingleton
class GetNotifications
    extends FutureUseCase<UcNotificationsStream, UserProfileParams> {
  final UcNotificationRepository repository;

  GetNotifications({
    required this.repository,
  });

  @override
  Future<Either<Failure, UcNotificationsStream>> call(
          UserProfileParams params) async =>
      repository.getNotifications(params);
}
