import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

class Signout implements UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  Signout({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authenticationRepository.signout();
  }
}
