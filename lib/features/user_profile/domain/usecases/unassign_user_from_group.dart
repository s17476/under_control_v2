import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class UnassignUserFromGroup
    extends FutureUseCase<VoidResult, UserAndGroupParams> {
  final UserProfileRepository repository;

  UnassignUserFromGroup({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(UserAndGroupParams params) async {
    return repository.unassignUserFromGroup(params);
  }
}
