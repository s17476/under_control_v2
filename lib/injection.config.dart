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
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i32;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i31;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i105;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i33;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i34;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i63;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i64;
import 'features/authentication/domain/usecases/signin.dart' as _i65;
import 'features/authentication/domain/usecases/signout.dart' as _i66;
import 'features/authentication/domain/usecases/signup.dart' as _i67;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i86;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i36;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i35;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i81;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i41;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i48;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i75;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i102;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i103;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i38;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i40;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i37;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i39;
import 'features/company_profile/domain/usecases/add_company.dart' as _i82;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i83;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i44;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i45;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i46;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i47;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i49;
import 'features/company_profile/domain/usecases/update_company.dart' as _i76;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i94;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i95;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i100;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i101;
import 'features/core/injectable_modules/injectable_modules.dart' as _i106;
import 'features/core/network/network_info.dart' as _i14;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i104;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i54;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i56;
import 'features/groups/domain/repositories/group_repository.dart' as _i55;
import 'features/groups/domain/usecases/add_group.dart' as _i84;
import 'features/groups/domain/usecases/cache_groups.dart' as _i87;
import 'features/groups/domain/usecases/delete_group.dart' as _i89;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i92;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i69;
import 'features/groups/domain/usecases/update_group.dart' as _i77;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i96;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i10;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i12;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i9;
import 'features/inventory/domain/repositories/item_repository.dart' as _i11;
import 'features/inventory/domain/usecases/add_item.dart' as _i22;
import 'features/inventory/domain/usecases/add_item_category.dart' as _i23;
import 'features/inventory/domain/usecases/delete_item.dart' as _i42;
import 'features/inventory/domain/usecases/delete_item_category.dart' as _i43;
import 'features/inventory/domain/usecases/get_items_categories_stream.dart'
    as _i50;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i51;
import 'features/inventory/domain/usecases/update_item.dart' as _i16;
import 'features/inventory/domain/usecases/update_item_category.dart' as _i17;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i97;
import 'features/inventory/presentation/blocs/item_category_management_bloc.dart/item_category_management_bloc.dart'
    as _i98;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i57;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i13;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i59;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i58;
