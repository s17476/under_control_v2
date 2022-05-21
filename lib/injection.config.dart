// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart'
    as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i14;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i13;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i36;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i15;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i16;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i24;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i25;
import 'features/authentication/domain/usecases/signin.dart' as _i26;
import 'features/authentication/domain/usecases/signout.dart' as _i27;
import 'features/authentication/domain/usecases/signup.dart' as _i28;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i33;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i18;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i17;
import 'features/company_profile/domain/usecases/add_company.dart' as _i32;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i19;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i20;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i21;
import 'features/company_profile/domain/usecases/update_company.dart' as _i30;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i34;
import 'features/core/network/network_info.dart' as _i7;
import 'features/core/utils/input_validator.dart' as _i6;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i9;
import 'features/user_profile/domain/repositories/injectable_modules.dart'
    as _i37;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i8;
import 'features/user_profile/domain/usecases/add_user.dart' as _i10;
import 'features/user_profile/domain/usecases/approve_ueer.dart' as _i11;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i12;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i22;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i23;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i29;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i31;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i35; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dataConnectionCheckerModule = _$DataConnectionCheckerModule();
  final firebaseAuthenticationService = _$FirebaseAuthenticationService();
  final firebaseFirestoreService = _$FirebaseFirestoreService();
  gh.lazySingleton<_i3.DataConnectionChecker>(
      () => dataConnectionCheckerModule.httpClient);
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => firebaseFirestoreService.firebaseAuth);
  gh.lazySingleton<_i6.InputValidator>(() => _i6.InputValidator());
  gh.lazySingleton<_i7.NetworkInfo>(() => _i7.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  gh.lazySingleton<_i8.UserProfileRepository>(() =>
      _i9.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i10.AddUser>(
      () => _i10.AddUser(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i11.ApproveUser>(
      () => _i11.ApproveUser(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i12.AssignUserToCompany>(() =>
      _i12.AssignUserToCompany(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i13.AuthenticationRepository>(() =>
      _i14.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i7.NetworkInfo>()));
  gh.lazySingleton<_i15.AutoSignin>(() => _i15.AutoSignin(
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i16.CheckEmailVerification>(() =>
      _i16.CheckEmailVerification(
          authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i17.CompanyRepository>(() => _i18.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>(),
      networkInfo: get<_i7.NetworkInfo>()));
  gh.lazySingleton<_i19.FetchAllCompanies>(() =>
      _i19.FetchAllCompanies(companyRepository: get<_i17.CompanyRepository>()));
  gh.lazySingleton<_i20.FetchAllCompanyUsers>(() => _i20.FetchAllCompanyUsers(
      companyRepository: get<_i17.CompanyRepository>()));
  gh.lazySingleton<_i21.GetCompanyById>(() =>
      _i21.GetCompanyById(companyRepository: get<_i17.CompanyRepository>()));
  gh.lazySingleton<_i22.GetUserById>(
      () => _i22.GetUserById(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i23.RejectUser>(
      () => _i23.RejectUser(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i24.SendPasswordResetEmail>(() =>
      _i24.SendPasswordResetEmail(
          authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i25.SendVerificationEmail>(() => _i25.SendVerificationEmail(
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i26.Signin>(() => _i26.Signin(
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i27.Signout>(() => _i27.Signout(
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i28.Signup>(() => _i28.Signup(
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.lazySingleton<_i29.SuspendUser>(
      () => _i29.SuspendUser(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i30.UpdateCompany>(() =>
      _i30.UpdateCompany(companyRepository: get<_i17.CompanyRepository>()));
  gh.lazySingleton<_i31.UpdateUserData>(
      () => _i31.UpdateUserData(repository: get<_i8.UserProfileRepository>()));
  gh.lazySingleton<_i32.AddCompany>(
      () => _i32.AddCompany(companyRepository: get<_i17.CompanyRepository>()));
  gh.factory<_i33.AuthenticationBloc>(() => _i33.AuthenticationBloc(
      signin: get<_i26.Signin>(),
      signup: get<_i28.Signup>(),
      signout: get<_i27.Signout>(),
      autoSignin: get<_i15.AutoSignin>(),
      sendVerificationEmail: get<_i25.SendVerificationEmail>(),
      checkEmailVerification: get<_i16.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i24.SendPasswordResetEmail>(),
      inputValidator: get<_i6.InputValidator>()));
  gh.factory<_i34.CompanyProfileBloc>(() => _i34.CompanyProfileBloc(
      authenticationBloc: get<_i33.AuthenticationBloc>(),
      addCompany: get<_i32.AddCompany>(),
      updateCompany: get<_i30.UpdateCompany>(),
      fetchAllCompanies: get<_i19.FetchAllCompanies>(),
      getCompanyById: get<_i21.GetCompanyById>()));
  gh.factory<_i35.UserProfileBloc>(() => _i35.UserProfileBloc(
      authenticationBloc: get<_i33.AuthenticationBloc>(),
      addUser: get<_i10.AddUser>(),
      assignUserToCompany: get<_i12.AssignUserToCompany>(),
      getUserById: get<_i22.GetUserById>(),
      updateUserData: get<_i31.UpdateUserData>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i36.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i36.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i37.FirebaseFirestoreService {}
