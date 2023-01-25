import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class RemoveDeviceToken extends FutureUseCase<VoidResult, AssignParams> {
  final NotificationRepository repository;

  RemoveDeviceToken({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(AssignParams params) async =>
      repository.removeDeviceToken(params);
}
