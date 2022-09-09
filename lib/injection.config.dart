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
import 'package:shared_preferences/shared_preferences.dart' as _i17;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i36;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i35;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i112;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i37;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i38;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i68;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i69;
import 'features/authentication/domain/usecases/signin.dart' as _i70;
import 'features/authentication/domain/usecases/signout.dart' as _i71;
import 'features/authentication/domain/usecases/signup.dart' as _i72;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i91;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i40;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i39;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i86;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i45;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i53;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i80;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i108;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i109;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i42;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i44;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i41;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i43;
import 'features/company_profile/domain/usecases/add_company.dart' as _i87;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i88;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i49;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i50;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i51;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i52;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i54;
import 'features/company_profile/domain/usecases/update_company.dart' as _i81;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i99;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i100;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i106;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i107;
import 'features/core/injectable_modules/injectable_modules.dart' as _i113;
import 'features/core/network/network_info.dart' as _i16;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i110;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i59;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i61;
import 'features/groups/domain/repositories/group_repository.dart' as _i60;
import 'features/groups/domain/usecases/add_group.dart' as _i89;
import 'features/groups/domain/usecases/cache_groups.dart' as _i92;
import 'features/groups/domain/usecases/delete_group.dart' as _i94;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i97;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i74;
import 'features/groups/domain/usecases/update_group.dart' as _i82;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i101;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i10;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i12;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i14;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i9;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i11;
import 'features/inventory/domain/repositories/item_repository.dart' as _i13;
import 'features/inventory/domain/usecases/add_item.dart' as _i25;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i26;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i27;
import 'features/inventory/domain/usecases/delete_item.dart' as _i46;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i47;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i48;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i55;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i56;
import 'features/inventory/domain/usecases/update_item.dart' as _i18;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i19;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i20;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i102;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i103;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i111;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i104;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i62;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i15;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i64;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i63;
import 'features/locations/domain/usecases/add_location.dart' as _i90;
import 'features/locations/domain/usecases/cache_location.dart' as _i93;
import 'features/locations/domain/usecases/delete_location.dart' as _i95;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i96;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i75;
import 'features/locations/domain/usecases/update_location.dart' as _i83;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i105;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i22;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i24;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i21;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i23;
import 'features/user_profile/domain/usecases/add_user.dart' as _i28;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i29;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i30;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i31;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i32;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i33;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i34;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i57;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i58;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i65;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i66;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i67;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i73;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i76;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i77;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i78;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i79;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i84;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i85;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i98; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i11.ItemFilesRepository>(() => _i12.ItemFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i13.ItemRepository>(() =>
      _i14.ItemRepositoryImpl(firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i15.LocationRemoteDataSource>(() =>
      _i15.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i16.NetworkInfo>(() => _i16.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i17.SharedPreferences>(
      () => sharedPreferencesService.shaerdPreferences,
      preResolve: true);
  gh.lazySingleton<_i18.UpdateItem>(
      () => _i18.UpdateItem(repository: get<_i13.ItemRepository>()));
  gh.lazySingleton<_i19.UpdateItemCategory>(() =>
      _i19.UpdateItemCategory(repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i20.UpdateItemPhoto>(
      () => _i20.UpdateItemPhoto(repository: get<_i11.ItemFilesRepository>()));
  gh.lazySingleton<_i21.UserFilesRepository>(() => _i22.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i23.UserProfileRepository>(() =>
      _i24.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i25.AddItem>(
      () => _i25.AddItem(repository: get<_i13.ItemRepository>()));
  gh.lazySingleton<_i26.AddItemCategory>(() =>
      _i26.AddItemCategory(repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i27.AddItemPhoto>(
      () => _i27.AddItemPhoto(repository: get<_i11.ItemFilesRepository>()));
  gh.lazySingleton<_i28.AddUser>(
      () => _i28.AddUser(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i29.AddUserAvatar>(
      () => _i29.AddUserAvatar(repository: get<_i21.UserFilesRepository>()));
  gh.lazySingleton<_i30.ApproveUser>(
      () => _i30.ApproveUser(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i31.ApproveUserAndMakeAdmin>(() =>
      _i31.ApproveUserAndMakeAdmin(
          repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i32.AssignGroupAdmin>(() =>
      _i32.AssignGroupAdmin(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i33.AssignUserToCompany>(() =>
      _i33.AssignUserToCompany(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i34.AssignUserToGroup>(() =>
      _i34.AssignUserToGroup(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i35.AuthenticationRepository>(() =>
      _i36.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i16.NetworkInfo>()));
  gh.lazySingleton<_i37.AutoSignin>(() => _i37.AutoSignin(
      authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i38.CheckEmailVerification>(() =>
      _i38.CheckEmailVerification(
          authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i39.CheckListsRepository>(() =>
      _i40.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i41.CompanyManagementRepository>(() =>
      _i42.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i43.CompanyRepository>(() => _i44.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i45.DeleteChecklist>(
      () => _i45.DeleteChecklist(repository: get<_i39.CheckListsRepository>()));
  gh.lazySingleton<_i46.DeleteItem>(
      () => _i46.DeleteItem(repository: get<_i13.ItemRepository>()));
  gh.lazySingleton<_i47.DeleteItemCategory>(() =>
      _i47.DeleteItemCategory(repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i48.DeleteItemPhoto>(
      () => _i48.DeleteItemPhoto(repository: get<_i11.ItemFilesRepository>()));
  gh.lazySingleton<_i49.FetchAllCompanies>(() => _i49.FetchAllCompanies(
      companyManagementRepository: get<_i41.CompanyManagementRepository>()));
  gh.lazySingleton<_i50.FetchAllCompanyUsers>(() => _i50.FetchAllCompanyUsers(
      companyRepository: get<_i43.CompanyRepository>()));
  gh.lazySingleton<_i51.FetchNewUsers>(() =>
      _i51.FetchNewUsers(companyRepository: get<_i43.CompanyRepository>()));
  gh.lazySingleton<_i52.FetchSuspendedUsers>(() => _i52.FetchSuspendedUsers(
      companyRepository: get<_i43.CompanyRepository>()));
  gh.lazySingleton<_i53.GetChecklistStream>(() =>
      _i53.GetChecklistStream(repository: get<_i39.CheckListsRepository>()));
  gh.lazySingleton<_i54.GetCompanyById>(() =>
      _i54.GetCompanyById(companyRepository: get<_i43.CompanyRepository>()));
  gh.lazySingleton<_i55.GetItemsCategoriesStream>(() =>
      _i55.GetItemsCategoriesStream(
          repository: get<_i9.ItemCategoryRepository>()));
  gh.lazySingleton<_i56.GetItemsStream>(
      () => _i56.GetItemsStream(repository: get<_i13.ItemRepository>()));
  gh.lazySingleton<_i57.GetUserById>(
      () => _i57.GetUserById(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i58.GetUserStreamById>(() => _i58.GetUserStreamById(
      userRepository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i59.GroupLocalDataSource>(() =>
      _i59.GroupLocalDataSourceImpl(source: get<_i17.SharedPreferences>()));
  gh.lazySingleton<_i60.GroupRepository>(() => _i61.GroupRepositoryImpl(
      groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
      groupLocalDataSource: get<_i59.GroupLocalDataSource>()));
  gh.lazySingleton<_i62.LocationLocalDataSource>(() =>
      _i62.LocationLocalDataSourceImpl(source: get<_i17.SharedPreferences>()));
  gh.lazySingleton<_i63.LocationRepository>(() => _i64.LocationRepositoryImpl(
      locationLocalDataSource: get<_i62.LocationLocalDataSource>(),
      locationRemoteDataSource: get<_i15.LocationRemoteDataSource>()));
  gh.lazySingleton<_i65.MakeUserAdministrator>(() => _i65.MakeUserAdministrator(
      repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i66.RejectUser>(
      () => _i66.RejectUser(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i67.ResetCompany>(
      () => _i67.ResetCompany(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i68.SendPasswordResetEmail>(() =>
      _i68.SendPasswordResetEmail(
          authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i69.SendVerificationEmail>(() => _i69.SendVerificationEmail(
      authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i70.Signin>(() => _i70.Signin(
      authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i71.Signout>(() => _i71.Signout(
      authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i72.Signup>(() => _i72.Signup(
      authenticationRepository: get<_i35.AuthenticationRepository>()));
  gh.lazySingleton<_i73.SuspendUser>(
      () => _i73.SuspendUser(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i74.TryToGetCachedGroups>(() =>
      _i74.TryToGetCachedGroups(groupRepository: get<_i60.GroupRepository>()));
  gh.lazySingleton<_i75.TryToGetCachedLocation>(() =>
      _i75.TryToGetCachedLocation(
          locationRepository: get<_i63.LocationRepository>()));
  gh.lazySingleton<_i76.UnassignGroupAdmin>(() =>
      _i76.UnassignGroupAdmin(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i77.UnassignUserFromGroup>(() => _i77.UnassignUserFromGroup(
      repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i78.UnmakeUserAdministrator>(() =>
      _i78.UnmakeUserAdministrator(
          repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i79.UnsuspendUser>(
      () => _i79.UnsuspendUser(repository: get<_i23.UserProfileRepository>()));
  gh.lazySingleton<_i80.UpdateChecklist>(
      () => _i80.UpdateChecklist(repository: get<_i39.CheckListsRepository>()));
  gh.lazySingleton<_i81.UpdateCompany>(() => _i81.UpdateCompany(
      companyRepository: get<_i41.CompanyManagementRepository>()));
  gh.lazySingleton<_i82.UpdateGroup>(
      () => _i82.UpdateGroup(groupRepository: get<_i60.GroupRepository>()));
  gh.lazySingleton<_i83.UpdateLocation>(() =>
      _i83.UpdateLocation(locationRepository: get<_i63.LocationRepository>()));
  gh.lazySingleton<_i84.UpdateUserData>(
      () => _i84.UpdateUserData(repository: get<_i23.UserProfileRepository>()));
  gh.factory<_i85.UserManagementBloc>(() => _i85.UserManagementBloc(
      approveUser: get<_i30.ApproveUser>(),
      makeUserAdministrator: get<_i65.MakeUserAdministrator>(),
      unmakeUserAdministrator: get<_i78.UnmakeUserAdministrator>(),
      approveUserAndMakeAdmin: get<_i31.ApproveUserAndMakeAdmin>(),
      rejectUser: get<_i66.RejectUser>(),
      suspendUser: get<_i73.SuspendUser>(),
      unsuspendUser: get<_i79.UnsuspendUser>(),
      updateUserData: get<_i84.UpdateUserData>(),
      assignUserToGroup: get<_i34.AssignUserToGroup>(),
      unassignUserFromGroup: get<_i77.UnassignUserFromGroup>(),
      assignGroupAdmin: get<_i32.AssignGroupAdmin>(),
      unassignGroupAdmin: get<_i76.UnassignGroupAdmin>(),
      addUserAvatar: get<_i29.AddUserAvatar>()));
  gh.lazySingleton<_i86.AddChecklist>(
      () => _i86.AddChecklist(repository: get<_i39.CheckListsRepository>()));
  gh.lazySingleton<_i87.AddCompany>(() => _i87.AddCompany(
      companyManagementRepository: get<_i41.CompanyManagementRepository>()));
  gh.lazySingleton<_i88.AddCompanyLogo>(() =>
      _i88.AddCompanyLogo(repository: get<_i41.CompanyManagementRepository>()));
  gh.lazySingleton<_i89.AddGroup>(
      () => _i89.AddGroup(groupRepository: get<_i60.GroupRepository>()));
  gh.lazySingleton<_i90.AddLocation>(() =>
      _i90.AddLocation(locationRepository: get<_i63.LocationRepository>()));
  gh.factory<_i91.AuthenticationBloc>(() => _i91.AuthenticationBloc(
      signin: get<_i70.Signin>(),
      signup: get<_i72.Signup>(),
      signout: get<_i71.Signout>(),
      autoSignin: get<_i37.AutoSignin>(),
      sendVerificationEmail: get<_i69.SendVerificationEmail>(),
      checkEmailVerification: get<_i38.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i68.SendPasswordResetEmail>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i92.CacheGroups>(
      () => _i92.CacheGroups(groupRepository: get<_i60.GroupRepository>()));
  gh.lazySingleton<_i93.CacheLocation>(() =>
      _i93.CacheLocation(locationRepository: get<_i63.LocationRepository>()));
  gh.lazySingleton<_i94.DeleteGroup>(
      () => _i94.DeleteGroup(groupRepository: get<_i60.GroupRepository>()));
  gh.lazySingleton<_i95.DeleteLocation>(() =>
      _i95.DeleteLocation(locationRepository: get<_i63.LocationRepository>()));
  gh.lazySingleton<_i96.FetchAllLocations>(() => _i96.FetchAllLocations(
      locationRepository: get<_i63.LocationRepository>()));
  gh.lazySingleton<_i97.GetGroupsStream>(
      () => _i97.GetGroupsStream(groupRepository: get<_i60.GroupRepository>()));
  gh.factory<_i98.UserProfileBloc>(() => _i98.UserProfileBloc(
      authenticationBloc: get<_i91.AuthenticationBloc>(),
      addUser: get<_i28.AddUser>(),
      assignUserToCompany: get<_i33.AssignUserToCompany>(),
      resetCompany: get<_i67.ResetCompany>(),
      getUserById: get<_i57.GetUserById>(),
      getUserStreamById: get<_i58.GetUserStreamById>(),
      updateUserData: get<_i84.UpdateUserData>(),
      addUserAvatar: get<_i29.AddUserAvatar>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.factory<_i99.CompanyManagementBloc>(() => _i99.CompanyManagementBloc(
      userProfileBloc: get<_i98.UserProfileBloc>(),
      inputValidator: get<_i8.InputValidator>(),
      addCompany: get<_i87.AddCompany>(),
      fetchAllCompanies: get<_i49.FetchAllCompanies>(),
      addCompanyLogo: get<_i88.AddCompanyLogo>(),
      updateCompany: get<_i81.UpdateCompany>()));
  gh.factory<_i100.CompanyProfileBloc>(() => _i100.CompanyProfileBloc(
      userProfileBloc: get<_i98.UserProfileBloc>(),
      fetchAllCompanyUsers: get<_i50.FetchAllCompanyUsers>(),
      getCompanyById: get<_i54.GetCompanyById>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i101.GroupBloc>(() => _i101.GroupBloc(
      companyProfileBloc: get<_i100.CompanyProfileBloc>(),
      addGroup: get<_i89.AddGroup>(),
      updateGroup: get<_i82.UpdateGroup>(),
      deleteGroup: get<_i94.DeleteGroup>(),
      getGroupsStream: get<_i97.GetGroupsStream>(),
      cacheGroups: get<_i92.CacheGroups>(),
      tryToGetCachedGroups: get<_i74.TryToGetCachedGroups>()));
  gh.lazySingleton<_i102.ItemCategoryBloc>(() => _i102.ItemCategoryBloc(
      userProfileBloc: get<_i98.UserProfileBloc>(),
      getItemsCategoriesStream: get<_i55.GetItemsCategoriesStream>()));
  gh.factory<_i103.ItemCategoryManagementBloc>(() =>
      _i103.ItemCategoryManagementBloc(
          companyProfileBloc: get<_i100.CompanyProfileBloc>(),
          addItemCategory: get<_i26.AddItemCategory>(),
          updateItemCategory: get<_i19.UpdateItemCategory>(),
          deleteItemCategory: get<_i47.DeleteItemCategory>()));
  gh.factory<_i104.ItemsManagementBloc>(() => _i104.ItemsManagementBloc(
      addItemPhoto: get<_i27.AddItemPhoto>(),
      deleteItemPhoto: get<_i48.DeleteItemPhoto>(),
      updateItemPhoto: get<_i20.UpdateItemPhoto>(),
      companyProfileBloc: get<_i100.CompanyProfileBloc>(),
      addItem: get<_i25.AddItem>(),
      deleteItem: get<_i46.DeleteItem>(),
      updateItem: get<_i18.UpdateItem>()));
  gh.lazySingleton<_i105.LocationBloc>(() => _i105.LocationBloc(
      companyProfileBloc: get<_i100.CompanyProfileBloc>(),
      addLocation: get<_i90.AddLocation>(),
      cacheLocation: get<_i93.CacheLocation>(),
      deleteLocation: get<_i95.DeleteLocation>(),
      fetchAllLocations: get<_i96.FetchAllLocations>(),
      tryToGetCachedLocation: get<_i75.TryToGetCachedLocation>(),
      updateLocation: get<_i83.UpdateLocation>()));
  gh.factory<_i106.NewUsersBloc>(() => _i106.NewUsersBloc(
      get<_i100.CompanyProfileBloc>(), get<_i51.FetchNewUsers>()));
  gh.factory<_i107.SuspendedUsersBloc>(() => _i107.SuspendedUsersBloc(
      get<_i100.CompanyProfileBloc>(), get<_i52.FetchSuspendedUsers>()));
  gh.lazySingleton<_i108.ChecklistBloc>(() => _i108.ChecklistBloc(
      companyProfileBloc: get<_i100.CompanyProfileBloc>(),
      getChecklistsStream: get<_i53.GetChecklistStream>()));
  gh.factory<_i109.ChecklistManagementBloc>(() => _i109.ChecklistManagementBloc(
      companyProfileBloc: get<_i100.CompanyProfileBloc>(),
      addChecklist: get<_i86.AddChecklist>(),
      updateChecklist: get<_i80.UpdateChecklist>(),
      deleteChecklist: get<_i45.DeleteChecklist>()));
  gh.factory<_i110.FilterBloc>(() => _i110.FilterBloc(
      locationBloc: get<_i105.LocationBloc>(),
      groupBloc: get<_i101.GroupBloc>(),
      userProfileBloc: get<_i98.UserProfileBloc>()));
  gh.factory<_i111.ItemsBloc>(() => _i111.ItemsBloc(
      filterBloc: get<_i110.FilterBloc>(),
      getChecklistsStream: get<_i56.GetItemsStream>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i112.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i112.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i113.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i113.FirebaseStorageService {}

class _$SharedPreferencesService extends _i113.SharedPreferencesService {}
