import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repository.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/error/failures.dart';

@lazySingleton
class Signout implements FutureUseCase<VoidResult, NoParams> {
  final AuthenticationRepository authenticationRepository;

  const Signout({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(NoParams params) async {
    return await authenticationRepository.signout();
  }
}
