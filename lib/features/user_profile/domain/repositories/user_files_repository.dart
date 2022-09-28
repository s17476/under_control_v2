import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../../../core/error/failures.dart';

abstract class UserFilesRepository {
  Future<Either<Failure, String>> addUserAvatar(AvatarParams params);
}
