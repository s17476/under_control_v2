import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repository.dart';

@lazySingleton
class AutoSignin {
  final AuthenticationRepository authenticationRepository;

  AutoSignin({
    required this.authenticationRepository,
  });

  Stream<User?> call() {
    return authenticationRepository.user;
  }
}
