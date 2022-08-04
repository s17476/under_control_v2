import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class ResetCompany extends FutureUseCase<VoidResult, String> {
  final UserProfileRepository repository;

  ResetCompany({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(String params) async {
    return repository.resetCompany(params);
  }
}
