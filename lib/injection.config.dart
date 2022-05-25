// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart'
    as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i18;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i17;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i44;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i19;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i20;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i30;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i31;
import 'features/authentication/domain/usecases/signin.dart' as _i32;
import 'features/authentication/domain/usecases/signout.dart' as _i33;
import 'features/authentication/domain/usecases/signup.dart' as _i34;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i40;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i22;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i24;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i21;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i23;
import 'features/company_profile/domain/usecases/add_company.dart' as _i38;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i39;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i25;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i26;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i27;
import 'features/company_profile/domain/usecases/update_company.dart' as _i36;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i42;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i43;
import 'features/core/network/network_info.dart' as _i8;
import 'features/core/utils/input_validator.dart' as _i7;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i10;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i12;
import 'features/user_profile/domain/repositories/injectable_modules.dart'
    as _i45;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i9;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i11;
import 'features/user_profile/domain/usecases/add_user.dart' as _i13;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i14;
import 'features/user_profile/domain/usecases/approve_ueer.dart' as _i15;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i16;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i28;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i29;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i35;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i37;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i41; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dataConnectionCheckerModule = _$DataConnectionCheckerModule();
  final firebaseAuthenticationService = _$FirebaseAuthenticationService();
  final firebaseFirestoreService = _$FirebaseFirestoreService();
  final firebaseStorageService = _$FirebaseStorageService();
  gh.lazySingleton<_i3.DataConnectionChecker>(
      () => dataConnectionCheckerModule.httpClient);
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => firebaseFirestoreService.firebaseFirestore);
  gh.lazySingleton<_i6.FirebaseStorage>(
      () => firebaseStorageService.firebaseStorage);
  gh.lazySingleton<_i7.InputValidator>(() => _i7.InputValidator());
  gh.lazySingleton<_i8.NetworkInfo>(() => _i8.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  gh.lazySingleton<_i9.UserFilesRepository>(() => _i10.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i11.UserProfileRepository>(() =>
      _i12.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i13.AddUser>(
      () => _i13.AddUser(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i14.AddUserAvatar>(
      () => _i14.AddUserAvatar(repository: get<_i9.UserFilesRepository>()));
  gh.lazySingleton<_i15.ApproveUser>(
      () => _i15.ApproveUser(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i16.AssignUserToCompany>(() =>
      _i16.AssignUserToCompany(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i17.AuthenticationRepository>(() =>
      _i18.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i8.NetworkInfo>()));
  gh.lazySingleton<_i19.AutoSignin>(() => _i19.AutoSignin(
      authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i20.CheckEmailVerification>(() =>
      _i20.CheckEmailVerification(
          authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i21.CompanyManagementRepository>(() =>
      _i22.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i23.CompanyRepository>(() => _i24.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i25.FetchAllCompanies>(() => _i25.FetchAllCompanies(
      companyManagementRepository: get<_i21.CompanyManagementRepository>()));
  gh.lazySingleton<_i26.FetchAllCompanyUsers>(() => _i26.FetchAllCompanyUsers(
      companyRepository: get<_i23.CompanyRepository>()));
  gh.lazySingleton<_i27.GetCompanyById>(() =>
      _i27.GetCompanyById(companyRepository: get<_i23.CompanyRepository>()));
  gh.lazySingleton<_i28.GetUserById>(
      () => _i28.GetUserById(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i29.RejectUser>(
      () => _i29.RejectUser(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i30.SendPasswordResetEmail>(() =>
      _i30.SendPasswordResetEmail(
          authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i31.SendVerificationEmail>(() => _i31.SendVerificationEmail(
      authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i32.Signin>(() => _i32.Signin(
      authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i33.Signout>(() => _i33.Signout(
      authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i34.Signup>(() => _i34.Signup(
      authenticationRepository: get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i35.SuspendUser>(
      () => _i35.SuspendUser(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i36.UpdateCompany>(() =>
      _i36.UpdateCompany(companyRepository: get<_i23.CompanyRepository>()));
  gh.lazySingleton<_i37.UpdateUserData>(
      () => _i37.UpdateUserData(repository: get<_i11.UserProfileRepository>()));
  gh.lazySingleton<_i38.AddCompany>(() => _i38.AddCompany(
      companyManagementRepository: get<_i21.CompanyManagementRepository>()));
  gh.lazySingleton<_i39.AddCompanyLogo>(() =>
      _i39.AddCompanyLogo(repository: get<_i21.CompanyManagementRepository>()));
  gh.factory<_i40.AuthenticationBloc>(() => _i40.AuthenticationBloc(
      signin: get<_i32.Signin>(),
      signup: get<_i34.Signup>(),
      signout: get<_i33.Signout>(),
      autoSignin: get<_i19.AutoSignin>(),
      sendVerificationEmail: get<_i31.SendVerificationEmail>(),
      checkEmailVerification: get<_i20.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i30.SendPasswordResetEmail>(),
      inputValidator: get<_i7.InputValidator>()));
  gh.factory<_i41.UserProfileBloc>(() => _i41.UserProfileBloc(
      authenticationBloc: get<_i40.AuthenticationBloc>(),
      addUser: get<_i13.AddUser>(),
      assignUserToCompany: get<_i16.AssignUserToCompany>(),
      getUserById: get<_i28.GetUserById>(),
      updateUserData: get<_i37.UpdateUserData>(),
      addUserAvatar: get<_i14.AddUserAvatar>(),
      inputValidator: get<_i7.InputValidator>()));
  gh.factory<_i42.CompanyManagementBloc>(() => _i42.CompanyManagementBloc(
      userProfileBloc: get<_i41.UserProfileBloc>(),
      inputValidator: get<_i7.InputValidator>(),
      addCompany: get<_i38.AddCompany>(),
      fetchAllCompanies: get<_i25.FetchAllCompanies>(),
      addCompanyLogo: get<_i39.AddCompanyLogo>()));
  gh.factory<_i43.CompanyProfileBloc>(() => _i43.CompanyProfileBloc(
      userProfileBloc: get<_i41.UserProfileBloc>(),
      updateCompany: get<_i36.UpdateCompany>(),
      fetchAllCompanyUsers: get<_i26.FetchAllCompanyUsers>(),
      getCompanyById: get<_i27.GetCompanyById>(),
      inputValidator: get<_i7.InputValidator>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i44.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i44.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i45.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i45.FirebaseStorageService {}
