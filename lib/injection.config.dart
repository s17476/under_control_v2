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
    as _i7;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i6;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i12;
import 'features/authentication/domain/usecases/signin.dart' as _i8;
import 'features/authentication/domain/usecases/signout.dart' as _i9;
import 'features/authentication/domain/usecases/signup.dart' as _i10;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i11;
import 'features/core/network/network_info.dart'
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
  gh.lazySingleton<_i5.NetworkInfo>(() => _i5.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  gh.lazySingleton<_i6.AuthenticationRepository>(() =>
      _i7.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i5.NetworkInfo>()));
  gh.lazySingleton<_i8.Signin>(() => _i8.Signin(
      authenticationRepository: get<_i6.AuthenticationRepository>()));
  gh.lazySingleton<_i9.Signout>(() => _i9.Signout(
      authenticationRepository: get<_i6.AuthenticationRepository>()));
  gh.lazySingleton<_i10.Signup>(() => _i10.Signup(
      authenticationRepository: get<_i6.AuthenticationRepository>()));
  gh.factory<_i11.AuthenticationBloc>(() => _i11.AuthenticationBloc(
      repository: get<_i6.AuthenticationRepository>(),
      signin: get<_i8.Signin>(),
      signup: get<_i10.Signup>(),
      signout: get<_i9.Signout>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i12.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i12.FirebaseAuthenticationService {}
