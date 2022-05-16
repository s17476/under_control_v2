import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repository.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/error/failures.dart';

@lazySingleton
class Signup implements FutureUseCase<VoidResult, AuthParams> {
  final AuthenticationRepository authenticationRepository;

  Signup({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(AuthParams params) async {
    return await authenticationRepository.signup(
        email: params.email, password: params.password);
  }
}
