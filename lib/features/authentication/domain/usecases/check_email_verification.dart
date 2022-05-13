import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';

@lazySingleton
class CheckEmailVerification {
  final AuthenticationRepository authenticationRepository;

  const CheckEmailVerification({
    required this.authenticationRepository,
  });

  bool call() {
    return authenticationRepository.isEmailVerified;
  }
}
