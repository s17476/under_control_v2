import 'package:injectable/injectable.dart';

import '../repositories/authentication_repository.dart';

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
