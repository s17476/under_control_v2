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
import 'package:shared_preferences/shared_preferences.dart' as _i22;

import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i46;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i45;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i136;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i47;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i48;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i88;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i89;
import 'features/authentication/domain/usecases/signin.dart' as _i90;
import 'features/authentication/domain/usecases/signout.dart' as _i91;
import 'features/authentication/domain/usecases/signup.dart' as _i92;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i111;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i50;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i49;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i106;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i57;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i67;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i100;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i131;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i132;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i52;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i54;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i51;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i53;
import 'features/company_profile/domain/usecases/add_company.dart' as _i107;
import 'features/company_profile/domain/usecases/add_company_logo.dart'
    as _i108;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i63;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i64;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i65;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i66;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i68;
import 'features/company_profile/domain/usecases/update_company.dart' as _i101;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i119;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i120;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i129;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i130;
import 'features/core/injectable_modules/injectable_modules.dart' as _i137;
import 'features/core/network/network_info.dart' as _i21;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i133;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i78;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i80;
import 'features/groups/domain/repositories/group_repository.dart' as _i79;
import 'features/groups/domain/usecases/add_group.dart' as _i109;
import 'features/groups/domain/usecases/cache_groups.dart' as _i112;
import 'features/groups/domain/usecases/delete_group.dart' as _i114;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i117;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i94;
import 'features/groups/domain/usecases/update_group.dart' as _i102;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i121;
import 'features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i56;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i12;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i14;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i16;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i18;
import 'features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i55;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i11;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i13;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i15;
import 'features/inventory/domain/repositories/item_repository.dart' as _i17;
import 'features/inventory/domain/usecases/add_item.dart' as _i33;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i36;
import 'features/inventory/domain/usecases/delete_item.dart' as _i59;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i62;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i74;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i34;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i60;
import 'features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i69;
import 'features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i70;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i72;
import 'features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i75;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i20;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i25;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i35;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i61;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i73;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i26;
import 'features/inventory/domain/usecases/update_item.dart' as _i24;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i27;
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i135;
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i81;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i124;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i125;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i126;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i134;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i127;
import 'features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i32;
import 'features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i58;
import 'features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i71;
import 'features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i23;
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i122;
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i123;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i82;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i19;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i84;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i83;
import 'features/locations/domain/usecases/add_location.dart' as _i110;
import 'features/locations/domain/usecases/cache_location.dart' as _i113;
import 'features/locations/domain/usecases/delete_location.dart' as _i115;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i116;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i95;
import 'features/locations/domain/usecases/update_location.dart' as _i103;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i128;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i29;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i31;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i28;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i30;
import 'features/user_profile/domain/usecases/add_user.dart' as _i37;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i38;
import 'features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i39;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i40;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i41;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i42;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i43;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i44;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i76;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i77;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i85;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i86;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i87;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i93;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i96;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i97;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i98;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i99;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i104;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i105;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i118; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
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
  gh.lazySingleton<_i9.InstructionCategoryRepository>(() =>
      _i10.InstructionCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.ItemActionRepository>(() =>
      _i12.ItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i13.ItemCategoryRepository>(() =>
      _i14.ItemCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i15.ItemFilesRepository>(() => _i16.ItemFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i17.ItemRepository>(() =>
      _i18.ItemRepositoryImpl(firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i19.LocationRemoteDataSource>(() =>
      _i19.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i20.MoveItemAction>(
      () => _i20.MoveItemAction(repository: get<_i11.ItemActionRepository>()));
  gh.lazySingleton<_i21.NetworkInfo>(() => _i21.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i22.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i23.UpdateInstructionCategory>(() =>
      _i23.UpdateInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i24.UpdateItem>(
      () => _i24.UpdateItem(repository: get<_i17.ItemRepository>()));
  gh.lazySingleton<_i25.UpdateItemAction>(() =>
      _i25.UpdateItemAction(repository: get<_i11.ItemActionRepository>()));
  gh.lazySingleton<_i26.UpdateItemCategory>(() =>
      _i26.UpdateItemCategory(repository: get<_i13.ItemCategoryRepository>()));
  gh.lazySingleton<_i27.UpdateItemPhoto>(
      () => _i27.UpdateItemPhoto(repository: get<_i15.ItemFilesRepository>()));
  gh.lazySingleton<_i28.UserFilesRepository>(() => _i29.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i30.UserProfileRepository>(() =>
      _i31.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i32.AddInstructionCategory>(() =>
      _i32.AddInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i33.AddItem>(
      () => _i33.AddItem(repository: get<_i17.ItemRepository>()));
  gh.lazySingleton<_i34.AddItemAction>(
      () => _i34.AddItemAction(repository: get<_i11.ItemActionRepository>()));
  gh.lazySingleton<_i35.AddItemCategory>(() =>
      _i35.AddItemCategory(repository: get<_i13.ItemCategoryRepository>()));
  gh.lazySingleton<_i36.AddItemPhoto>(
      () => _i36.AddItemPhoto(repository: get<_i15.ItemFilesRepository>()));
  gh.lazySingleton<_i37.AddUser>(
      () => _i37.AddUser(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i38.AddUserAvatar>(
      () => _i38.AddUserAvatar(repository: get<_i28.UserFilesRepository>()));
  gh.lazySingleton<_i39.ApprovePassiveUser>(() =>
      _i39.ApprovePassiveUser(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i40.ApproveUser>(
      () => _i40.ApproveUser(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i41.ApproveUserAndMakeAdmin>(() =>
      _i41.ApproveUserAndMakeAdmin(
          repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i42.AssignGroupAdmin>(() =>
      _i42.AssignGroupAdmin(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i43.AssignUserToCompany>(() =>
      _i43.AssignUserToCompany(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i44.AssignUserToGroup>(() =>
      _i44.AssignUserToGroup(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i45.AuthenticationRepository>(
      () => _i46.AuthenticationRepositoryImpl(
            firebaseAuth: get<_i4.FirebaseAuth>(),
            networkInfo: get<_i21.NetworkInfo>(),
          ));
  gh.lazySingleton<_i47.AutoSignin>(() => _i47.AutoSignin(
      authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i48.CheckEmailVerification>(() =>
      _i48.CheckEmailVerification(
          authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i49.CheckListsRepository>(() =>
      _i50.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i51.CompanyManagementRepository>(
      () => _i52.CompanyManagementRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i53.CompanyRepository>(() => _i54.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i55.DashboardItemActionRepository>(() =>
      _i56.DashboardItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i57.DeleteChecklist>(
      () => _i57.DeleteChecklist(repository: get<_i49.CheckListsRepository>()));
  gh.lazySingleton<_i58.DeleteInstructionCategory>(() =>
      _i58.DeleteInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i59.DeleteItem>(
      () => _i59.DeleteItem(repository: get<_i17.ItemRepository>()));
  gh.lazySingleton<_i60.DeleteItemAction>(() =>
      _i60.DeleteItemAction(repository: get<_i11.ItemActionRepository>()));
  gh.lazySingleton<_i61.DeleteItemCategory>(() =>
      _i61.DeleteItemCategory(repository: get<_i13.ItemCategoryRepository>()));
  gh.lazySingleton<_i62.DeleteItemPhoto>(
      () => _i62.DeleteItemPhoto(repository: get<_i15.ItemFilesRepository>()));
  gh.lazySingleton<_i63.FetchAllCompanies>(() => _i63.FetchAllCompanies(
      companyManagementRepository: get<_i51.CompanyManagementRepository>()));
  gh.lazySingleton<_i64.FetchAllCompanyUsers>(() => _i64.FetchAllCompanyUsers(
      companyRepository: get<_i53.CompanyRepository>()));
  gh.lazySingleton<_i65.FetchNewUsers>(() =>
      _i65.FetchNewUsers(companyRepository: get<_i53.CompanyRepository>()));
  gh.lazySingleton<_i66.FetchSuspendedUsers>(() => _i66.FetchSuspendedUsers(
      companyRepository: get<_i53.CompanyRepository>()));
  gh.lazySingleton<_i67.GetChecklistStream>(() =>
      _i67.GetChecklistStream(repository: get<_i49.CheckListsRepository>()));
  gh.lazySingleton<_i68.GetCompanyById>(() =>
      _i68.GetCompanyById(companyRepository: get<_i53.CompanyRepository>()));
  gh.lazySingleton<_i69.GetDashboardItemsActionsStream>(() =>
      _i69.GetDashboardItemsActionsStream(
          repository: get<_i55.DashboardItemActionRepository>()));
  gh.lazySingleton<_i70.GetDashboardLastFiveItemsActionsStream>(() =>
      _i70.GetDashboardLastFiveItemsActionsStream(
          repository: get<_i55.DashboardItemActionRepository>()));
  gh.lazySingleton<_i71.GetInstructionsCategoriesStream>(() =>
      _i71.GetInstructionsCategoriesStream(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i72.GetItemsActionsStream>(() =>
      _i72.GetItemsActionsStream(repository: get<_i11.ItemActionRepository>()));
  gh.lazySingleton<_i73.GetItemsCategoriesStream>(() =>
      _i73.GetItemsCategoriesStream(
          repository: get<_i13.ItemCategoryRepository>()));
  gh.lazySingleton<_i74.GetItemsStream>(
      () => _i74.GetItemsStream(repository: get<_i17.ItemRepository>()));
  gh.lazySingleton<_i75.GetLastFiveItemsActionsStream>(() =>
      _i75.GetLastFiveItemsActionsStream(
          repository: get<_i11.ItemActionRepository>()));
  gh.lazySingleton<_i76.GetUserById>(
      () => _i76.GetUserById(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i77.GetUserStreamById>(() => _i77.GetUserStreamById(
      userRepository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i78.GroupLocalDataSource>(() =>
      _i78.GroupLocalDataSourceImpl(source: get<_i22.SharedPreferences>()));
  gh.lazySingleton<_i79.GroupRepository>(() => _i80.GroupRepositoryImpl(
        groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: get<_i78.GroupLocalDataSource>(),
      ));
  gh.factory<_i81.ItemActionBloc>(() => _i81.ItemActionBloc(
        getItemsActionsStream: get<_i72.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            get<_i75.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i82.LocationLocalDataSource>(() =>
      _i82.LocationLocalDataSourceImpl(source: get<_i22.SharedPreferences>()));
  gh.lazySingleton<_i83.LocationRepository>(() => _i84.LocationRepositoryImpl(
        locationLocalDataSource: get<_i82.LocationLocalDataSource>(),
        locationRemoteDataSource: get<_i19.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i85.MakeUserAdministrator>(() => _i85.MakeUserAdministrator(
      repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i86.RejectUser>(
      () => _i86.RejectUser(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i87.ResetCompany>(
      () => _i87.ResetCompany(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i88.SendPasswordResetEmail>(() =>
      _i88.SendPasswordResetEmail(
          authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i89.SendVerificationEmail>(() => _i89.SendVerificationEmail(
      authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i90.Signin>(() => _i90.Signin(
      authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i91.Signout>(() => _i91.Signout(
      authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i92.Signup>(() => _i92.Signup(
      authenticationRepository: get<_i45.AuthenticationRepository>()));
  gh.lazySingleton<_i93.SuspendUser>(
      () => _i93.SuspendUser(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i94.TryToGetCachedGroups>(() =>
      _i94.TryToGetCachedGroups(groupRepository: get<_i79.GroupRepository>()));
  gh.lazySingleton<_i95.TryToGetCachedLocation>(() =>
      _i95.TryToGetCachedLocation(
          locationRepository: get<_i83.LocationRepository>()));
  gh.lazySingleton<_i96.UnassignGroupAdmin>(() =>
      _i96.UnassignGroupAdmin(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i97.UnassignUserFromGroup>(() => _i97.UnassignUserFromGroup(
      repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i98.UnmakeUserAdministrator>(() =>
      _i98.UnmakeUserAdministrator(
          repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i99.UnsuspendUser>(
      () => _i99.UnsuspendUser(repository: get<_i30.UserProfileRepository>()));
  gh.lazySingleton<_i100.UpdateChecklist>(() =>
      _i100.UpdateChecklist(repository: get<_i49.CheckListsRepository>()));
  gh.lazySingleton<_i101.UpdateCompany>(() => _i101.UpdateCompany(
      companyRepository: get<_i51.CompanyManagementRepository>()));
  gh.lazySingleton<_i102.UpdateGroup>(
      () => _i102.UpdateGroup(groupRepository: get<_i79.GroupRepository>()));
  gh.lazySingleton<_i103.UpdateLocation>(() =>
      _i103.UpdateLocation(locationRepository: get<_i83.LocationRepository>()));
  gh.lazySingleton<_i104.UpdateUserData>(() =>
      _i104.UpdateUserData(repository: get<_i30.UserProfileRepository>()));
  gh.factory<_i105.UserManagementBloc>(() => _i105.UserManagementBloc(
        approveUser: get<_i40.ApproveUser>(),
        approvePassiveUser: get<_i39.ApprovePassiveUser>(),
        makeUserAdministrator: get<_i85.MakeUserAdministrator>(),
        unmakeUserAdministrator: get<_i98.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: get<_i41.ApproveUserAndMakeAdmin>(),
        rejectUser: get<_i86.RejectUser>(),
        suspendUser: get<_i93.SuspendUser>(),
        unsuspendUser: get<_i99.UnsuspendUser>(),
        updateUserData: get<_i104.UpdateUserData>(),
        assignUserToGroup: get<_i44.AssignUserToGroup>(),
        unassignUserFromGroup: get<_i97.UnassignUserFromGroup>(),
        assignGroupAdmin: get<_i42.AssignGroupAdmin>(),
        unassignGroupAdmin: get<_i96.UnassignGroupAdmin>(),
        addUserAvatar: get<_i38.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i106.AddChecklist>(
      () => _i106.AddChecklist(repository: get<_i49.CheckListsRepository>()));
  gh.lazySingleton<_i107.AddCompany>(() => _i107.AddCompany(
      companyManagementRepository: get<_i51.CompanyManagementRepository>()));
  gh.lazySingleton<_i108.AddCompanyLogo>(() => _i108.AddCompanyLogo(
      repository: get<_i51.CompanyManagementRepository>()));
  gh.lazySingleton<_i109.AddGroup>(
      () => _i109.AddGroup(groupRepository: get<_i79.GroupRepository>()));
  gh.lazySingleton<_i110.AddLocation>(() =>
      _i110.AddLocation(locationRepository: get<_i83.LocationRepository>()));
  gh.factory<_i111.AuthenticationBloc>(() => _i111.AuthenticationBloc(
        signin: get<_i90.Signin>(),
        signup: get<_i92.Signup>(),
        signout: get<_i91.Signout>(),
        autoSignin: get<_i47.AutoSignin>(),
        sendVerificationEmail: get<_i89.SendVerificationEmail>(),
        checkEmailVerification: get<_i48.CheckEmailVerification>(),
        sendPasswordResetEmail: get<_i88.SendPasswordResetEmail>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i112.CacheGroups>(
      () => _i112.CacheGroups(groupRepository: get<_i79.GroupRepository>()));
  gh.lazySingleton<_i113.CacheLocation>(() =>
      _i113.CacheLocation(locationRepository: get<_i83.LocationRepository>()));
  gh.lazySingleton<_i114.DeleteGroup>(
      () => _i114.DeleteGroup(groupRepository: get<_i79.GroupRepository>()));
  gh.lazySingleton<_i115.DeleteLocation>(() =>
      _i115.DeleteLocation(locationRepository: get<_i83.LocationRepository>()));
  gh.lazySingleton<_i116.FetchAllLocations>(() => _i116.FetchAllLocations(
      locationRepository: get<_i83.LocationRepository>()));
  gh.lazySingleton<_i117.GetGroupsStream>(() =>
      _i117.GetGroupsStream(groupRepository: get<_i79.GroupRepository>()));
  gh.factory<_i118.UserProfileBloc>(() => _i118.UserProfileBloc(
        authenticationBloc: get<_i111.AuthenticationBloc>(),
        addUser: get<_i37.AddUser>(),
        assignUserToCompany: get<_i43.AssignUserToCompany>(),
        resetCompany: get<_i87.ResetCompany>(),
        getUserById: get<_i76.GetUserById>(),
        getUserStreamById: get<_i77.GetUserStreamById>(),
        updateUserData: get<_i104.UpdateUserData>(),
        addUserAvatar: get<_i38.AddUserAvatar>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.factory<_i119.CompanyManagementBloc>(() => _i119.CompanyManagementBloc(
        userProfileBloc: get<_i118.UserProfileBloc>(),
        inputValidator: get<_i8.InputValidator>(),
        addCompany: get<_i107.AddCompany>(),
        fetchAllCompanies: get<_i63.FetchAllCompanies>(),
        addCompanyLogo: get<_i108.AddCompanyLogo>(),
        updateCompany: get<_i101.UpdateCompany>(),
      ));
  gh.factory<_i120.CompanyProfileBloc>(() => _i120.CompanyProfileBloc(
        userProfileBloc: get<_i118.UserProfileBloc>(),
        fetchAllCompanyUsers: get<_i64.FetchAllCompanyUsers>(),
        getCompanyById: get<_i68.GetCompanyById>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i121.GroupBloc>(() => _i121.GroupBloc(
        companyProfileBloc: get<_i120.CompanyProfileBloc>(),
        addGroup: get<_i109.AddGroup>(),
        updateGroup: get<_i102.UpdateGroup>(),
        deleteGroup: get<_i114.DeleteGroup>(),
        getGroupsStream: get<_i117.GetGroupsStream>(),
        cacheGroups: get<_i112.CacheGroups>(),
        tryToGetCachedGroups: get<_i94.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i122.InstructionCategoryBloc>(
      () => _i122.InstructionCategoryBloc(
            userProfileBloc: get<_i118.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                get<_i71.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i123.InstructionCategoryManagementBloc>(
      () => _i123.InstructionCategoryManagementBloc(
            companyProfileBloc: get<_i120.CompanyProfileBloc>(),
            addInstructionCategory: get<_i32.AddInstructionCategory>(),
            updateInstructionCategory: get<_i23.UpdateInstructionCategory>(),
            deleteInstructionCategory: get<_i58.DeleteInstructionCategory>(),
          ));
  gh.factory<_i124.ItemActionManagementBloc>(
      () => _i124.ItemActionManagementBloc(
            companyProfileBloc: get<_i120.CompanyProfileBloc>(),
            addItemAction: get<_i34.AddItemAction>(),
            updateItemAction: get<_i25.UpdateItemAction>(),
            deleteItemAction: get<_i60.DeleteItemAction>(),
            moveItemAction: get<_i20.MoveItemAction>(),
          ));
  gh.lazySingleton<_i125.ItemCategoryBloc>(() => _i125.ItemCategoryBloc(
        userProfileBloc: get<_i118.UserProfileBloc>(),
        getItemsCategoriesStream: get<_i73.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i126.ItemCategoryManagementBloc>(
      () => _i126.ItemCategoryManagementBloc(
            companyProfileBloc: get<_i120.CompanyProfileBloc>(),
            addItemCategory: get<_i35.AddItemCategory>(),
            updateItemCategory: get<_i26.UpdateItemCategory>(),
            deleteItemCategory: get<_i61.DeleteItemCategory>(),
          ));
  gh.factory<_i127.ItemsManagementBloc>(() => _i127.ItemsManagementBloc(
        addItemPhoto: get<_i36.AddItemPhoto>(),
        deleteItemPhoto: get<_i62.DeleteItemPhoto>(),
        updateItemPhoto: get<_i27.UpdateItemPhoto>(),
        companyProfileBloc: get<_i120.CompanyProfileBloc>(),
        addItem: get<_i33.AddItem>(),
        deleteItem: get<_i59.DeleteItem>(),
        updateItem: get<_i24.UpdateItem>(),
      ));
  gh.lazySingleton<_i128.LocationBloc>(() => _i128.LocationBloc(
        companyProfileBloc: get<_i120.CompanyProfileBloc>(),
        addLocation: get<_i110.AddLocation>(),
        cacheLocation: get<_i113.CacheLocation>(),
        deleteLocation: get<_i115.DeleteLocation>(),
        fetchAllLocations: get<_i116.FetchAllLocations>(),
        tryToGetCachedLocation: get<_i95.TryToGetCachedLocation>(),
        updateLocation: get<_i103.UpdateLocation>(),
      ));
  gh.factory<_i129.NewUsersBloc>(() => _i129.NewUsersBloc(
        get<_i120.CompanyProfileBloc>(),
        get<_i65.FetchNewUsers>(),
      ));
  gh.factory<_i130.SuspendedUsersBloc>(() => _i130.SuspendedUsersBloc(
        get<_i120.CompanyProfileBloc>(),
        get<_i66.FetchSuspendedUsers>(),
      ));
  gh.lazySingleton<_i131.ChecklistBloc>(() => _i131.ChecklistBloc(
        companyProfileBloc: get<_i120.CompanyProfileBloc>(),
        getChecklistsStream: get<_i67.GetChecklistStream>(),
      ));
  gh.factory<_i132.ChecklistManagementBloc>(() => _i132.ChecklistManagementBloc(
        companyProfileBloc: get<_i120.CompanyProfileBloc>(),
        addChecklist: get<_i106.AddChecklist>(),
        updateChecklist: get<_i100.UpdateChecklist>(),
        deleteChecklist: get<_i57.DeleteChecklist>(),
      ));
  gh.factory<_i133.FilterBloc>(() => _i133.FilterBloc(
        locationBloc: get<_i128.LocationBloc>(),
        groupBloc: get<_i121.GroupBloc>(),
        userProfileBloc: get<_i118.UserProfileBloc>(),
      ));
  gh.factory<_i134.ItemsBloc>(() => _i134.ItemsBloc(
        filterBloc: get<_i133.FilterBloc>(),
        getChecklistsStream: get<_i74.GetItemsStream>(),
      ));
  gh.factory<_i135.DashboardItemActionBloc>(() => _i135.DashboardItemActionBloc(
        filterBloc: get<_i133.FilterBloc>(),
        getDashboardItemsActionsStream:
            get<_i69.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            get<_i70.GetDashboardLastFiveItemsActionsStream>(),
      ));
  return get;
}

class _$DataConnectionCheckerModule extends _i136.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i136.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i137.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i137.FirebaseStorageService {}

class _$SharedPreferencesService extends _i137.SharedPreferencesService {}
