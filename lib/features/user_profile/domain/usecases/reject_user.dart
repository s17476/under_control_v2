import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user_profile_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class RejectUser extends FutureUseCase<VoidResult, String> {
  final UserProfileRepository repository;

  RejectUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(String params) async {
    return repository.rejectUser(params);
  }
}
