import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseAuthenticationService {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}

@module
abstract class DataConnectionCheckerModule {
  @lazySingleton
  DataConnectionChecker get httpClient => DataConnectionChecker();
}
