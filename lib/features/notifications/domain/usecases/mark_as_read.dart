import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/uc_notification_repository.dart';

@lazySingleton
class MarkAsRead extends FutureUseCase<VoidResult, UcNotificationParams> {
  final UcNotificationRepository repository;

  MarkAsRead({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
    UcNotificationParams params,
  ) async =>
      repository.markAsRead(params);
}
