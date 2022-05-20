import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class AddUser extends FutureUseCase<String, UserProfile> {
  final UserProfileRepository repository;

  AddUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(UserProfile params) async {
    return repository.addUser(params);
  }
}
