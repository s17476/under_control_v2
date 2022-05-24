import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';

abstract class UserFilesRepository {
  Future<Either<Failure, String>> addUserAvatar(AvatarParams params);
}
