import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class UnsuspendUser extends FutureUseCase<VoidResult, String> {
  final UserProfileRepository repository;

  UnsuspendUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(String params) async {
    return repository.unsuspendUser(params);
  }
}
