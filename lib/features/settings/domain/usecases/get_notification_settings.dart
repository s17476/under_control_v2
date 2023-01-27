import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/notification_settings.dart';
import '../repositories/notification_settings_repository.dart';

@lazySingleton
class GetNotificationSettings
    extends FutureUseCase<NotificationSettings, UserProfileParams> {
  final NotificationSettingsRepository repository;

  GetNotificationSettings({
    required this.repository,
  });

  @override
  Future<Either<Failure, NotificationSettings>> call(
    UserProfileParams params,
  ) async =>
      repository.getNotificationSettings(params);
}