import 'features/locations/domain/usecases/add_location.dart' as _i85;
import 'features/locations/domain/usecases/cache_location.dart' as _i88;
import 'features/locations/domain/usecases/delete_location.dart' as _i90;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i91;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i70;
import 'features/locations/domain/usecases/update_location.dart' as _i78;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i99;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i19;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i21;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i18;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i20;
import 'features/user_profile/domain/usecases/add_user.dart' as _i24;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i25;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i26;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i27;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i28;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i29;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i30;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i52;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i53;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i60;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i61;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i62;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i68;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i71;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i72;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i73;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i74;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i79;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i80;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i93; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i9.ItemCategoryRepository>(() =>
      _i10.ItemCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.ItemRepository>(() =>
      _i12.ItemRepositoryImpl(firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i13.LocationRemoteDataSource>(() =>
      _i13.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i14.NetworkInfo>(() => _i14.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i15.SharedPreferences>(
      () => sharedPreferencesService.shaerdPreferences,
      preResolve: true);
  gh.lazySingleton<_i16.UpdateItem>(
      () => _i16.UpdateItem(repository: get<_i11.ItemRepository>()));
  gh.lazySingleton<_i17.UpdateItemCategory>(() =>
      _i17.UpdateItemCategory(repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i18.UserFilesRepository>(() => _i19.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i20.UserProfileRepository>(() =>
      _i21.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i22.AddItem>(
      () => _i22.AddItem(repository: get<_i11.ItemRepository>()));
  gh.lazySingleton<_i23.AddItemCategory>(() =>
      _i23.AddItemCategory(repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i24.AddUser>(
      () => _i24.AddUser(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i25.AddUserAvatar>(
      () => _i25.AddUserAvatar(repository: get<_i18.UserFilesRepository>()));
  gh.lazySingleton<_i26.ApproveUser>(
      () => _i26.ApproveUser(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i27.ApproveUserAndMakeAdmin>(() =>
      _i27.ApproveUserAndMakeAdmin(
          repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i28.AssignGroupAdmin>(() =>
      _i28.AssignGroupAdmin(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i29.AssignUserToCompany>(() =>
      _i29.AssignUserToCompany(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i30.AssignUserToGroup>(() =>
      _i30.AssignUserToGroup(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i31.AuthenticationRepository>(() =>
      _i32.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i14.NetworkInfo>()));
  gh.lazySingleton<_i33.AutoSignin>(() => _i33.AutoSignin(
      authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i34.CheckEmailVerification>(() =>
      _i34.CheckEmailVerification(
          authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i35.CheckListsRepository>(() =>
      _i36.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i37.CompanyManagementRepository>(() =>
      _i38.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i39.CompanyRepository>(() => _i40.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i41.DeleteChecklist>(
      () => _i41.DeleteChecklist(repository: get<_i35.CheckListsRepository>()));
  gh.lazySingleton<_i42.DeleteItem>(
      () => _i42.DeleteItem(repository: get<_i11.ItemRepository>()));
  gh.lazySingleton<_i43.DeleteItemCategory>(() =>
      _i43.DeleteItemCategory(repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i44.FetchAllCompanies>(() => _i44.FetchAllCompanies(
      companyManagementRepository: get<_i37.CompanyManagementRepository>()));
  gh.lazySingleton<_i45.FetchAllCompanyUsers>(() => _i45.FetchAllCompanyUsers(
      companyRepository: get<_i39.CompanyRepository>()));
  gh.lazySingleton<_i46.FetchNewUsers>(() =>
      _i46.FetchNewUsers(companyRepository: get<_i39.CompanyRepository>()));
  gh.lazySingleton<_i47.FetchSuspendedUsers>(() => _i47.FetchSuspendedUsers(
      companyRepository: get<_i39.CompanyRepository>()));
  gh.lazySingleton<_i48.GetChecklistStream>(() =>
      _i48.GetChecklistStream(repository: get<_i35.CheckListsRepository>()));
  gh.lazySingleton<_i49.GetCompanyById>(() =>
      _i49.GetCompanyById(companyRepository: get<_i39.CompanyRepository>()));
  gh.lazySingleton<_i50.GetItemsCategoriesStream>(() =>
      _i50.GetItemsCategoriesStream(
          repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i51.GetItemsStream>(
      () => _i51.GetItemsStream(repository: get<_i11.ItemRepository>()));
  gh.lazySingleton<_i52.GetUserById>(
      () => _i52.GetUserById(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i53.GetUserStreamById>(() => _i53.GetUserStreamById(
      userRepository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i54.GroupLocalDataSource>(() =>
      _i54.GroupLocalDataSourceImpl(source: get<_i15.SharedPreferences>()));
  gh.lazySingleton<_i55.GroupRepository>(() => _i56.GroupRepositoryImpl(
      groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
      groupLocalDataSource: get<_i54.GroupLocalDataSource>()));
  gh.lazySingleton<_i57.LocationLocalDataSource>(() =>
      _i57.LocationLocalDataSourceImpl(source: get<_i15.SharedPreferences>()));
  gh.lazySingleton<_i58.LocationRepository>(() => _i59.LocationRepositoryImpl(
      locationLocalDataSource: get<_i57.LocationLocalDataSource>(),
      locationRemoteDataSource: get<_i13.LocationRemoteDataSource>()));
  gh.lazySingleton<_i60.MakeUserAdministrator>(() => _i60.MakeUserAdministrator(
      repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i61.RejectUser>(
      () => _i61.RejectUser(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i62.ResetCompany>(
      () => _i62.ResetCompany(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i63.SendPasswordResetEmail>(() =>
      _i63.SendPasswordResetEmail(
          authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i64.SendVerificationEmail>(() => _i64.SendVerificationEmail(
      authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i65.Signin>(() => _i65.Signin(
      authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i66.Signout>(() => _i66.Signout(
      authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i67.Signup>(() => _i67.Signup(
      authenticationRepository: get<_i31.AuthenticationRepository>()));
  gh.lazySingleton<_i68.SuspendUser>(
      () => _i68.SuspendUser(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i69.TryToGetCachedGroups>(() =>
      _i69.TryToGetCachedGroups(groupRepository: get<_i55.GroupRepository>()));
  gh.lazySingleton<_i70.TryToGetCachedLocation>(() =>
      _i70.TryToGetCachedLocation(
          locationRepository: get<_i58.LocationRepository>()));
  gh.lazySingleton<_i71.UnassignGroupAdmin>(() =>
      _i71.UnassignGroupAdmin(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i72.UnassignUserFromGroup>(() => _i72.UnassignUserFromGroup(
      repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i73.UnmakeUserAdministrator>(() =>
      _i73.UnmakeUserAdministrator(
          repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i74.UnsuspendUser>(
      () => _i74.UnsuspendUser(repository: get<_i20.UserProfileRepository>()));
  gh.lazySingleton<_i75.UpdateChecklist>(
      () => _i75.UpdateChecklist(repository: get<_i35.CheckListsRepository>()));
  gh.lazySingleton<_i76.UpdateCompany>(() => _i76.UpdateCompany(
      companyRepository: get<_i37.CompanyManagementRepository>()));
  gh.lazySingleton<_i77.UpdateGroup>(
      () => _i77.UpdateGroup(groupRepository: get<_i55.GroupRepository>()));
  gh.lazySingleton<_i78.UpdateLocation>(() =>
      _i78.UpdateLocation(locationRepository: get<_i58.LocationRepository>()));
  gh.lazySingleton<_i79.UpdateUserData>(
      () => _i79.UpdateUserData(repository: get<_i20.UserProfileRepository>()));
  gh.factory<_i80.UserManagementBloc>(() => _i80.UserManagementBloc(
      approveUser: get<_i26.ApproveUser>(),
      makeUserAdministrator: get<_i60.MakeUserAdministrator>(),
      unmakeUserAdministrator: get<_i73.UnmakeUserAdministrator>(),
      approveUserAndMakeAdmin: get<_i27.ApproveUserAndMakeAdmin>(),
      rejectUser: get<_i61.RejectUser>(),
      suspendUser: get<_i68.SuspendUser>(),
      unsuspendUser: get<_i74.UnsuspendUser>(),
      updateUserData: get<_i79.UpdateUserData>(),
      assignUserToGroup: get<_i30.AssignUserToGroup>(),
      unassignUserFromGroup: get<_i72.UnassignUserFromGroup>(),
      assignGroupAdmin: get<_i28.AssignGroupAdmin>(),
      unassignGroupAdmin: get<_i71.UnassignGroupAdmin>(),
      addUserAvatar: get<_i25.AddUserAvatar>()));
  gh.lazySingleton<_i81.AddChecklist>(
      () => _i81.AddChecklist(repository: get<_i35.CheckListsRepository>()));
  gh.lazySingleton<_i82.AddCompany>(() => _i82.AddCompany(
      companyManagementRepository: get<_i37.CompanyManagementRepository>()));
  gh.lazySingleton<_i83.AddCompanyLogo>(() =>
      _i83.AddCompanyLogo(repository: get<_i37.CompanyManagementRepository>()));
  gh.lazySingleton<_i84.AddGroup>(
      () => _i84.AddGroup(groupRepository: get<_i55.GroupRepository>()));
  gh.lazySingleton<_i85.AddLocation>(() =>
      _i85.AddLocation(locationRepository: get<_i58.LocationRepository>()));
  gh.factory<_i86.AuthenticationBloc>(() => _i86.AuthenticationBloc(
      signin: get<_i65.Signin>(),
      signup: get<_i67.Signup>(),
      signout: get<_i66.Signout>(),
      autoSignin: get<_i33.AutoSignin>(),
      sendVerificationEmail: get<_i64.SendVerificationEmail>(),
      checkEmailVerification: get<_i34.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i63.SendPasswordResetEmail>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i87.CacheGroups>(
      () => _i87.CacheGroups(groupRepository: get<_i55.GroupRepository>()));
  gh.lazySingleton<_i88.CacheLocation>(() =>
      _i88.CacheLocation(locationRepository: get<_i58.LocationRepository>()));
  gh.lazySingleton<_i89.DeleteGroup>(
      () => _i89.DeleteGroup(groupRepository: get<_i55.GroupRepository>()));
  gh.lazySingleton<_i90.DeleteLocation>(() =>
      _i90.DeleteLocation(locationRepository: get<_i58.LocationRepository>()));
  gh.lazySingleton<_i91.FetchAllLocations>(() => _i91.FetchAllLocations(
      locationRepository: get<_i58.LocationRepository>()));
  gh.lazySingleton<_i92.GetGroupsStream>(
      () => _i92.GetGroupsStream(groupRepository: get<_i55.GroupRepository>()));
  gh.factory<_i93.UserProfileBloc>(() => _i93.UserProfileBloc(
      authenticationBloc: get<_i86.AuthenticationBloc>(),
      addUser: get<_i24.AddUser>(),
      assignUserToCompany: get<_i29.AssignUserToCompany>(),
      resetCompany: get<_i62.ResetCompany>(),
      getUserById: get<_i52.GetUserById>(),
      getUserStreamById: get<_i53.GetUserStreamById>(),
      updateUserData: get<_i79.UpdateUserData>(),
      addUserAvatar: get<_i25.AddUserAvatar>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.factory<_i94.CompanyManagementBloc>(() => _i94.CompanyManagementBloc(
      userProfileBloc: get<_i93.UserProfileBloc>(),
      inputValidator: get<_i8.InputValidator>(),
      addCompany: get<_i82.AddCompany>(),
      fetchAllCompanies: get<_i44.FetchAllCompanies>(),
      addCompanyLogo: get<_i83.AddCompanyLogo>(),
      updateCompany: get<_i76.UpdateCompany>()));
  gh.factory<_i95.CompanyProfileBloc>(() => _i95.CompanyProfileBloc(
      userProfileBloc: get<_i93.UserProfileBloc>(),
      fetchAllCompanyUsers: get<_i45.FetchAllCompanyUsers>(),
      getCompanyById: get<_i49.GetCompanyById>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i96.GroupBloc>(() => _i96.GroupBloc(
      companyProfileBloc: get<_i95.CompanyProfileBloc>(),
      addGroup: get<_i84.AddGroup>(),
      updateGroup: get<_i77.UpdateGroup>(),
      deleteGroup: get<_i89.DeleteGroup>(),
      getGroupsStream: get<_i92.GetGroupsStream>(),
      cacheGroups: get<_i87.CacheGroups>(),
      tryToGetCachedGroups: get<_i69.TryToGetCachedGroups>()));
  gh.lazySingleton<_i97.ItemCategoryBloc>(() => _i97.ItemCategoryBloc(
      userProfileBloc: get<_i93.UserProfileBloc>(),
      getItemsCategoriesStream: get<_i50.GetItemsCategoriesStream>()));
  gh.factory<_i98.ItemCategoryManagementBloc>(() =>
      _i98.ItemCategoryManagementBloc(
          companyProfileBloc: get<_i95.CompanyProfileBloc>(),
          addItemCategory: get<_i23.AddItemCategory>(),
          updateItemCategory: get<_i17.UpdateItemCategory>(),
          deleteItemCategory: get<_i43.DeleteItemCategory>()));
  gh.lazySingleton<_i99.LocationBloc>(() => _i99.LocationBloc(
      companyProfileBloc: get<_i95.CompanyProfileBloc>(),
      addLocation: get<_i85.AddLocation>(),
      cacheLocation: get<_i88.CacheLocation>(),
      deleteLocation: get<_i90.DeleteLocation>(),
      fetchAllLocations: get<_i91.FetchAllLocations>(),
      tryToGetCachedLocation: get<_i70.TryToGetCachedLocation>(),
      updateLocation: get<_i78.UpdateLocation>()));
  gh.factory<_i100.NewUsersBloc>(() => _i100.NewUsersBloc(
      get<_i95.CompanyProfileBloc>(), get<_i46.FetchNewUsers>()));
  gh.factory<_i101.SuspendedUsersBloc>(() => _i101.SuspendedUsersBloc(
      get<_i95.CompanyProfileBloc>(), get<_i47.FetchSuspendedUsers>()));
  gh.factory<_i102.ChecklistBloc>(() => _i102.ChecklistBloc(
      companyProfileBloc: get<_i95.CompanyProfileBloc>(),
      getChecklistsStream: get<_i48.GetChecklistStream>()));
  gh.factory<_i103.ChecklistManagementBloc>(() => _i103.ChecklistManagementBloc(
      companyProfileBloc: get<_i95.CompanyProfileBloc>(),
      addChecklist: get<_i81.AddChecklist>(),
      updateChecklist: get<_i75.UpdateChecklist>(),
      deleteChecklist: get<_i41.DeleteChecklist>()));
  gh.factory<_i104.FilterBloc>(() => _i104.FilterBloc(
      locationBloc: get<_i99.LocationBloc>(),
      groupBloc: get<_i96.GroupBloc>(),
      userProfileBloc: get<_i93.UserProfileBloc>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i105.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i105.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i106.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i106.FirebaseStorageService {}

class _$SharedPreferencesService extends _i106.SharedPreferencesService {}
