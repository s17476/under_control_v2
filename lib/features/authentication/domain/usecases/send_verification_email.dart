import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/authentication_repository.dart';

@lazySingleton
class SendVerificationEmail implements FutureUseCase<VoidResult, NoParams> {
  final AuthenticationRepository authenticationRepository;

  SendVerificationEmail({
    required this.authenticationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(NoParams params) async {
    return await authenticationRepository.sendVerificationEmail();
  }
}
