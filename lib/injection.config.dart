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
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i24;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i23;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i74;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i25;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i26;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i43;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i44;
import 'features/authentication/domain/usecases/signin.dart' as _i45;
import 'features/authentication/domain/usecases/signout.dart' as _i46;
import 'features/authentication/domain/usecases/signup.dart' as _i47;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i62;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i28;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i30;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i27;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i29;
import 'features/company_profile/domain/usecases/add_company.dart' as _i58;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i59;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i31;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i32;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i33;
import 'features/company_profile/domain/usecases/update_company.dart' as _i53;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i70;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i71;
import 'features/core/injectable_modules/injectable_modules.dart' as _i75;
import 'features/core/network/network_info.dart' as _i10;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i35;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i37;
import 'features/groups/domain/repositories/group_repository.dart' as _i36;
import 'features/groups/domain/usecases/add_group.dart' as _i60;
import 'features/groups/domain/usecases/cache_groups.dart' as _i63;
import 'features/groups/domain/usecases/delete_group.dart' as _i65;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i68;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i49;
import 'features/groups/domain/usecases/update_group.dart' as _i54;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i72;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i38;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i9;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i40;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i39;
import 'features/locations/domain/usecases/add_location.dart' as _i61;
import 'features/locations/domain/usecases/cache_location.dart' as _i64;
import 'features/locations/domain/usecases/delete_location.dart' as _i66;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i67;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i50;
import 'features/locations/domain/usecases/update_location.dart' as _i55;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i73;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i13;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i15;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i12;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i14;
import 'features/user_profile/domain/usecases/add_user.dart' as _i16;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i17;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i18;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i19;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i20;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i21;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i22;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i34;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i41;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i42;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i48;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i51;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i52;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i56;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i57;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i69; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i7.GroupRemoteDataSource>(() =>
      _i7.GroupRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i8.InputValidator>(() => _i8.InputValidator());
  gh.lazySingleton<_i9.LocationRemoteDataSource>(() =>
      _i9.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i10.NetworkInfo>(() => _i10.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i11.SharedPreferences>(
      () => sharedPreferencesService.shaerdPreferences,
      preResolve: true);
  gh.lazySingleton<_i12.UserFilesRepository>(() => _i13.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i14.UserProfileRepository>(() =>
      _i15.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i16.AddUser>(
      () => _i16.AddUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i17.AddUserAvatar>(
      () => _i17.AddUserAvatar(repository: get<_i12.UserFilesRepository>()));
  gh.lazySingleton<_i18.ApproveUser>(
      () => _i18.ApproveUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i19.ApproveUserAndMakeAdmin>(() =>
      _i19.ApproveUserAndMakeAdmin(
          repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i20.AssignGroupAdmin>(() =>
      _i20.AssignGroupAdmin(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i21.AssignUserToCompany>(() =>
      _i21.AssignUserToCompany(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i22.AssignUserToGroup>(() =>
      _i22.AssignUserToGroup(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i23.AuthenticationRepository>(() =>
      _i24.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i10.NetworkInfo>()));
  gh.lazySingleton<_i25.AutoSignin>(() => _i25.AutoSignin(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i26.CheckEmailVerification>(() =>
      _i26.CheckEmailVerification(
          authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i27.CompanyManagementRepository>(() =>
      _i28.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i29.CompanyRepository>(() => _i30.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i31.FetchAllCompanies>(() => _i31.FetchAllCompanies(
      companyManagementRepository: get<_i27.CompanyManagementRepository>()));
  gh.lazySingleton<_i32.FetchAllCompanyUsers>(() => _i32.FetchAllCompanyUsers(
      companyRepository: get<_i29.CompanyRepository>()));
  gh.lazySingleton<_i33.GetCompanyById>(() =>
      _i33.GetCompanyById(companyRepository: get<_i29.CompanyRepository>()));
  gh.lazySingleton<_i34.GetUserById>(
      () => _i34.GetUserById(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i35.GroupLocalDataSource>(() =>
      _i35.GroupLocalDataSourceImpl(source: get<_i11.SharedPreferences>()));
  gh.lazySingleton<_i36.GroupRepository>(() => _i37.GroupRepositoryImpl(
      groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
      groupLocalDataSource: get<_i35.GroupLocalDataSource>()));
  gh.lazySingleton<_i38.LocationLocalDataSource>(() =>
      _i38.LocationLocalDataSourceImpl(source: get<_i11.SharedPreferences>()));
  gh.lazySingleton<_i39.LocationRepository>(() => _i40.LocationRepositoryImpl(
      locationLocalDataSource: get<_i38.LocationLocalDataSource>(),
      locationRemoteDataSource: get<_i9.LocationRemoteDataSource>()));
  gh.lazySingleton<_i41.RejectUser>(
      () => _i41.RejectUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i42.ResetCompany>(
      () => _i42.ResetCompany(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i43.SendPasswordResetEmail>(() =>
      _i43.SendPasswordResetEmail(
          authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i44.SendVerificationEmail>(() => _i44.SendVerificationEmail(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i45.Signin>(() => _i45.Signin(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i46.Signout>(() => _i46.Signout(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i47.Signup>(() => _i47.Signup(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i48.SuspendUser>(
      () => _i48.SuspendUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i49.TryToGetCachedGroups>(() =>
      _i49.TryToGetCachedGroups(groupRepository: get<_i36.GroupRepository>()));
  gh.lazySingleton<_i50.TryToGetCachedLocation>(() =>
      _i50.TryToGetCachedLocation(
          locationRepository: get<_i39.LocationRepository>()));
  gh.lazySingleton<_i51.UnassignGroupAdmin>(() =>
      _i51.UnassignGroupAdmin(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i52.UnassignUserFromGroup>(() => _i52.UnassignUserFromGroup(
      repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i53.UpdateCompany>(() =>
      _i53.UpdateCompany(companyRepository: get<_i29.CompanyRepository>()));
  gh.lazySingleton<_i54.UpdateGroup>(
      () => _i54.UpdateGroup(groupRepository: get<_i36.GroupRepository>()));
  gh.lazySingleton<_i55.UpdateLocation>(() =>
      _i55.UpdateLocation(locationRepository: get<_i39.LocationRepository>()));
  gh.lazySingleton<_i56.UpdateUserData>(
      () => _i56.UpdateUserData(repository: get<_i14.UserProfileRepository>()));
  gh.factory<_i57.UserManagementBloc>(() => _i57.UserManagementBloc(
      approveUser: get<_i18.ApproveUser>(),
      approveUserAndMakeAdmin: get<_i19.ApproveUserAndMakeAdmin>(),
      rejectUser: get<_i41.RejectUser>(),
      suspendUser: get<_i48.SuspendUser>(),
      updateUserData: get<_i56.UpdateUserData>(),
      assignUserToGroup: get<_i22.AssignUserToGroup>(),
      unassignUserFromGroup: get<_i52.UnassignUserFromGroup>(),
      assignGroupAdmin: get<_i20.AssignGroupAdmin>(),
      unassignGroupAdmin: get<_i51.UnassignGroupAdmin>()));
  gh.lazySingleton<_i58.AddCompany>(() => _i58.AddCompany(
      companyManagementRepository: get<_i27.CompanyManagementRepository>()));
  gh.lazySingleton<_i59.AddCompanyLogo>(() =>
      _i59.AddCompanyLogo(repository: get<_i27.CompanyManagementRepository>()));
  gh.lazySingleton<_i60.AddGroup>(
      () => _i60.AddGroup(groupRepository: get<_i36.GroupRepository>()));
  gh.lazySingleton<_i61.AddLocation>(() =>
      _i61.AddLocation(locationRepository: get<_i39.LocationRepository>()));
  gh.factory<_i62.AuthenticationBloc>(() => _i62.AuthenticationBloc(
      signin: get<_i45.Signin>(),
      signup: get<_i47.Signup>(),
      signout: get<_i46.Signout>(),
      autoSignin: get<_i25.AutoSignin>(),
      sendVerificationEmail: get<_i44.SendVerificationEmail>(),
      checkEmailVerification: get<_i26.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i43.SendPasswordResetEmail>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i63.CacheGroups>(
      () => _i63.CacheGroups(groupRepository: get<_i36.GroupRepository>()));
  gh.lazySingleton<_i64.CacheLocation>(() =>
      _i64.CacheLocation(locationRepository: get<_i39.LocationRepository>()));
  gh.lazySingleton<_i65.DeleteGroup>(
      () => _i65.DeleteGroup(groupRepository: get<_i36.GroupRepository>()));
  gh.lazySingleton<_i66.DeleteLocation>(() =>
      _i66.DeleteLocation(locationRepository: get<_i39.LocationRepository>()));
  gh.lazySingleton<_i67.FetchAllLocations>(() => _i67.FetchAllLocations(
      locationRepository: get<_i39.LocationRepository>()));
  gh.lazySingleton<_i68.GetGroupsStream>(
      () => _i68.GetGroupsStream(groupRepository: get<_i36.GroupRepository>()));
  gh.factory<_i69.UserProfileBloc>(() => _i69.UserProfileBloc(
      authenticationBloc: get<_i62.AuthenticationBloc>(),
      addUser: get<_i16.AddUser>(),
      assignUserToCompany: get<_i21.AssignUserToCompany>(),
      resetCompany: get<_i42.ResetCompany>(),
      getUserById: get<_i34.GetUserById>(),
      updateUserData: get<_i56.UpdateUserData>(),
      addUserAvatar: get<_i17.AddUserAvatar>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.factory<_i70.CompanyManagementBloc>(() => _i70.CompanyManagementBloc(
      userProfileBloc: get<_i69.UserProfileBloc>(),
      inputValidator: get<_i8.InputValidator>(),
      addCompany: get<_i58.AddCompany>(),
      fetchAllCompanies: get<_i31.FetchAllCompanies>(),
      addCompanyLogo: get<_i59.AddCompanyLogo>()));
  gh.factory<_i71.CompanyProfileBloc>(() => _i71.CompanyProfileBloc(
      userProfileBloc: get<_i69.UserProfileBloc>(),
      updateCompany: get<_i53.UpdateCompany>(),
      fetchAllCompanyUsers: get<_i32.FetchAllCompanyUsers>(),
      getCompanyById: get<_i33.GetCompanyById>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.factory<_i72.GroupBloc>(() => _i72.GroupBloc(
      companyProfileBloc: get<_i71.CompanyProfileBloc>(),
      addGroup: get<_i60.AddGroup>(),
      updateGroup: get<_i54.UpdateGroup>(),
      deleteGroup: get<_i65.DeleteGroup>(),
      getGroupsStream: get<_i68.GetGroupsStream>(),
      cacheGroups: get<_i63.CacheGroups>(),
      tryToGetCachedGroups: get<_i49.TryToGetCachedGroups>()));
  gh.factory<_i73.LocationBloc>(() => _i73.LocationBloc(
      companyProfileBloc: get<_i71.CompanyProfileBloc>(),
      addLocation: get<_i61.AddLocation>(),
      cacheLocation: get<_i64.CacheLocation>(),
      deleteLocation: get<_i66.DeleteLocation>(),
      fetchAllLocations: get<_i67.FetchAllLocations>(),
      tryToGetCachedLocation: get<_i50.TryToGetCachedLocation>(),
      updateLocation: get<_i55.UpdateLocation>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i74.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i74.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i75.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i75.FirebaseStorageService {}

class _$SharedPreferencesService extends _i75.SharedPreferencesService {}
