import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

@lazySingleton
class RegisterDeviceToken extends FutureUseCase<VoidResult, UserProfileParams> {
  final NotificationRepository repository;

  RegisterDeviceToken({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(UserProfileParams params) async =>
      repository.registerDeviceToken(params);
}
