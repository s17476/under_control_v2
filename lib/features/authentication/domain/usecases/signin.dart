import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repository.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/error/failures.dart';

@lazySingleton
class Signin implements FutureUseCase<VoidResult, AuthParams> {
  final AuthenticationRepository authenticationRepository;

  Signin({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(AuthParams params) async {
    return await authenticationRepository.signin(
        email: params.email, password: params.password);
  }
}
