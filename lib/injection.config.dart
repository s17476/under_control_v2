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
import 'package:shared_preferences/shared_preferences.dart' as _i24;

import 'features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i47;
import 'features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i49;
import 'features/assets/data/repositories/asset_repository_impl.dart' as _i51;
import 'features/assets/domain/repositories/asset_action_repository.dart'
    as _i46;
import 'features/assets/domain/repositories/asset_category_repository.dart'
    as _i48;
import 'features/assets/domain/repositories/asset_repository.dart' as _i50;
import 'features/assets/domain/usecases/add_asset.dart' as _i129;
import 'features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i130;
import 'features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i69;
import 'features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i82;
import 'features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i94;
import 'features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i121;
import 'features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i131;
import 'features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i70;
import 'features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i83;
import 'features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i122;
import 'features/assets/domain/usecases/check_code_availability.dart' as _i58;
import 'features/assets/domain/usecases/delete_asset.dart' as _i68;
import 'features/assets/domain/usecases/get_assets_stream.dart' as _i84;
import 'features/assets/domain/usecases/update_asset.dart' as _i120;
import 'features/assets/presentation/blocs/asset/asset_bloc.dart' as _i169;
import 'features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i137;
import 'features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i161;
import 'features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i147;
import 'features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i162;
import 'features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i163;
import 'features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i138;
import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i56;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i55;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i171;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i57;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i59;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i108;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i109;
import 'features/authentication/domain/usecases/signin.dart' as _i110;
import 'features/authentication/domain/usecases/signout.dart' as _i111;
import 'features/authentication/domain/usecases/signup.dart' as _i112;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i139;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i61;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i60;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i132;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i71;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i85;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i123;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i164;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i165;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i63;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i65;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i62;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i64;
import 'features/company_profile/domain/usecases/add_company.dart' as _i133;
import 'features/company_profile/domain/usecases/add_company_logo.dart'
    as _i134;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i78;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i79;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i80;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i81;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i86;
