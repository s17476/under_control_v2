import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

@lazySingleton
class Signup implements UseCase<void, AuthParams> {
  final AuthenticationRepository authenticationRepository;

  Signup({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, void>> call(AuthParams params) async {
    return await authenticationRepository.signup(
        email: params.email, password: params.password);
  }
}
