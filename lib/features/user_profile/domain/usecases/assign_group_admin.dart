import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class AssignGroupAdmin
    extends FutureUseCase<VoidResult, AssignGroupAdminParams> {
  final UserProfileRepository repository;

  AssignGroupAdmin({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
      AssignGroupAdminParams params) async {
    return repository.assignGroupAdmin(params);
  }
}
