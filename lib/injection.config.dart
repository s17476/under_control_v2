// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
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
    as _i90;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i25;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i26;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i51;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i52;
import 'features/authentication/domain/usecases/signin.dart' as _i53;
import 'features/authentication/domain/usecases/signout.dart' as _i54;
import 'features/authentication/domain/usecases/signup.dart' as _i55;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i74;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i28;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i27;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i69;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i33;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i38;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i63;
import 'features/checklists/presentation/blocs/Checklist/checklist_bloc.dart'
    as _i88;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i30;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i32;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i29;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i31;
import 'features/company_profile/domain/usecases/add_company.dart' as _i70;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i71;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i34;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i35;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i36;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i37;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i39;
import 'features/company_profile/domain/usecases/update_company.dart' as _i64;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i82;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i83;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i86;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i87;
import 'features/core/injectable_modules/injectable_modules.dart' as _i91;
import 'features/core/network/network_info.dart' as _i10;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i89;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i42;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i44;
import 'features/groups/domain/repositories/group_repository.dart' as _i43;
import 'features/groups/domain/usecases/add_group.dart' as _i72;
import 'features/groups/domain/usecases/cache_groups.dart' as _i75;
import 'features/groups/domain/usecases/delete_group.dart' as _i77;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i80;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i57;
import 'features/groups/domain/usecases/update_group.dart' as _i65;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i84;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i45;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i9;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i47;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i46;
import 'features/locations/domain/usecases/add_location.dart' as _i73;
import 'features/locations/domain/usecases/cache_location.dart' as _i76;
import 'features/locations/domain/usecases/delete_location.dart' as _i78;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i79;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i58;
import 'features/locations/domain/usecases/update_location.dart' as _i66;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i85;
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
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i40;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i41;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i48;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i49;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i50;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i56;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i59;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i60;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i61;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i62;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i67;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i68;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i81; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i27.CheckListsRepository>(() =>
      _i28.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i29.CompanyManagementRepository>(() =>
      _i30.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i31.CompanyRepository>(() => _i32.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i33.DeleteChecklist>(
      () => _i33.DeleteChecklist(repository: get<_i27.CheckListsRepository>()));
  gh.lazySingleton<_i34.FetchAllCompanies>(() => _i34.FetchAllCompanies(
      companyManagementRepository: get<_i29.CompanyManagementRepository>()));
  gh.lazySingleton<_i35.FetchAllCompanyUsers>(() => _i35.FetchAllCompanyUsers(
      companyRepository: get<_i31.CompanyRepository>()));
  gh.lazySingleton<_i36.FetchNewUsers>(() =>
      _i36.FetchNewUsers(companyRepository: get<_i31.CompanyRepository>()));
  gh.lazySingleton<_i37.FetchSuspendedUsers>(() => _i37.FetchSuspendedUsers(
      companyRepository: get<_i31.CompanyRepository>()));
  gh.lazySingleton<_i38.GetChecklistStream>(() =>
      _i38.GetChecklistStream(repository: get<_i27.CheckListsRepository>()));
  gh.lazySingleton<_i39.GetCompanyById>(() =>
      _i39.GetCompanyById(companyRepository: get<_i31.CompanyRepository>()));
  gh.lazySingleton<_i40.GetUserById>(
      () => _i40.GetUserById(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i41.GetUserStreamById>(() => _i41.GetUserStreamById(
      userRepository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i42.GroupLocalDataSource>(() =>
      _i42.GroupLocalDataSourceImpl(source: get<_i11.SharedPreferences>()));
  gh.lazySingleton<_i43.GroupRepository>(() => _i44.GroupRepositoryImpl(
      groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
      groupLocalDataSource: get<_i42.GroupLocalDataSource>()));
  gh.lazySingleton<_i45.LocationLocalDataSource>(() =>
      _i45.LocationLocalDataSourceImpl(source: get<_i11.SharedPreferences>()));
  gh.lazySingleton<_i46.LocationRepository>(() => _i47.LocationRepositoryImpl(
      locationLocalDataSource: get<_i45.LocationLocalDataSource>(),
      locationRemoteDataSource: get<_i9.LocationRemoteDataSource>()));
  gh.lazySingleton<_i48.MakeUserAdministrator>(() => _i48.MakeUserAdministrator(
      repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i49.RejectUser>(
      () => _i49.RejectUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i50.ResetCompany>(
      () => _i50.ResetCompany(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i51.SendPasswordResetEmail>(() =>
      _i51.SendPasswordResetEmail(
          authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i52.SendVerificationEmail>(() => _i52.SendVerificationEmail(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i53.Signin>(() => _i53.Signin(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i54.Signout>(() => _i54.Signout(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i55.Signup>(() => _i55.Signup(
      authenticationRepository: get<_i23.AuthenticationRepository>()));
  gh.lazySingleton<_i56.SuspendUser>(
      () => _i56.SuspendUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i57.TryToGetCachedGroups>(() =>
      _i57.TryToGetCachedGroups(groupRepository: get<_i43.GroupRepository>()));
  gh.lazySingleton<_i58.TryToGetCachedLocation>(() =>
      _i58.TryToGetCachedLocation(
          locationRepository: get<_i46.LocationRepository>()));
  gh.lazySingleton<_i59.UnassignGroupAdmin>(() =>
      _i59.UnassignGroupAdmin(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i60.UnassignUserFromGroup>(() => _i60.UnassignUserFromGroup(
      repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i61.UnmakeUserAdministrator>(() =>
      _i61.UnmakeUserAdministrator(
          repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i62.UnsuspendUser>(
      () => _i62.UnsuspendUser(repository: get<_i14.UserProfileRepository>()));
  gh.lazySingleton<_i63.UpdateChecklist>(
      () => _i63.UpdateChecklist(repository: get<_i27.CheckListsRepository>()));
  gh.lazySingleton<_i64.UpdateCompany>(() => _i64.UpdateCompany(
      companyRepository: get<_i29.CompanyManagementRepository>()));
  gh.lazySingleton<_i65.UpdateGroup>(
      () => _i65.UpdateGroup(groupRepository: get<_i43.GroupRepository>()));
  gh.lazySingleton<_i66.UpdateLocation>(() =>
      _i66.UpdateLocation(locationRepository: get<_i46.LocationRepository>()));
  gh.lazySingleton<_i67.UpdateUserData>(
      () => _i67.UpdateUserData(repository: get<_i14.UserProfileRepository>()));
  gh.factory<_i68.UserManagementBloc>(() => _i68.UserManagementBloc(
      approveUser: get<_i18.ApproveUser>(),
      makeUserAdministrator: get<_i48.MakeUserAdministrator>(),
      unmakeUserAdministrator: get<_i61.UnmakeUserAdministrator>(),
      approveUserAndMakeAdmin: get<_i19.ApproveUserAndMakeAdmin>(),
      rejectUser: get<_i49.RejectUser>(),
      suspendUser: get<_i56.SuspendUser>(),
      unsuspendUser: get<_i62.UnsuspendUser>(),
      updateUserData: get<_i67.UpdateUserData>(),
      assignUserToGroup: get<_i22.AssignUserToGroup>(),
      unassignUserFromGroup: get<_i60.UnassignUserFromGroup>(),
      assignGroupAdmin: get<_i20.AssignGroupAdmin>(),
      unassignGroupAdmin: get<_i59.UnassignGroupAdmin>(),
      addUserAvatar: get<_i17.AddUserAvatar>()));
  gh.lazySingleton<_i69.AddChecklist>(
      () => _i69.AddChecklist(repository: get<_i27.CheckListsRepository>()));
  gh.lazySingleton<_i70.AddCompany>(() => _i70.AddCompany(
      companyManagementRepository: get<_i29.CompanyManagementRepository>()));
  gh.lazySingleton<_i71.AddCompanyLogo>(() =>
      _i71.AddCompanyLogo(repository: get<_i29.CompanyManagementRepository>()));
  gh.lazySingleton<_i72.AddGroup>(
      () => _i72.AddGroup(groupRepository: get<_i43.GroupRepository>()));
  gh.lazySingleton<_i73.AddLocation>(() =>
      _i73.AddLocation(locationRepository: get<_i46.LocationRepository>()));
  gh.factory<_i74.AuthenticationBloc>(() => _i74.AuthenticationBloc(
      signin: get<_i53.Signin>(),
      signup: get<_i55.Signup>(),
      signout: get<_i54.Signout>(),
      autoSignin: get<_i25.AutoSignin>(),
      sendVerificationEmail: get<_i52.SendVerificationEmail>(),
      checkEmailVerification: get<_i26.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i51.SendPasswordResetEmail>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i75.CacheGroups>(
      () => _i75.CacheGroups(groupRepository: get<_i43.GroupRepository>()));
  gh.lazySingleton<_i76.CacheLocation>(() =>
      _i76.CacheLocation(locationRepository: get<_i46.LocationRepository>()));
  gh.lazySingleton<_i77.DeleteGroup>(
      () => _i77.DeleteGroup(groupRepository: get<_i43.GroupRepository>()));
  gh.lazySingleton<_i78.DeleteLocation>(() =>
      _i78.DeleteLocation(locationRepository: get<_i46.LocationRepository>()));
  gh.lazySingleton<_i79.FetchAllLocations>(() => _i79.FetchAllLocations(
      locationRepository: get<_i46.LocationRepository>()));
  gh.lazySingleton<_i80.GetGroupsStream>(
      () => _i80.GetGroupsStream(groupRepository: get<_i43.GroupRepository>()));
  gh.factory<_i81.UserProfileBloc>(() => _i81.UserProfileBloc(
      authenticationBloc: get<_i74.AuthenticationBloc>(),
      addUser: get<_i16.AddUser>(),
      assignUserToCompany: get<_i21.AssignUserToCompany>(),
      resetCompany: get<_i50.ResetCompany>(),
      getUserById: get<_i40.GetUserById>(),
      getUserStreamById: get<_i41.GetUserStreamById>(),
      updateUserData: get<_i67.UpdateUserData>(),
      addUserAvatar: get<_i17.AddUserAvatar>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.factory<_i82.CompanyManagementBloc>(() => _i82.CompanyManagementBloc(
      userProfileBloc: get<_i81.UserProfileBloc>(),
      inputValidator: get<_i8.InputValidator>(),
      addCompany: get<_i70.AddCompany>(),
      fetchAllCompanies: get<_i34.FetchAllCompanies>(),
      addCompanyLogo: get<_i71.AddCompanyLogo>(),
      updateCompany: get<_i64.UpdateCompany>()));
  gh.factory<_i83.CompanyProfileBloc>(() => _i83.CompanyProfileBloc(
      userProfileBloc: get<_i81.UserProfileBloc>(),
      fetchAllCompanyUsers: get<_i35.FetchAllCompanyUsers>(),
      getCompanyById: get<_i39.GetCompanyById>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i84.GroupBloc>(() => _i84.GroupBloc(
      companyProfileBloc: get<_i83.CompanyProfileBloc>(),
      addGroup: get<_i72.AddGroup>(),
      updateGroup: get<_i65.UpdateGroup>(),
      deleteGroup: get<_i77.DeleteGroup>(),
      getGroupsStream: get<_i80.GetGroupsStream>(),
      cacheGroups: get<_i75.CacheGroups>(),
      tryToGetCachedGroups: get<_i57.TryToGetCachedGroups>()));
  gh.lazySingleton<_i85.LocationBloc>(() => _i85.LocationBloc(
      companyProfileBloc: get<_i83.CompanyProfileBloc>(),
      addLocation: get<_i73.AddLocation>(),
      cacheLocation: get<_i76.CacheLocation>(),
      deleteLocation: get<_i78.DeleteLocation>(),
      fetchAllLocations: get<_i79.FetchAllLocations>(),
      tryToGetCachedLocation: get<_i58.TryToGetCachedLocation>(),
      updateLocation: get<_i66.UpdateLocation>()));
  gh.factory<_i86.NewUsersBloc>(() => _i86.NewUsersBloc(
      get<_i83.CompanyProfileBloc>(), get<_i36.FetchNewUsers>()));
  gh.factory<_i87.SuspendedUsersBloc>(() => _i87.SuspendedUsersBloc(
      get<_i83.CompanyProfileBloc>(), get<_i37.FetchSuspendedUsers>()));
  gh.factory<_i88.ChecklistBloc>(() => _i88.ChecklistBloc(
      companyProfileBloc: get<_i83.CompanyProfileBloc>(),
      getChecklistsStream: get<_i38.GetChecklistStream>()));
  gh.factory<_i89.FilterBloc>(() => _i89.FilterBloc(
      locationBloc: get<_i85.LocationBloc>(),
      groupBloc: get<_i84.GroupBloc>(),
      userProfileBloc: get<_i81.UserProfileBloc>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i90.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i90.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i91.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i91.FirebaseStorageService {}

class _$SharedPreferencesService extends _i91.SharedPreferencesService {}
