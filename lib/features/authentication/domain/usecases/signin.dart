import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

class Signin implements UseCase<void, AuthParams> {
  final AuthenticationRepository authenticationRepository;

  Signin({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, void>> call(AuthParams params) async {
    return await authenticationRepository.signin(
        email: params.email, password: params.password);
  }
}
