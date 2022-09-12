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
import 'package:shared_preferences/shared_preferences.dart' as _i20;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i41;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i40;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i120;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i42;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i43;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i75;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i76;
import 'features/authentication/domain/usecases/signin.dart' as _i77;
import 'features/authentication/domain/usecases/signout.dart' as _i78;
import 'features/authentication/domain/usecases/signup.dart' as _i79;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i98;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i45;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i44;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i93;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i50;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i59;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i87;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i116;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i117;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i47;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i49;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i46;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i48;
import 'features/company_profile/domain/usecases/add_company.dart' as _i94;
import 'features/company_profile/domain/usecases/add_company_logo.dart' as _i95;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i55;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i56;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i57;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i58;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i60;
import 'features/company_profile/domain/usecases/update_company.dart' as _i88;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i106;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i107;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i114;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i115;
import 'features/core/injectable_modules/injectable_modules.dart' as _i121;
import 'features/core/network/network_info.dart' as _i19;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i118;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i66;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i68;
import 'features/groups/domain/repositories/group_repository.dart' as _i67;
import 'features/groups/domain/usecases/add_group.dart' as _i96;
import 'features/groups/domain/usecases/cache_groups.dart' as _i99;
import 'features/groups/domain/usecases/delete_group.dart' as _i101;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i104;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i81;
import 'features/groups/domain/usecases/update_group.dart' as _i89;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i108;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i10;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i12;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i14;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i16;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i9;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i11;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i13;
import 'features/inventory/domain/repositories/item_repository.dart' as _i15;
import 'features/inventory/domain/usecases/add_item.dart' as _i29;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i32;
import 'features/inventory/domain/usecases/delete_item.dart' as _i51;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i54;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i63;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i30;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i52;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i61;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i18;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i22;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i31;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i53;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i62;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i23;
import 'features/inventory/domain/usecases/update_item.dart' as _i21;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i24;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i109;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i110;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i111;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i119;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i112;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i69;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i17;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i71;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i70;
import 'features/locations/domain/usecases/add_location.dart' as _i97;
import 'features/locations/domain/usecases/cache_location.dart' as _i100;
import 'features/locations/domain/usecases/delete_location.dart' as _i102;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i103;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i82;
import 'features/locations/domain/usecases/update_location.dart' as _i90;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i113;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i26;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i28;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i25;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i27;
import 'features/user_profile/domain/usecases/add_user.dart' as _i33;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i34;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i35;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i36;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i37;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i38;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i39;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i64;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i65;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i72;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i73;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i74;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i80;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i83;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i84;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i85;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i86;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i91;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i92;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i105; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i9.ItemActionRepository>(() =>
      _i10.ItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.ItemCategoryRepository>(() =>
      _i12.ItemCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i13.ItemFilesRepository>(() => _i14.ItemFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i15.ItemRepository>(() =>
      _i16.ItemRepositoryImpl(firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i17.LocationRemoteDataSource>(() =>
      _i17.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i18.MoveItemAction>(
      () => _i18.MoveItemAction(repository: get<_i9.ItemActionRepository>()));
  gh.lazySingleton<_i19.NetworkInfo>(() => _i19.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i20.SharedPreferences>(
      () => sharedPreferencesService.shaerdPreferences,
      preResolve: true);
  gh.lazySingleton<_i21.UpdateItem>(
      () => _i21.UpdateItem(repository: get<_i15.ItemRepository>()));
  gh.lazySingleton<_i22.UpdateItemAction>(
      () => _i22.UpdateItemAction(repository: get<_i9.ItemActionRepository>()));
  gh.lazySingleton<_i23.UpdateItemCategory>(() =>
      _i23.UpdateItemCategory(repository: get<_i11.ItemCategoryRepository>()));
  gh.lazySingleton<_i24.UpdateItemPhoto>(
      () => _i24.UpdateItemPhoto(repository: get<_i13.ItemFilesRepository>()));
  gh.lazySingleton<_i25.UserFilesRepository>(() => _i26.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i27.UserProfileRepository>(() =>
      _i28.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i29.AddItem>(
      () => _i29.AddItem(repository: get<_i15.ItemRepository>()));
  gh.lazySingleton<_i30.AddItemAction>(
      () => _i30.AddItemAction(repository: get<_i9.ItemActionRepository>()));
  gh.lazySingleton<_i31.AddItemCategory>(() =>
      _i31.AddItemCategory(repository: get<_i11.ItemCategoryRepository>()));
  gh.lazySingleton<_i32.AddItemPhoto>(
      () => _i32.AddItemPhoto(repository: get<_i13.ItemFilesRepository>()));
  gh.lazySingleton<_i33.AddUser>(
      () => _i33.AddUser(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i34.AddUserAvatar>(
      () => _i34.AddUserAvatar(repository: get<_i25.UserFilesRepository>()));
  gh.lazySingleton<_i35.ApproveUser>(
      () => _i35.ApproveUser(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i36.ApproveUserAndMakeAdmin>(() =>
      _i36.ApproveUserAndMakeAdmin(
          repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i37.AssignGroupAdmin>(() =>
      _i37.AssignGroupAdmin(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i38.AssignUserToCompany>(() =>
      _i38.AssignUserToCompany(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i39.AssignUserToGroup>(() =>
      _i39.AssignUserToGroup(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i40.AuthenticationRepository>(() =>
      _i41.AuthenticationRepositoryImpl(
          firebaseAuth: get<_i4.FirebaseAuth>(),
          networkInfo: get<_i19.NetworkInfo>()));
  gh.lazySingleton<_i42.AutoSignin>(() => _i42.AutoSignin(
      authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i43.CheckEmailVerification>(() =>
      _i43.CheckEmailVerification(
          authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i44.CheckListsRepository>(() =>
      _i45.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i46.CompanyManagementRepository>(() =>
      _i47.CompanyManagementRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>(),
          firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i48.CompanyRepository>(() => _i49.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i50.DeleteChecklist>(
      () => _i50.DeleteChecklist(repository: get<_i44.CheckListsRepository>()));
  gh.lazySingleton<_i51.DeleteItem>(
      () => _i51.DeleteItem(repository: get<_i15.ItemRepository>()));
  gh.lazySingleton<_i52.DeleteItemAction>(
      () => _i52.DeleteItemAction(repository: get<_i9.ItemActionRepository>()));
  gh.lazySingleton<_i53.DeleteItemCategory>(() =>
      _i53.DeleteItemCategory(repository: get<_i11.ItemCategoryRepository>()));
  gh.lazySingleton<_i54.DeleteItemPhoto>(
      () => _i54.DeleteItemPhoto(repository: get<_i13.ItemFilesRepository>()));
  gh.lazySingleton<_i55.FetchAllCompanies>(() => _i55.FetchAllCompanies(
      companyManagementRepository: get<_i46.CompanyManagementRepository>()));
  gh.lazySingleton<_i56.FetchAllCompanyUsers>(() => _i56.FetchAllCompanyUsers(
      companyRepository: get<_i48.CompanyRepository>()));
  gh.lazySingleton<_i57.FetchNewUsers>(() =>
      _i57.FetchNewUsers(companyRepository: get<_i48.CompanyRepository>()));
  gh.lazySingleton<_i58.FetchSuspendedUsers>(() => _i58.FetchSuspendedUsers(
      companyRepository: get<_i48.CompanyRepository>()));
  gh.lazySingleton<_i59.GetChecklistStream>(() =>
      _i59.GetChecklistStream(repository: get<_i44.CheckListsRepository>()));
  gh.lazySingleton<_i60.GetCompanyById>(() =>
      _i60.GetCompanyById(companyRepository: get<_i48.CompanyRepository>()));
  gh.lazySingleton<_i61.GetItemsActionsStream>(() =>
      _i61.GetItemsActionsStream(repository: get<_i9.ItemActionRepository>()));
  gh.lazySingleton<_i62.GetItemsCategoriesStream>(() =>
      _i62.GetItemsCategoriesStream(
          repository: get<_i11.ItemCategoryRepository>()));
  gh.lazySingleton<_i63.GetItemsStream>(
      () => _i63.GetItemsStream(repository: get<_i15.ItemRepository>()));
  gh.lazySingleton<_i64.GetUserById>(
      () => _i64.GetUserById(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i65.GetUserStreamById>(() => _i65.GetUserStreamById(
      userRepository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i66.GroupLocalDataSource>(() =>
      _i66.GroupLocalDataSourceImpl(source: get<_i20.SharedPreferences>()));
  gh.lazySingleton<_i67.GroupRepository>(() => _i68.GroupRepositoryImpl(
      groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
      groupLocalDataSource: get<_i66.GroupLocalDataSource>()));
  gh.lazySingleton<_i69.LocationLocalDataSource>(() =>
      _i69.LocationLocalDataSourceImpl(source: get<_i20.SharedPreferences>()));
  gh.lazySingleton<_i70.LocationRepository>(() => _i71.LocationRepositoryImpl(
      locationLocalDataSource: get<_i69.LocationLocalDataSource>(),
      locationRemoteDataSource: get<_i17.LocationRemoteDataSource>()));
  gh.lazySingleton<_i72.MakeUserAdministrator>(() => _i72.MakeUserAdministrator(
      repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i73.RejectUser>(
      () => _i73.RejectUser(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i74.ResetCompany>(
      () => _i74.ResetCompany(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i75.SendPasswordResetEmail>(() =>
      _i75.SendPasswordResetEmail(
          authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i76.SendVerificationEmail>(() => _i76.SendVerificationEmail(
      authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i77.Signin>(() => _i77.Signin(
      authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i78.Signout>(() => _i78.Signout(
      authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i79.Signup>(() => _i79.Signup(
      authenticationRepository: get<_i40.AuthenticationRepository>()));
  gh.lazySingleton<_i80.SuspendUser>(
      () => _i80.SuspendUser(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i81.TryToGetCachedGroups>(() =>
      _i81.TryToGetCachedGroups(groupRepository: get<_i67.GroupRepository>()));
  gh.lazySingleton<_i82.TryToGetCachedLocation>(() =>
      _i82.TryToGetCachedLocation(
          locationRepository: get<_i70.LocationRepository>()));
  gh.lazySingleton<_i83.UnassignGroupAdmin>(() =>
      _i83.UnassignGroupAdmin(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i84.UnassignUserFromGroup>(() => _i84.UnassignUserFromGroup(
      repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i85.UnmakeUserAdministrator>(() =>
      _i85.UnmakeUserAdministrator(
          repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i86.UnsuspendUser>(
      () => _i86.UnsuspendUser(repository: get<_i27.UserProfileRepository>()));
  gh.lazySingleton<_i87.UpdateChecklist>(
      () => _i87.UpdateChecklist(repository: get<_i44.CheckListsRepository>()));
  gh.lazySingleton<_i88.UpdateCompany>(() => _i88.UpdateCompany(
      companyRepository: get<_i46.CompanyManagementRepository>()));
  gh.lazySingleton<_i89.UpdateGroup>(
      () => _i89.UpdateGroup(groupRepository: get<_i67.GroupRepository>()));
  gh.lazySingleton<_i90.UpdateLocation>(() =>
      _i90.UpdateLocation(locationRepository: get<_i70.LocationRepository>()));
  gh.lazySingleton<_i91.UpdateUserData>(
      () => _i91.UpdateUserData(repository: get<_i27.UserProfileRepository>()));
  gh.factory<_i92.UserManagementBloc>(() => _i92.UserManagementBloc(
      approveUser: get<_i35.ApproveUser>(),
      makeUserAdministrator: get<_i72.MakeUserAdministrator>(),
      unmakeUserAdministrator: get<_i85.UnmakeUserAdministrator>(),
      approveUserAndMakeAdmin: get<_i36.ApproveUserAndMakeAdmin>(),
      rejectUser: get<_i73.RejectUser>(),
      suspendUser: get<_i80.SuspendUser>(),
      unsuspendUser: get<_i86.UnsuspendUser>(),
      updateUserData: get<_i91.UpdateUserData>(),
      assignUserToGroup: get<_i39.AssignUserToGroup>(),
      unassignUserFromGroup: get<_i84.UnassignUserFromGroup>(),
      assignGroupAdmin: get<_i37.AssignGroupAdmin>(),
      unassignGroupAdmin: get<_i83.UnassignGroupAdmin>(),
      addUserAvatar: get<_i34.AddUserAvatar>()));
  gh.lazySingleton<_i93.AddChecklist>(
      () => _i93.AddChecklist(repository: get<_i44.CheckListsRepository>()));
  gh.lazySingleton<_i94.AddCompany>(() => _i94.AddCompany(
      companyManagementRepository: get<_i46.CompanyManagementRepository>()));
  gh.lazySingleton<_i95.AddCompanyLogo>(() =>
      _i95.AddCompanyLogo(repository: get<_i46.CompanyManagementRepository>()));
  gh.lazySingleton<_i96.AddGroup>(
      () => _i96.AddGroup(groupRepository: get<_i67.GroupRepository>()));
  gh.lazySingleton<_i97.AddLocation>(() =>
      _i97.AddLocation(locationRepository: get<_i70.LocationRepository>()));
  gh.factory<_i98.AuthenticationBloc>(() => _i98.AuthenticationBloc(
      signin: get<_i77.Signin>(),
      signup: get<_i79.Signup>(),
      signout: get<_i78.Signout>(),
      autoSignin: get<_i42.AutoSignin>(),
      sendVerificationEmail: get<_i76.SendVerificationEmail>(),
      checkEmailVerification: get<_i43.CheckEmailVerification>(),
      sendPasswordResetEmail: get<_i75.SendPasswordResetEmail>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i99.CacheGroups>(
      () => _i99.CacheGroups(groupRepository: get<_i67.GroupRepository>()));
  gh.lazySingleton<_i100.CacheLocation>(() =>
      _i100.CacheLocation(locationRepository: get<_i70.LocationRepository>()));
  gh.lazySingleton<_i101.DeleteGroup>(
      () => _i101.DeleteGroup(groupRepository: get<_i67.GroupRepository>()));
  gh.lazySingleton<_i102.DeleteLocation>(() =>
      _i102.DeleteLocation(locationRepository: get<_i70.LocationRepository>()));
  gh.lazySingleton<_i103.FetchAllLocations>(() => _i103.FetchAllLocations(
      locationRepository: get<_i70.LocationRepository>()));
  gh.lazySingleton<_i104.GetGroupsStream>(() =>
      _i104.GetGroupsStream(groupRepository: get<_i67.GroupRepository>()));
  gh.factory<_i105.UserProfileBloc>(() => _i105.UserProfileBloc(
      authenticationBloc: get<_i98.AuthenticationBloc>(),
      addUser: get<_i33.AddUser>(),
      assignUserToCompany: get<_i38.AssignUserToCompany>(),
      resetCompany: get<_i74.ResetCompany>(),
      getUserById: get<_i64.GetUserById>(),
      getUserStreamById: get<_i65.GetUserStreamById>(),
      updateUserData: get<_i91.UpdateUserData>(),
      addUserAvatar: get<_i34.AddUserAvatar>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.factory<_i106.CompanyManagementBloc>(() => _i106.CompanyManagementBloc(
      userProfileBloc: get<_i105.UserProfileBloc>(),
      inputValidator: get<_i8.InputValidator>(),
      addCompany: get<_i94.AddCompany>(),
      fetchAllCompanies: get<_i55.FetchAllCompanies>(),
      addCompanyLogo: get<_i95.AddCompanyLogo>(),
      updateCompany: get<_i88.UpdateCompany>()));
  gh.factory<_i107.CompanyProfileBloc>(() => _i107.CompanyProfileBloc(
      userProfileBloc: get<_i105.UserProfileBloc>(),
      fetchAllCompanyUsers: get<_i56.FetchAllCompanyUsers>(),
      getCompanyById: get<_i60.GetCompanyById>(),
      inputValidator: get<_i8.InputValidator>()));
  gh.lazySingleton<_i108.GroupBloc>(() => _i108.GroupBloc(
      companyProfileBloc: get<_i107.CompanyProfileBloc>(),
      addGroup: get<_i96.AddGroup>(),
      updateGroup: get<_i89.UpdateGroup>(),
      deleteGroup: get<_i101.DeleteGroup>(),
      getGroupsStream: get<_i104.GetGroupsStream>(),
      cacheGroups: get<_i99.CacheGroups>(),
      tryToGetCachedGroups: get<_i81.TryToGetCachedGroups>()));
  gh.factory<_i109.ItemActionManagementBloc>(() =>
      _i109.ItemActionManagementBloc(
          companyProfileBloc: get<_i107.CompanyProfileBloc>(),
          addItemAction: get<_i30.AddItemAction>(),
          updateItemAction: get<_i22.UpdateItemAction>(),
          deleteItemAction: get<_i52.DeleteItemAction>(),
          moveItemAction: get<_i18.MoveItemAction>()));
  gh.lazySingleton<_i110.ItemCategoryBloc>(() => _i110.ItemCategoryBloc(
      userProfileBloc: get<_i105.UserProfileBloc>(),
      getItemsCategoriesStream: get<_i62.GetItemsCategoriesStream>()));
  gh.factory<_i111.ItemCategoryManagementBloc>(() =>
      _i111.ItemCategoryManagementBloc(
          companyProfileBloc: get<_i107.CompanyProfileBloc>(),
          addItemCategory: get<_i31.AddItemCategory>(),
          updateItemCategory: get<_i23.UpdateItemCategory>(),
          deleteItemCategory: get<_i53.DeleteItemCategory>()));
  gh.factory<_i112.ItemsManagementBloc>(() => _i112.ItemsManagementBloc(
      addItemPhoto: get<_i32.AddItemPhoto>(),
      deleteItemPhoto: get<_i54.DeleteItemPhoto>(),
      updateItemPhoto: get<_i24.UpdateItemPhoto>(),
      companyProfileBloc: get<_i107.CompanyProfileBloc>(),
      addItem: get<_i29.AddItem>(),
      deleteItem: get<_i51.DeleteItem>(),
      updateItem: get<_i21.UpdateItem>()));
  gh.lazySingleton<_i113.LocationBloc>(() => _i113.LocationBloc(
      companyProfileBloc: get<_i107.CompanyProfileBloc>(),
      addLocation: get<_i97.AddLocation>(),
      cacheLocation: get<_i100.CacheLocation>(),
      deleteLocation: get<_i102.DeleteLocation>(),
      fetchAllLocations: get<_i103.FetchAllLocations>(),
      tryToGetCachedLocation: get<_i82.TryToGetCachedLocation>(),
      updateLocation: get<_i90.UpdateLocation>()));
  gh.factory<_i114.NewUsersBloc>(() => _i114.NewUsersBloc(
      get<_i107.CompanyProfileBloc>(), get<_i57.FetchNewUsers>()));
  gh.factory<_i115.SuspendedUsersBloc>(() => _i115.SuspendedUsersBloc(
      get<_i107.CompanyProfileBloc>(), get<_i58.FetchSuspendedUsers>()));
  gh.lazySingleton<_i116.ChecklistBloc>(() => _i116.ChecklistBloc(
      companyProfileBloc: get<_i107.CompanyProfileBloc>(),
      getChecklistsStream: get<_i59.GetChecklistStream>()));
  gh.factory<_i117.ChecklistManagementBloc>(() => _i117.ChecklistManagementBloc(
      companyProfileBloc: get<_i107.CompanyProfileBloc>(),
      addChecklist: get<_i93.AddChecklist>(),
      updateChecklist: get<_i87.UpdateChecklist>(),
      deleteChecklist: get<_i50.DeleteChecklist>()));
  gh.factory<_i118.FilterBloc>(() => _i118.FilterBloc(
      locationBloc: get<_i113.LocationBloc>(),
      groupBloc: get<_i108.GroupBloc>(),
      userProfileBloc: get<_i105.UserProfileBloc>()));
  gh.factory<_i119.ItemsBloc>(() => _i119.ItemsBloc(
      filterBloc: get<_i118.FilterBloc>(),
      getChecklistsStream: get<_i63.GetItemsStream>()));
  return get;
}

class _$DataConnectionCheckerModule extends _i120.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i120.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i121.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i121.FirebaseStorageService {}

class _$SharedPreferencesService extends _i121.SharedPreferencesService {}
