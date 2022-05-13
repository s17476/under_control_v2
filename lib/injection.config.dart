// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart'
    as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i8;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i7;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i16;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i9;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i10;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i11;
import 'features/authentication/domain/usecases/signin.dart' as _i12;
import 'features/authentication/domain/usecases/signout.dart' as _i13;
import 'features/authentication/domain/usecases/signup.dart' as _i14;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i15;
import 'features/core/network/network_info.dart' as _i6;
import 'features/core/utils/input_validator.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dataConnectionCheckerModule = _$DataConnectionCheckerModule();
  final firebaseAuthenticationService = _$FirebaseAuthenticationService();
  gh.lazySingleton<_i3.DataConnectionChecker>(
      () => dataConnectionCheckerModule.httpClient);
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i5.InputValidator>(() => _i5.InputValidator());
  gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  gh.lazySingleton<_i7.AuthenticationRepository>(() =>
      _i8.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i6.NetworkInfo>()));
  gh.lazySingleton<_i9.AutoSignin>(() => _i9.AutoSignin(
      authenticationRepository: get<_i7.AuthenticationRepository>()));
  gh.lazySingleton<_i10.CheckEmailVerification>(() =>
      _i10.CheckEmailVerification(
          authenticationRepository: get<_i7.AuthenticationRepository>()));
  gh.lazySingleton<_i11.SendVerificationEmail>(() => _i11.SendVerificationEmail(
      authenticationRepository: get<_i7.AuthenticationRepository>()));
  gh.lazySingleton<_i12.Signin>(() => _i12.Signin(
      authenticationRepository: get<_i7.AuthenticationRepository>()));
  gh.lazySingleton<_i13.Signout>(() => _i13.Signout(
      authenticationRepository: get<_i7.AuthenticationRepository>()));
  gh.lazySingleton<_i14.Signup>(() => _i14.Signup(
      authenticationRepository: get<_i7.AuthenticationRepository>()));
  gh.factory<_i15.AuthenticationBloc>(() => _i15.AuthenticationBloc(
      signin: get<_i12.Signin>(),
      signup: get<_i14.Signup>(),
      signout: get<_i13.Signout>(),
      autoSignin: get<_i9.AutoSignin>(),
      sendVerificationEmail: get<_i11.SendVerificationEmail>(),
      checkEmailVerification: get<_i10.CheckEmailVerification>(),
      inputValidator: get<_i5.InputValidator>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i16.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i16.FirebaseAuthenticationService {}
