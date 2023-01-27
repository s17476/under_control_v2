import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/notification_settings_repository.dart';

@lazySingleton
class UpdateNotificationSettings
    extends FutureUseCase<VoidResult, NotificationSettingsParams> {
  final NotificationSettingsRepository repository;

  UpdateNotificationSettings({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
    NotificationSettingsParams params,
  ) async =>
      repository.updateNotificationSettings(params);
}
