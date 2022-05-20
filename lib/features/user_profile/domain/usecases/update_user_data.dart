import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class UpdateUserData extends FutureUseCase<VoidResult, UserProfile> {
  final UserProfileRepository repository;

  UpdateUserData({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(UserProfile params) async {
    return repository.updateUserdata(params);
  }
}
