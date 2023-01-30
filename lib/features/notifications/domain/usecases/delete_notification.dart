import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/uc_notification_repository.dart';

@lazySingleton
class DeleteNotification
    extends FutureUseCase<VoidResult, UcNotificationParams> {
  final UcNotificationRepository repository;

  DeleteNotification({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
    UcNotificationParams params,
  ) async =>
      repository.deleteNotification(params);
}