import 'features/company_profile/domain/usecases/update_company.dart' as _i124;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i148;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i149;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i159;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i160;
import 'features/core/injectable_modules/injectable_modules.dart' as _i172;
import 'features/core/network/network_info.dart' as _i23;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i166;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i98;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i100;
import 'features/groups/domain/repositories/group_repository.dart' as _i99;
import 'features/groups/domain/usecases/add_group.dart' as _i135;
import 'features/groups/domain/usecases/cache_groups.dart' as _i140;
import 'features/groups/domain/usecases/delete_group.dart' as _i142;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i145;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i114;
import 'features/groups/domain/usecases/update_group.dart' as _i125;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i150;
import 'features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i67;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i20;
import 'features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i66;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'features/inventory/domain/repositories/item_repository.dart' as _i19;
import 'features/inventory/domain/usecases/add_item.dart' as _i37;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i40;
import 'features/inventory/domain/usecases/delete_item.dart' as _i74;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i77;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i93;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i38;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i75;
import 'features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i87;
import 'features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i88;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i91;
import 'features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i95;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i28;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i39;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i76;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i92;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i29;
import 'features/inventory/domain/usecases/update_item.dart' as _i27;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i30;
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i170;
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i101;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i154;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i155;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i156;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i168;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i157;
import 'features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'features/knowledge_base/domain/usecases/add_instruction.dart' as _i35;
import 'features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i72;
import 'features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i90;
import 'features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i36;
import 'features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i73;
import 'features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i89;
import 'features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i26;
import 'features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i25;
import 'features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i167;
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i151;
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i152;
import 'features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i153;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i102;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i104;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i103;
import 'features/locations/domain/usecases/add_location.dart' as _i136;
import 'features/locations/domain/usecases/cache_location.dart' as _i141;
import 'features/locations/domain/usecases/delete_location.dart' as _i143;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i144;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i115;
import 'features/locations/domain/usecases/update_location.dart' as _i126;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i158;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i32;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i34;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i31;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i33;
import 'features/user_profile/domain/usecases/add_user.dart' as _i41;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i42;
import 'features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i43;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i44;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i45;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i52;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i53;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i54;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i96;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i97;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i105;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i106;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i107;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i113;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i116;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i117;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i118;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i119;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i127;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i128;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i146; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i11.InstructionRepository>(
      () => _i12.InstructionRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i13.ItemActionRepository>(() =>
      _i14.ItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i15.ItemCategoryRepository>(() =>
      _i16.ItemCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i17.ItemFilesRepository>(() => _i18.ItemFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i19.ItemRepository>(() =>
      _i20.ItemRepositoryImpl(firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i21.LocationRemoteDataSource>(() =>
      _i21.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i22.MoveItemAction>(
      () => _i22.MoveItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i23.NetworkInfo>(() => _i23.NetworkInfoImpl(
      dataConnectionChecker: get<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i24.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i25.UpdateInstruction>(() =>
      _i25.UpdateInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i26.UpdateInstructionCategory>(() =>
      _i26.UpdateInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i27.UpdateItem>(
      () => _i27.UpdateItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i28.UpdateItemAction>(() =>
      _i28.UpdateItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i29.UpdateItemCategory>(() =>
      _i29.UpdateItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i30.UpdateItemPhoto>(
      () => _i30.UpdateItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i31.UserFilesRepository>(() => _i32.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i33.UserProfileRepository>(() =>
      _i34.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i35.AddInstruction>(
      () => _i35.AddInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i36.AddInstructionCategory>(() =>
      _i36.AddInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i37.AddItem>(
      () => _i37.AddItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i38.AddItemAction>(
      () => _i38.AddItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i39.AddItemCategory>(() =>
      _i39.AddItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i40.AddItemPhoto>(
      () => _i40.AddItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i41.AddUser>(
      () => _i41.AddUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i42.AddUserAvatar>(
      () => _i42.AddUserAvatar(repository: get<_i31.UserFilesRepository>()));
  gh.lazySingleton<_i43.ApprovePassiveUser>(() =>
      _i43.ApprovePassiveUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i44.ApproveUser>(
      () => _i44.ApproveUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i45.ApproveUserAndMakeAdmin>(() =>
      _i45.ApproveUserAndMakeAdmin(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i46.AssetActionRepository>(() =>
      _i47.AssetActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i48.AssetCategoryRepository>(() =>
      _i49.AssetCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i50.AssetRepository>(() => _i51.AssetRepositoryImpl(
        firebaseFirestore: get<_i5.FirebaseFirestore>(),
        firebaseStorage: get<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i52.AssignGroupAdmin>(() =>
      _i52.AssignGroupAdmin(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i53.AssignUserToCompany>(() =>
      _i53.AssignUserToCompany(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i54.AssignUserToGroup>(() =>
      _i54.AssignUserToGroup(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i55.AuthenticationRepository>(
      () => _i56.AuthenticationRepositoryImpl(
            firebaseAuth: get<_i4.FirebaseAuth>(),
            networkInfo: get<_i23.NetworkInfo>(),
          ));
  gh.lazySingleton<_i57.AutoSignin>(() => _i57.AutoSignin(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i58.CheckCodeAvailability>(() =>
      _i58.CheckCodeAvailability(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i59.CheckEmailVerification>(() =>
      _i59.CheckEmailVerification(
          authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i60.CheckListsRepository>(() =>
      _i61.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i62.CompanyManagementRepository>(
      () => _i63.CompanyManagementRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i64.CompanyRepository>(() => _i65.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i66.DashboardItemActionRepository>(() =>
      _i67.DashboardItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i68.DeleteAsset>(
      () => _i68.DeleteAsset(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i69.DeleteAssetAction>(() =>
      _i69.DeleteAssetAction(repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i70.DeleteAssetCategory>(() => _i70.DeleteAssetCategory(
      repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i71.DeleteChecklist>(
      () => _i71.DeleteChecklist(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i72.DeleteInstruction>(() =>
      _i72.DeleteInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i73.DeleteInstructionCategory>(() =>
      _i73.DeleteInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i74.DeleteItem>(
      () => _i74.DeleteItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i75.DeleteItemAction>(() =>
      _i75.DeleteItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i76.DeleteItemCategory>(() =>
      _i76.DeleteItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i77.DeleteItemPhoto>(
      () => _i77.DeleteItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i78.FetchAllCompanies>(() => _i78.FetchAllCompanies(
      companyManagementRepository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i79.FetchAllCompanyUsers>(() => _i79.FetchAllCompanyUsers(
      companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i80.FetchNewUsers>(() =>
      _i80.FetchNewUsers(companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i81.FetchSuspendedUsers>(() => _i81.FetchSuspendedUsers(
      companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i82.GetAssetActionsStream>(() => _i82.GetAssetActionsStream(
      repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i83.GetAssetsCategoriesStream>(() =>
      _i83.GetAssetsCategoriesStream(
          repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i84.GetAssetsStream>(
      () => _i84.GetAssetsStream(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i85.GetChecklistStream>(() =>
      _i85.GetChecklistStream(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i86.GetCompanyById>(() =>
      _i86.GetCompanyById(companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i87.GetDashboardItemsActionsStream>(() =>
      _i87.GetDashboardItemsActionsStream(
          repository: get<_i66.DashboardItemActionRepository>()));
  gh.lazySingleton<_i88.GetDashboardLastFiveItemsActionsStream>(() =>
      _i88.GetDashboardLastFiveItemsActionsStream(
          repository: get<_i66.DashboardItemActionRepository>()));
  gh.lazySingleton<_i89.GetInstructionsCategoriesStream>(() =>
      _i89.GetInstructionsCategoriesStream(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i90.GetInstructionsStream>(() => _i90.GetInstructionsStream(
      repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i91.GetItemsActionsStream>(() =>
      _i91.GetItemsActionsStream(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i92.GetItemsCategoriesStream>(() =>
      _i92.GetItemsCategoriesStream(
          repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i93.GetItemsStream>(
      () => _i93.GetItemsStream(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i94.GetLastFiveAssetActionsStream>(() =>
      _i94.GetLastFiveAssetActionsStream(
          repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i95.GetLastFiveItemsActionsStream>(() =>
      _i95.GetLastFiveItemsActionsStream(
          repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i96.GetUserById>(
      () => _i96.GetUserById(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i97.GetUserStreamById>(() => _i97.GetUserStreamById(
      userRepository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i98.GroupLocalDataSource>(() =>
      _i98.GroupLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i99.GroupRepository>(() => _i100.GroupRepositoryImpl(
        groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: get<_i98.GroupLocalDataSource>(),
      ));
  gh.factory<_i101.ItemActionBloc>(() => _i101.ItemActionBloc(
        getItemsActionsStream: get<_i91.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            get<_i95.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i102.LocationLocalDataSource>(() =>
      _i102.LocationLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i103.LocationRepository>(() => _i104.LocationRepositoryImpl(
        locationLocalDataSource: get<_i102.LocationLocalDataSource>(),
        locationRemoteDataSource: get<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i105.MakeUserAdministrator>(() =>
      _i105.MakeUserAdministrator(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i106.RejectUser>(
      () => _i106.RejectUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i107.ResetCompany>(
      () => _i107.ResetCompany(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i108.SendPasswordResetEmail>(() =>
      _i108.SendPasswordResetEmail(
          authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i109.SendVerificationEmail>(() =>
      _i109.SendVerificationEmail(
          authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i110.Signin>(() => _i110.Signin(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i111.Signout>(() => _i111.Signout(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i112.Signup>(() => _i112.Signup(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i113.SuspendUser>(
      () => _i113.SuspendUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i114.TryToGetCachedGroups>(() =>
      _i114.TryToGetCachedGroups(groupRepository: get<_i99.GroupRepository>()));
  gh.lazySingleton<_i115.TryToGetCachedLocation>(() =>
      _i115.TryToGetCachedLocation(
          locationRepository: get<_i103.LocationRepository>()));
  gh.lazySingleton<_i116.UnassignGroupAdmin>(() =>
      _i116.UnassignGroupAdmin(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i117.UnassignUserFromGroup>(() =>
      _i117.UnassignUserFromGroup(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i118.UnmakeUserAdministrator>(() =>
      _i118.UnmakeUserAdministrator(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i119.UnsuspendUser>(
      () => _i119.UnsuspendUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i120.UpdateAsset>(
      () => _i120.UpdateAsset(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i121.UpdateAssetAction>(() =>
      _i121.UpdateAssetAction(repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i122.UpdateAssetCategory>(() => _i122.UpdateAssetCategory(
      repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i123.UpdateChecklist>(() =>
      _i123.UpdateChecklist(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i124.UpdateCompany>(() => _i124.UpdateCompany(
      companyRepository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i125.UpdateGroup>(
      () => _i125.UpdateGroup(groupRepository: get<_i99.GroupRepository>()));
  gh.lazySingleton<_i126.UpdateLocation>(() => _i126.UpdateLocation(
      locationRepository: get<_i103.LocationRepository>()));
  gh.lazySingleton<_i127.UpdateUserData>(() =>
      _i127.UpdateUserData(repository: get<_i33.UserProfileRepository>()));
  gh.factory<_i128.UserManagementBloc>(() => _i128.UserManagementBloc(
        approveUser: get<_i44.ApproveUser>(),
        approvePassiveUser: get<_i43.ApprovePassiveUser>(),
        makeUserAdministrator: get<_i105.MakeUserAdministrator>(),
        unmakeUserAdministrator: get<_i118.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: get<_i45.ApproveUserAndMakeAdmin>(),
        rejectUser: get<_i106.RejectUser>(),
        suspendUser: get<_i113.SuspendUser>(),
        unsuspendUser: get<_i119.UnsuspendUser>(),
        updateUserData: get<_i127.UpdateUserData>(),
        assignUserToGroup: get<_i54.AssignUserToGroup>(),
        unassignUserFromGroup: get<_i117.UnassignUserFromGroup>(),
        assignGroupAdmin: get<_i52.AssignGroupAdmin>(),
        unassignGroupAdmin: get<_i116.UnassignGroupAdmin>(),
        addUserAvatar: get<_i42.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i129.AddAsset>(
      () => _i129.AddAsset(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i130.AddAssetAction>(() =>
      _i130.AddAssetAction(repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i131.AddAssetCategory>(() =>
      _i131.AddAssetCategory(repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i132.AddChecklist>(
      () => _i132.AddChecklist(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i133.AddCompany>(() => _i133.AddCompany(
      companyManagementRepository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i134.AddCompanyLogo>(() => _i134.AddCompanyLogo(
      repository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i135.AddGroup>(
      () => _i135.AddGroup(groupRepository: get<_i99.GroupRepository>()));
  gh.lazySingleton<_i136.AddLocation>(() =>
      _i136.AddLocation(locationRepository: get<_i103.LocationRepository>()));
  gh.factory<_i137.AssetActionBloc>(() => _i137.AssetActionBloc(
        getAssetActionsStream: get<_i82.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            get<_i94.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i138.AssetInternalNumberCubit>(
      () => _i138.AssetInternalNumberCubit(get<_i58.CheckCodeAvailability>()));
  gh.factory<_i139.AuthenticationBloc>(() => _i139.AuthenticationBloc(
        signin: get<_i110.Signin>(),
        signup: get<_i112.Signup>(),
        signout: get<_i111.Signout>(),
        autoSignin: get<_i57.AutoSignin>(),
        sendVerificationEmail: get<_i109.SendVerificationEmail>(),
        checkEmailVerification: get<_i59.CheckEmailVerification>(),
        sendPasswordResetEmail: get<_i108.SendPasswordResetEmail>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i140.CacheGroups>(
      () => _i140.CacheGroups(groupRepository: get<_i99.GroupRepository>()));
  gh.lazySingleton<_i141.CacheLocation>(() =>
      _i141.CacheLocation(locationRepository: get<_i103.LocationRepository>()));
  gh.lazySingleton<_i142.DeleteGroup>(
      () => _i142.DeleteGroup(groupRepository: get<_i99.GroupRepository>()));
  gh.lazySingleton<_i143.DeleteLocation>(() => _i143.DeleteLocation(
      locationRepository: get<_i103.LocationRepository>()));
  gh.lazySingleton<_i144.FetchAllLocations>(() => _i144.FetchAllLocations(
      locationRepository: get<_i103.LocationRepository>()));
  gh.lazySingleton<_i145.GetGroupsStream>(() =>
      _i145.GetGroupsStream(groupRepository: get<_i99.GroupRepository>()));
  gh.factory<_i146.UserProfileBloc>(() => _i146.UserProfileBloc(
        authenticationBloc: get<_i139.AuthenticationBloc>(),
        addUser: get<_i41.AddUser>(),
        assignUserToCompany: get<_i53.AssignUserToCompany>(),
        resetCompany: get<_i107.ResetCompany>(),
        getUserById: get<_i96.GetUserById>(),
        getUserStreamById: get<_i97.GetUserStreamById>(),
        updateUserData: get<_i127.UpdateUserData>(),
        addUserAvatar: get<_i42.AddUserAvatar>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i147.AssetCategoryBloc>(() => _i147.AssetCategoryBloc(
        userProfileBloc: get<_i146.UserProfileBloc>(),
        getAssetsCategoriesStream: get<_i83.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i148.CompanyManagementBloc>(() => _i148.CompanyManagementBloc(
        userProfileBloc: get<_i146.UserProfileBloc>(),
        inputValidator: get<_i8.InputValidator>(),
        addCompany: get<_i133.AddCompany>(),
        fetchAllCompanies: get<_i78.FetchAllCompanies>(),
        addCompanyLogo: get<_i134.AddCompanyLogo>(),
        updateCompany: get<_i124.UpdateCompany>(),
      ));
  gh.factory<_i149.CompanyProfileBloc>(() => _i149.CompanyProfileBloc(
        userProfileBloc: get<_i146.UserProfileBloc>(),
        fetchAllCompanyUsers: get<_i79.FetchAllCompanyUsers>(),
        getCompanyById: get<_i86.GetCompanyById>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i150.GroupBloc>(() => _i150.GroupBloc(
        companyProfileBloc: get<_i149.CompanyProfileBloc>(),
        addGroup: get<_i135.AddGroup>(),
        updateGroup: get<_i125.UpdateGroup>(),
        deleteGroup: get<_i142.DeleteGroup>(),
        getGroupsStream: get<_i145.GetGroupsStream>(),
        cacheGroups: get<_i140.CacheGroups>(),
        tryToGetCachedGroups: get<_i114.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i151.InstructionCategoryBloc>(
      () => _i151.InstructionCategoryBloc(
            userProfileBloc: get<_i146.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                get<_i89.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i152.InstructionCategoryManagementBloc>(
      () => _i152.InstructionCategoryManagementBloc(
            companyProfileBloc: get<_i149.CompanyProfileBloc>(),
            addInstructionCategory: get<_i36.AddInstructionCategory>(),
            updateInstructionCategory: get<_i26.UpdateInstructionCategory>(),
            deleteInstructionCategory: get<_i73.DeleteInstructionCategory>(),
          ));
  gh.factory<_i153.InstructionManagementBloc>(
      () => _i153.InstructionManagementBloc(
            companyProfileBloc: get<_i149.CompanyProfileBloc>(),
            addInstruction: get<_i35.AddInstruction>(),
            deleteInstruction: get<_i72.DeleteInstruction>(),
            updateInstruction: get<_i25.UpdateInstruction>(),
          ));
  gh.factory<_i154.ItemActionManagementBloc>(
      () => _i154.ItemActionManagementBloc(
            companyProfileBloc: get<_i149.CompanyProfileBloc>(),
            addItemAction: get<_i38.AddItemAction>(),
            updateItemAction: get<_i28.UpdateItemAction>(),
            deleteItemAction: get<_i75.DeleteItemAction>(),
            moveItemAction: get<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i155.ItemCategoryBloc>(() => _i155.ItemCategoryBloc(
        userProfileBloc: get<_i146.UserProfileBloc>(),
        getItemsCategoriesStream: get<_i92.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i156.ItemCategoryManagementBloc>(
      () => _i156.ItemCategoryManagementBloc(
            companyProfileBloc: get<_i149.CompanyProfileBloc>(),
            addItemCategory: get<_i39.AddItemCategory>(),
            updateItemCategory: get<_i29.UpdateItemCategory>(),
            deleteItemCategory: get<_i76.DeleteItemCategory>(),
          ));
  gh.factory<_i157.ItemsManagementBloc>(() => _i157.ItemsManagementBloc(
        addItemPhoto: get<_i40.AddItemPhoto>(),
        deleteItemPhoto: get<_i77.DeleteItemPhoto>(),
        updateItemPhoto: get<_i30.UpdateItemPhoto>(),
        companyProfileBloc: get<_i149.CompanyProfileBloc>(),
        addItem: get<_i37.AddItem>(),
        deleteItem: get<_i74.DeleteItem>(),
        updateItem: get<_i27.UpdateItem>(),
      ));
  gh.lazySingleton<_i158.LocationBloc>(() => _i158.LocationBloc(
        companyProfileBloc: get<_i149.CompanyProfileBloc>(),
        addLocation: get<_i136.AddLocation>(),
        cacheLocation: get<_i141.CacheLocation>(),
        deleteLocation: get<_i143.DeleteLocation>(),
        fetchAllLocations: get<_i144.FetchAllLocations>(),
        tryToGetCachedLocation: get<_i115.TryToGetCachedLocation>(),
        updateLocation: get<_i126.UpdateLocation>(),
      ));
  gh.factory<_i159.NewUsersBloc>(() => _i159.NewUsersBloc(
        get<_i149.CompanyProfileBloc>(),
        get<_i80.FetchNewUsers>(),
      ));
  gh.factory<_i160.SuspendedUsersBloc>(() => _i160.SuspendedUsersBloc(
        get<_i149.CompanyProfileBloc>(),
        get<_i81.FetchSuspendedUsers>(),
      ));
  gh.factory<_i161.AssetActionManagementBloc>(
      () => _i161.AssetActionManagementBloc(
            companyProfileBloc: get<_i149.CompanyProfileBloc>(),
            addAssetAction: get<_i130.AddAssetAction>(),
            updateAssetAction: get<_i121.UpdateAssetAction>(),
            deleteAssetAction: get<_i69.DeleteAssetAction>(),
          ));
  gh.factory<_i162.AssetCategoryManagementBloc>(
      () => _i162.AssetCategoryManagementBloc(
            companyProfileBloc: get<_i149.CompanyProfileBloc>(),
            addAssetCategory: get<_i131.AddAssetCategory>(),
            updateAssetCategory: get<_i122.UpdateAssetCategory>(),
            deleteAssetCategory: get<_i70.DeleteAssetCategory>(),
          ));
  gh.factory<_i163.AssetManagementBloc>(() => _i163.AssetManagementBloc(
        companyProfileBloc: get<_i149.CompanyProfileBloc>(),
        addAsset: get<_i129.AddAsset>(),
        deleteAsset: get<_i68.DeleteAsset>(),
        updateAsset: get<_i120.UpdateAsset>(),
      ));
  gh.lazySingleton<_i164.ChecklistBloc>(() => _i164.ChecklistBloc(
        companyProfileBloc: get<_i149.CompanyProfileBloc>(),
        getChecklistsStream: get<_i85.GetChecklistStream>(),
      ));
  gh.factory<_i165.ChecklistManagementBloc>(() => _i165.ChecklistManagementBloc(
        companyProfileBloc: get<_i149.CompanyProfileBloc>(),
        addChecklist: get<_i132.AddChecklist>(),
        updateChecklist: get<_i123.UpdateChecklist>(),
        deleteChecklist: get<_i71.DeleteChecklist>(),
      ));
  gh.factory<_i166.FilterBloc>(() => _i166.FilterBloc(
        locationBloc: get<_i158.LocationBloc>(),
        groupBloc: get<_i150.GroupBloc>(),
        userProfileBloc: get<_i146.UserProfileBloc>(),
      ));
  gh.factory<_i167.InstructionBloc>(() => _i167.InstructionBloc(
        filterBloc: get<_i166.FilterBloc>(),
        getInstructionsStream: get<_i90.GetInstructionsStream>(),
      ));
  gh.factory<_i168.ItemsBloc>(() => _i168.ItemsBloc(
        filterBloc: get<_i166.FilterBloc>(),
        getChecklistsStream: get<_i93.GetItemsStream>(),
      ));
  gh.factory<_i169.AssetBloc>(() => _i169.AssetBloc(
        filterBloc: get<_i166.FilterBloc>(),
        getAssetsStream: get<_i84.GetAssetsStream>(),
      ));
  gh.factory<_i170.DashboardItemActionBloc>(() => _i170.DashboardItemActionBloc(
        filterBloc: get<_i166.FilterBloc>(),
        getDashboardItemsActionsStream:
            get<_i87.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            get<_i88.GetDashboardLastFiveItemsActionsStream>(),
      ));
  return get;
}

class _$DataConnectionCheckerModule extends _i171.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i171.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i172.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i172.FirebaseStorageService {}

class _$SharedPreferencesService extends _i172.SharedPreferencesService {}
