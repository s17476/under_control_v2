import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

@lazySingleton
class RemoveDeviceToken extends FutureUseCase<VoidResult, UserProfileParams> {
  final NotificationRepository repository;

  RemoveDeviceToken({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(UserProfileParams params) async =>
      repository.removeDeviceToken(params);
}
