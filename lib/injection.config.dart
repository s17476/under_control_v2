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
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i21;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i20;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i59;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i22;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i23;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i37;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i38;
import 'features/authentication/domain/usecases/signin.dart' as _i39;
import 'features/authentication/domain/usecases/signout.dart' as _i40;
import 'features/authentication/domain/usecases/signup.dart' as _i41;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i51;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i25;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i27;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i24;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i26;
import 'features/company_profile/domain/usecases/add_company.dart' as _i48;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i49;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i28;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i29;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i30;
import 'features/company_profile/domain/usecases/update_company.dart' as _i44;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i56;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i57;
import 'features/core/injectable_modules/injectable_modules.dart' as _i60;
import 'features/core/network/network_info.dart' as _i9;
import 'features/core/utils/input_validator.dart' as _i7;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i32;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i8;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i34;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i33;
import 'features/locations/domain/usecases/add_location.dart' as _i50;
import 'features/locations/domain/usecases/cache_location.dart' as _i52;
import 'features/locations/domain/usecases/delete_location.dart' as _i53;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i54;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i43;
import 'features/locations/domain/usecases/update_location.dart' as _i45;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i58;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i12;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i14;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i11;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i13;
import 'features/user_profile/domain/usecases/add_user.dart' as _i15;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i16;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i17;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i18;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i19;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i31;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i35;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i36;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i42;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i46;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i47;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i55; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dataConnectionCheckerModule = _$DataConnectionCheckerModule();
  final firebaseAuthenticationService = _$FirebaseAuthenticationService();
  final firebaseFirestoreService = _$FirebaseFirestoreService();
  final firebaseStorageService = _$FirebaseStorageService();
  final sharedPreferencesService = _$SharedPreferencesService();
  gh.lazySingleton<_i3.DataConnectionChecker>(
      () => dataConnectionCheckerModule.httpClient);
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => firebaseFirestoreService.firebaseFirestore);
  gh.lazySingleton<_i6.FirebaseStorage>(
      () => firebaseStorageService.firebaseStorage);
  gh.lazySingleton<_i7.InputValidator>(() => _i7.InputValidator());
  gh.lazySingleton<_i8.LocationRemoteDataSource>(() =>
      _i8.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i9.NetworkInfo>(() => _i9.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i10.SharedPreferences>(
      () => sharedPreferencesService.shaerdPreferences,
      preResolve: true);
  gh.lazySingleton<_i11.UserFilesRepository>(() => _i12.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i13.UserProfileRepository>(() =>
      _i14.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i15.AddUser>(
      () => _i15.AddUser(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i16.AddUserAvatar>(
      () => _i16.AddUserAvatar(repository: get<_i11.UserFilesRepository>()));
  gh.lazySingleton<_i17.ApproveUser>(
      () => _i17.ApproveUser(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i18.ApproveUserAndMakeAdmin>(() =>
      _i18.ApproveUserAndMakeAdmin(
          repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i19.AssignUserToCompany>(() =>
      _i19.AssignUserToCompany(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i20.AuthenticationRepository>(() =>
      _i21.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i9.NetworkInfo>()));
  gh.lazySingleton<_i22.AutoSignin>(() => _i22.AutoSignin(
      authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i23.CheckEmailVerification>(() =>
      _i23.CheckEmailVerification(
          authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i24.CompanyManagementRepository>(() =>
      _i25.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i26.CompanyRepository>(() => _i27.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i28.FetchAllCompanies>(() => _i28.FetchAllCompanies(
      companyManagementRepository: get<_i24.CompanyManagementRepository>()));
  gh.lazySingleton<_i29.FetchAllCompanyUsers>(() => _i29.FetchAllCompanyUsers(
      companyRepository: get<_i26.CompanyRepository>()));
  gh.lazySingleton<_i30.GetCompanyById>(() =>
      _i30.GetCompanyById(companyRepository: get<_i26.CompanyRepository>()));
  gh.lazySingleton<_i31.GetUserById>(
      () => _i31.GetUserById(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i32.LocationLocalDataSource>(() =>
      _i32.LocationLocalDataSourceImpl(source: get<_i10.SharedPreferences>()));
  gh.lazySingleton<_i33.LocationRepository>(() => _i34.LocationRepositoryImpl(
      locationLocalDataSource: get<_i32.LocationLocalDataSource>(),
      locationRemoteDataSource: get<_i8.LocationRemoteDataSource>()));
  gh.lazySingleton<_i35.RejectUser>(
      () => _i35.RejectUser(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i36.ResetCompany>(
      () => _i36.ResetCompany(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i37.SendPasswordResetEmail>(() =>
      _i37.SendPasswordResetEmail(
          authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i38.SendVerificationEmail>(() => _i38.SendVerificationEmail(
      authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i39.Signin>(() => _i39.Signin(
      authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i40.Signout>(() => _i40.Signout(
      authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i41.Signup>(() => _i41.Signup(
      authenticationRepository: get<_i20.AuthenticationRepository>()));
  gh.lazySingleton<_i42.SuspendUser>(
      () => _i42.SuspendUser(repository: get<_i13.UserProfileRepository>()));
  gh.lazySingleton<_i43.TryToGetCachedLocation>(() =>
      _i43.TryToGetCachedLocation(
          locationRepository: get<_i33.LocationRepository>()));
  gh.lazySingleton<_i44.UpdateCompany>(() =>
      _i44.UpdateCompany(companyRepository: get<_i26.CompanyRepository>()));
  gh.lazySingleton<_i45.UpdateLocation>(() =>
      _i45.UpdateLocation(locationRepository: get<_i33.LocationRepository>()));
  gh.lazySingleton<_i46.UpdateUserData>(
      () => _i46.UpdateUserData(repository: get<_i13.UserProfileRepository>()));
  gh.factory<_i47.UserManagementBloc>(() => _i47.UserManagementBloc(
      approveUser: get<_i17.ApproveUser>(),
      approveUserAndMakeAdmin: get<_i18.ApproveUserAndMakeAdmin>(),
      rejectUser: get<_i35.RejectUser>(),
      suspendUser: get<_i42.SuspendUser>()));
  gh.lazySingleton<_i48.AddCompany>(() => _i48.AddCompany(
      companyManagementRepository: get<_i24.CompanyManagementRepository>()));
  gh.lazySingleton<_i49.AddCompanyLogo>(() =>
      _i49.AddCompanyLogo(repository: get<_i24.CompanyManagementRepository>()));
  gh.lazySingleton<_i50.AddLocation>(() =>
      _i50.AddLocation(locationRepository: get<_i33.LocationRepository>()));
  gh.factory<_i51.AuthenticationBloc>(() => _i51.AuthenticationBloc(
      signin: get<_i39.Signin>(),
      signup: get<_i41.Signup>(),
      signout: get<_i40.Signout>(),
      autoSignin: get<_i22.AutoSignin>(),
      sendVerificationEmail: get<_i38.SendVerificationEmail>(),
      checkEmailVerification: get<_i23.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i37.SendPasswordResetEmail>(),
      inputValidator: get<_i7.InputValidator>()));
  gh.lazySingleton<_i52.CacheLocation>(() =>
      _i52.CacheLocation(locationRepository: get<_i33.LocationRepository>()));
  gh.lazySingleton<_i53.DeleteLocation>(() =>
      _i53.DeleteLocation(locationRepository: get<_i33.LocationRepository>()));
  gh.lazySingleton<_i54.FetchAllLocations>(() => _i54.FetchAllLocations(
      locationRepository: get<_i33.LocationRepository>()));
  gh.factory<_i55.UserProfileBloc>(() => _i55.UserProfileBloc(
      authenticationBloc: get<_i51.AuthenticationBloc>(),
      addUser: get<_i15.AddUser>(),
      assignUserToCompany: get<_i19.AssignUserToCompany>(),
      resetCompany: get<_i36.ResetCompany>(),
      getUserById: get<_i31.GetUserById>(),
      updateUserData: get<_i46.UpdateUserData>(),
      addUserAvatar: get<_i16.AddUserAvatar>(),
      inputValidator: get<_i7.InputValidator>()));
  gh.factory<_i56.CompanyManagementBloc>(() => _i56.CompanyManagementBloc(
      userProfileBloc: get<_i55.UserProfileBloc>(),
      inputValidator: get<_i7.InputValidator>(),
      addCompany: get<_i48.AddCompany>(),
      fetchAllCompanies: get<_i28.FetchAllCompanies>(),
      addCompanyLogo: get<_i49.AddCompanyLogo>()));
  gh.factory<_i57.CompanyProfileBloc>(() => _i57.CompanyProfileBloc(
      userProfileBloc: get<_i55.UserProfileBloc>(),
      updateCompany: get<_i44.UpdateCompany>(),
      fetchAllCompanyUsers: get<_i29.FetchAllCompanyUsers>(),
      getCompanyById: get<_i30.GetCompanyById>(),
      inputValidator: get<_i7.InputValidator>()));
  gh.factory<_i58.LocationBloc>(() => _i58.LocationBloc(
      companyProfileBloc: get<_i57.CompanyProfileBloc>(),
      addLocation: get<_i50.AddLocation>(),
      cacheLocation: get<_i52.CacheLocation>(),
      deleteLocation: get<_i53.DeleteLocation>(),
      fetchAllLocations: get<_i54.FetchAllLocations>(),
      tryToGetCachedLocation: get<_i43.TryToGetCachedLocation>(),
      updateLocation: get<_i45.UpdateLocation>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i59.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i59.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i60.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i60.FirebaseStorageService {}

class _$SharedPreferencesService extends _i60.SharedPreferencesService {}
