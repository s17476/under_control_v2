import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class GetUserById extends FutureUseCase<UserProfile, String> {
  final UserProfileRepository repository;

  GetUserById({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserProfile>> call(String params) async {
    return repository.getUserById(params);
  }
}
