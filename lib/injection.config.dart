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
import 'features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i67;
import 'features/assets/domain/repositories/asset_action_repository.dart'
    as _i46;
import 'features/assets/domain/repositories/asset_category_repository.dart'
    as _i48;
import 'features/assets/domain/repositories/asset_repository.dart' as _i50;
import 'features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i66;
import 'features/assets/domain/usecases/add_asset.dart' as _i133;
import 'features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i134;
import 'features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i71;
import 'features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i84;
import 'features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i89;
import 'features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i91;
import 'features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i98;
import 'features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i125;
import 'features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i135;
import 'features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i72;
import 'features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i85;
import 'features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i126;
import 'features/assets/domain/usecases/check_code_availability.dart' as _i58;
import 'features/assets/domain/usecases/delete_asset.dart' as _i70;
import 'features/assets/domain/usecases/get_assets_stream.dart' as _i86;
import 'features/assets/domain/usecases/update_asset.dart' as _i124;
import 'features/assets/presentation/blocs/asset/asset_bloc.dart' as _i173;
import 'features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i141;
import 'features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i166;
import 'features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i151;
import 'features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i167;
import 'features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i152;
import 'features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i174;
import 'features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i142;
import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i56;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i55;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i176;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i57;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i59;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i112;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i113;
import 'features/authentication/domain/usecases/signin.dart' as _i114;
import 'features/authentication/domain/usecases/signout.dart' as _i115;
import 'features/authentication/domain/usecases/signup.dart' as _i116;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i143;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i61;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i60;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i136;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i73;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i87;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i127;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i168;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i169;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i63;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i65;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i62;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i64;
import 'features/company_profile/domain/usecases/add_company.dart' as _i137;
import 'features/company_profile/domain/usecases/add_company_logo.dart'
    as _i138;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i80;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i81;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i82;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i83;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i88;
import 'features/company_profile/domain/usecases/update_company.dart' as _i128;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i153;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i154;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i164;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i165;
import 'features/core/injectable_modules/injectable_modules.dart' as _i177;
import 'features/core/network/network_info.dart' as _i23;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i170;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i102;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i104;
import 'features/groups/domain/repositories/group_repository.dart' as _i103;
import 'features/groups/domain/usecases/add_group.dart' as _i139;
import 'features/groups/domain/usecases/cache_groups.dart' as _i144;
import 'features/groups/domain/usecases/delete_group.dart' as _i146;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i149;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i118;
import 'features/groups/domain/usecases/update_group.dart' as _i129;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i155;
import 'features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i69;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i20;
import 'features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i68;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'features/inventory/domain/repositories/item_repository.dart' as _i19;
import 'features/inventory/domain/usecases/add_item.dart' as _i37;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i40;
import 'features/inventory/domain/usecases/delete_item.dart' as _i76;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i79;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i97;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i38;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i77;
import 'features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i90;
import 'features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i92;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i95;
import 'features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i99;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i28;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i39;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i78;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i96;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i29;
import 'features/inventory/domain/usecases/update_item.dart' as _i27;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i30;
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i175;
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i105;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i159;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i160;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i161;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i172;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i162;
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
    as _i74;
import 'features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i94;
import 'features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i36;
import 'features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i75;
import 'features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i93;
import 'features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i26;
import 'features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i25;
import 'features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i171;
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i156;
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i157;
import 'features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i158;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i106;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i108;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i107;
import 'features/locations/domain/usecases/add_location.dart' as _i140;
import 'features/locations/domain/usecases/cache_location.dart' as _i145;
import 'features/locations/domain/usecases/delete_location.dart' as _i147;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i148;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i119;
import 'features/locations/domain/usecases/update_location.dart' as _i130;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i163;
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
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i100;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i101;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i109;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i110;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i111;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i117;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i120;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i121;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i122;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i123;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i131;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i132;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i150; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i19.ItemRepository>(() => _i20.ItemRepositoryImpl(
        firebaseFirestore: get<_i5.FirebaseFirestore>(),
        firebaseStorage: get<_i6.FirebaseStorage>(),
      ));
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
  gh.lazySingleton<_i66.DashboardAssetActionRepository>(() =>
      _i67.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i68.DashboardItemActionRepository>(() =>
      _i69.DashboardItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i70.DeleteAsset>(
      () => _i70.DeleteAsset(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i71.DeleteAssetAction>(() =>
      _i71.DeleteAssetAction(repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i72.DeleteAssetCategory>(() => _i72.DeleteAssetCategory(
      repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i73.DeleteChecklist>(
      () => _i73.DeleteChecklist(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i74.DeleteInstruction>(() =>
      _i74.DeleteInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i75.DeleteInstructionCategory>(() =>
      _i75.DeleteInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i76.DeleteItem>(
      () => _i76.DeleteItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i77.DeleteItemAction>(() =>
      _i77.DeleteItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i78.DeleteItemCategory>(() =>
      _i78.DeleteItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i79.DeleteItemPhoto>(
      () => _i79.DeleteItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i80.FetchAllCompanies>(() => _i80.FetchAllCompanies(
      companyManagementRepository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i81.FetchAllCompanyUsers>(() => _i81.FetchAllCompanyUsers(
      companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i82.FetchNewUsers>(() =>
      _i82.FetchNewUsers(companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i83.FetchSuspendedUsers>(() => _i83.FetchSuspendedUsers(
      companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i84.GetAssetActionsStream>(() => _i84.GetAssetActionsStream(
      repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i85.GetAssetsCategoriesStream>(() =>
      _i85.GetAssetsCategoriesStream(
          repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i86.GetAssetsStream>(
      () => _i86.GetAssetsStream(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i87.GetChecklistStream>(() =>
      _i87.GetChecklistStream(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i88.GetCompanyById>(() =>
      _i88.GetCompanyById(companyRepository: get<_i64.CompanyRepository>()));
  gh.lazySingleton<_i89.GetDashboardAssetActionsStream>(() =>
      _i89.GetDashboardAssetActionsStream(
          repository: get<_i66.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i90.GetDashboardItemsActionsStream>(() =>
      _i90.GetDashboardItemsActionsStream(
          repository: get<_i68.DashboardItemActionRepository>()));
  gh.lazySingleton<_i91.GetDashboardLastFiveAssetActionsStream>(() =>
      _i91.GetDashboardLastFiveAssetActionsStream(
          repository: get<_i66.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i92.GetDashboardLastFiveItemsActionsStream>(() =>
      _i92.GetDashboardLastFiveItemsActionsStream(
          repository: get<_i68.DashboardItemActionRepository>()));
  gh.lazySingleton<_i93.GetInstructionsCategoriesStream>(() =>
      _i93.GetInstructionsCategoriesStream(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i94.GetInstructionsStream>(() => _i94.GetInstructionsStream(
      repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i95.GetItemsActionsStream>(() =>
      _i95.GetItemsActionsStream(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i96.GetItemsCategoriesStream>(() =>
      _i96.GetItemsCategoriesStream(
          repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i97.GetItemsStream>(
      () => _i97.GetItemsStream(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i98.GetLastFiveAssetActionsStream>(() =>
      _i98.GetLastFiveAssetActionsStream(
          repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i99.GetLastFiveItemsActionsStream>(() =>
      _i99.GetLastFiveItemsActionsStream(
          repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i100.GetUserById>(
      () => _i100.GetUserById(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i101.GetUserStreamById>(() => _i101.GetUserStreamById(
      userRepository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i102.GroupLocalDataSource>(() =>
      _i102.GroupLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i103.GroupRepository>(() => _i104.GroupRepositoryImpl(
        groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: get<_i102.GroupLocalDataSource>(),
      ));
  gh.factory<_i105.ItemActionBloc>(() => _i105.ItemActionBloc(
        getItemsActionsStream: get<_i95.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            get<_i99.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i106.LocationLocalDataSource>(() =>
      _i106.LocationLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i107.LocationRepository>(() => _i108.LocationRepositoryImpl(
        locationLocalDataSource: get<_i106.LocationLocalDataSource>(),
        locationRemoteDataSource: get<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i109.MakeUserAdministrator>(() =>
      _i109.MakeUserAdministrator(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i110.RejectUser>(
      () => _i110.RejectUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i111.ResetCompany>(
      () => _i111.ResetCompany(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i112.SendPasswordResetEmail>(() =>
      _i112.SendPasswordResetEmail(
          authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i113.SendVerificationEmail>(() =>
      _i113.SendVerificationEmail(
          authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i114.Signin>(() => _i114.Signin(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i115.Signout>(() => _i115.Signout(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i116.Signup>(() => _i116.Signup(
      authenticationRepository: get<_i55.AuthenticationRepository>()));
  gh.lazySingleton<_i117.SuspendUser>(
      () => _i117.SuspendUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i118.TryToGetCachedGroups>(() => _i118.TryToGetCachedGroups(
      groupRepository: get<_i103.GroupRepository>()));
  gh.lazySingleton<_i119.TryToGetCachedLocation>(() =>
      _i119.TryToGetCachedLocation(
          locationRepository: get<_i107.LocationRepository>()));
  gh.lazySingleton<_i120.UnassignGroupAdmin>(() =>
      _i120.UnassignGroupAdmin(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i121.UnassignUserFromGroup>(() =>
      _i121.UnassignUserFromGroup(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i122.UnmakeUserAdministrator>(() =>
      _i122.UnmakeUserAdministrator(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i123.UnsuspendUser>(
      () => _i123.UnsuspendUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i124.UpdateAsset>(
      () => _i124.UpdateAsset(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i125.UpdateAssetAction>(() =>
      _i125.UpdateAssetAction(repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i126.UpdateAssetCategory>(() => _i126.UpdateAssetCategory(
      repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i127.UpdateChecklist>(() =>
      _i127.UpdateChecklist(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i128.UpdateCompany>(() => _i128.UpdateCompany(
      companyRepository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i129.UpdateGroup>(
      () => _i129.UpdateGroup(groupRepository: get<_i103.GroupRepository>()));
  gh.lazySingleton<_i130.UpdateLocation>(() => _i130.UpdateLocation(
      locationRepository: get<_i107.LocationRepository>()));
  gh.lazySingleton<_i131.UpdateUserData>(() =>
      _i131.UpdateUserData(repository: get<_i33.UserProfileRepository>()));
  gh.factory<_i132.UserManagementBloc>(() => _i132.UserManagementBloc(
        approveUser: get<_i44.ApproveUser>(),
        approvePassiveUser: get<_i43.ApprovePassiveUser>(),
        makeUserAdministrator: get<_i109.MakeUserAdministrator>(),
        unmakeUserAdministrator: get<_i122.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: get<_i45.ApproveUserAndMakeAdmin>(),
        rejectUser: get<_i110.RejectUser>(),
        suspendUser: get<_i117.SuspendUser>(),
        unsuspendUser: get<_i123.UnsuspendUser>(),
        updateUserData: get<_i131.UpdateUserData>(),
        assignUserToGroup: get<_i54.AssignUserToGroup>(),
        unassignUserFromGroup: get<_i121.UnassignUserFromGroup>(),
        assignGroupAdmin: get<_i52.AssignGroupAdmin>(),
        unassignGroupAdmin: get<_i120.UnassignGroupAdmin>(),
        addUserAvatar: get<_i42.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i133.AddAsset>(
      () => _i133.AddAsset(repository: get<_i50.AssetRepository>()));
  gh.lazySingleton<_i134.AddAssetAction>(() =>
      _i134.AddAssetAction(repository: get<_i46.AssetActionRepository>()));
  gh.lazySingleton<_i135.AddAssetCategory>(() =>
      _i135.AddAssetCategory(repository: get<_i48.AssetCategoryRepository>()));
  gh.lazySingleton<_i136.AddChecklist>(
      () => _i136.AddChecklist(repository: get<_i60.CheckListsRepository>()));
  gh.lazySingleton<_i137.AddCompany>(() => _i137.AddCompany(
      companyManagementRepository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i138.AddCompanyLogo>(() => _i138.AddCompanyLogo(
      repository: get<_i62.CompanyManagementRepository>()));
  gh.lazySingleton<_i139.AddGroup>(
      () => _i139.AddGroup(groupRepository: get<_i103.GroupRepository>()));
  gh.lazySingleton<_i140.AddLocation>(() =>
      _i140.AddLocation(locationRepository: get<_i107.LocationRepository>()));
  gh.factory<_i141.AssetActionBloc>(() => _i141.AssetActionBloc(
        getAssetActionsStream: get<_i84.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            get<_i98.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i142.AssetInternalNumberCubit>(
      () => _i142.AssetInternalNumberCubit(get<_i58.CheckCodeAvailability>()));
  gh.factory<_i143.AuthenticationBloc>(() => _i143.AuthenticationBloc(
        signin: get<_i114.Signin>(),
        signup: get<_i116.Signup>(),
        signout: get<_i115.Signout>(),
        autoSignin: get<_i57.AutoSignin>(),
        sendVerificationEmail: get<_i113.SendVerificationEmail>(),
        checkEmailVerification: get<_i59.CheckEmailVerification>(),
        sendPasswordResetEmail: get<_i112.SendPasswordResetEmail>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i144.CacheGroups>(
      () => _i144.CacheGroups(groupRepository: get<_i103.GroupRepository>()));
  gh.lazySingleton<_i145.CacheLocation>(() =>
      _i145.CacheLocation(locationRepository: get<_i107.LocationRepository>()));
  gh.lazySingleton<_i146.DeleteGroup>(
      () => _i146.DeleteGroup(groupRepository: get<_i103.GroupRepository>()));
  gh.lazySingleton<_i147.DeleteLocation>(() => _i147.DeleteLocation(
      locationRepository: get<_i107.LocationRepository>()));
  gh.lazySingleton<_i148.FetchAllLocations>(() => _i148.FetchAllLocations(
      locationRepository: get<_i107.LocationRepository>()));
  gh.lazySingleton<_i149.GetGroupsStream>(() =>
      _i149.GetGroupsStream(groupRepository: get<_i103.GroupRepository>()));
  gh.factory<_i150.UserProfileBloc>(() => _i150.UserProfileBloc(
        authenticationBloc: get<_i143.AuthenticationBloc>(),
        addUser: get<_i41.AddUser>(),
        assignUserToCompany: get<_i53.AssignUserToCompany>(),
        resetCompany: get<_i111.ResetCompany>(),
        getUserById: get<_i100.GetUserById>(),
        getUserStreamById: get<_i101.GetUserStreamById>(),
        updateUserData: get<_i131.UpdateUserData>(),
        addUserAvatar: get<_i42.AddUserAvatar>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i151.AssetCategoryBloc>(() => _i151.AssetCategoryBloc(
        userProfileBloc: get<_i150.UserProfileBloc>(),
        getAssetsCategoriesStream: get<_i85.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i152.AssetManagementBloc>(() => _i152.AssetManagementBloc(
        userProfileBloc: get<_i150.UserProfileBloc>(),
        addAsset: get<_i133.AddAsset>(),
        deleteAsset: get<_i70.DeleteAsset>(),
        updateAsset: get<_i124.UpdateAsset>(),
      ));
  gh.factory<_i153.CompanyManagementBloc>(() => _i153.CompanyManagementBloc(
        userProfileBloc: get<_i150.UserProfileBloc>(),
        inputValidator: get<_i8.InputValidator>(),
        addCompany: get<_i137.AddCompany>(),
        fetchAllCompanies: get<_i80.FetchAllCompanies>(),
        addCompanyLogo: get<_i138.AddCompanyLogo>(),
        updateCompany: get<_i128.UpdateCompany>(),
      ));
  gh.factory<_i154.CompanyProfileBloc>(() => _i154.CompanyProfileBloc(
        userProfileBloc: get<_i150.UserProfileBloc>(),
        fetchAllCompanyUsers: get<_i81.FetchAllCompanyUsers>(),
        getCompanyById: get<_i88.GetCompanyById>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i155.GroupBloc>(() => _i155.GroupBloc(
        companyProfileBloc: get<_i154.CompanyProfileBloc>(),
        addGroup: get<_i139.AddGroup>(),
        updateGroup: get<_i129.UpdateGroup>(),
        deleteGroup: get<_i146.DeleteGroup>(),
        getGroupsStream: get<_i149.GetGroupsStream>(),
        cacheGroups: get<_i144.CacheGroups>(),
        tryToGetCachedGroups: get<_i118.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i156.InstructionCategoryBloc>(
      () => _i156.InstructionCategoryBloc(
            userProfileBloc: get<_i150.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                get<_i93.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i157.InstructionCategoryManagementBloc>(
      () => _i157.InstructionCategoryManagementBloc(
            companyProfileBloc: get<_i154.CompanyProfileBloc>(),
            addInstructionCategory: get<_i36.AddInstructionCategory>(),
            updateInstructionCategory: get<_i26.UpdateInstructionCategory>(),
            deleteInstructionCategory: get<_i75.DeleteInstructionCategory>(),
          ));
  gh.factory<_i158.InstructionManagementBloc>(
      () => _i158.InstructionManagementBloc(
            companyProfileBloc: get<_i154.CompanyProfileBloc>(),
            addInstruction: get<_i35.AddInstruction>(),
            deleteInstruction: get<_i74.DeleteInstruction>(),
            updateInstruction: get<_i25.UpdateInstruction>(),
          ));
  gh.factory<_i159.ItemActionManagementBloc>(
      () => _i159.ItemActionManagementBloc(
            companyProfileBloc: get<_i154.CompanyProfileBloc>(),
            addItemAction: get<_i38.AddItemAction>(),
            updateItemAction: get<_i28.UpdateItemAction>(),
            deleteItemAction: get<_i77.DeleteItemAction>(),
            moveItemAction: get<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i160.ItemCategoryBloc>(() => _i160.ItemCategoryBloc(
        userProfileBloc: get<_i150.UserProfileBloc>(),
        getItemsCategoriesStream: get<_i96.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i161.ItemCategoryManagementBloc>(
      () => _i161.ItemCategoryManagementBloc(
            companyProfileBloc: get<_i154.CompanyProfileBloc>(),
            addItemCategory: get<_i39.AddItemCategory>(),
            updateItemCategory: get<_i29.UpdateItemCategory>(),
            deleteItemCategory: get<_i78.DeleteItemCategory>(),
          ));
  gh.factory<_i162.ItemsManagementBloc>(() => _i162.ItemsManagementBloc(
        addItemPhoto: get<_i40.AddItemPhoto>(),
        deleteItemPhoto: get<_i79.DeleteItemPhoto>(),
        updateItemPhoto: get<_i30.UpdateItemPhoto>(),
        companyProfileBloc: get<_i154.CompanyProfileBloc>(),
        addItem: get<_i37.AddItem>(),
        deleteItem: get<_i76.DeleteItem>(),
        updateItem: get<_i27.UpdateItem>(),
      ));
  gh.lazySingleton<_i163.LocationBloc>(() => _i163.LocationBloc(
        companyProfileBloc: get<_i154.CompanyProfileBloc>(),
        addLocation: get<_i140.AddLocation>(),
        cacheLocation: get<_i145.CacheLocation>(),
        deleteLocation: get<_i147.DeleteLocation>(),
        fetchAllLocations: get<_i148.FetchAllLocations>(),
        tryToGetCachedLocation: get<_i119.TryToGetCachedLocation>(),
        updateLocation: get<_i130.UpdateLocation>(),
      ));
  gh.factory<_i164.NewUsersBloc>(() => _i164.NewUsersBloc(
        get<_i154.CompanyProfileBloc>(),
        get<_i82.FetchNewUsers>(),
      ));
  gh.factory<_i165.SuspendedUsersBloc>(() => _i165.SuspendedUsersBloc(
        get<_i154.CompanyProfileBloc>(),
        get<_i83.FetchSuspendedUsers>(),
      ));
  gh.factory<_i166.AssetActionManagementBloc>(
      () => _i166.AssetActionManagementBloc(
            companyProfileBloc: get<_i154.CompanyProfileBloc>(),
            addAssetAction: get<_i134.AddAssetAction>(),
            updateAssetAction: get<_i125.UpdateAssetAction>(),
            deleteAssetAction: get<_i71.DeleteAssetAction>(),
          ));
  gh.factory<_i167.AssetCategoryManagementBloc>(
      () => _i167.AssetCategoryManagementBloc(
            companyProfileBloc: get<_i154.CompanyProfileBloc>(),
            addAssetCategory: get<_i135.AddAssetCategory>(),
            updateAssetCategory: get<_i126.UpdateAssetCategory>(),
            deleteAssetCategory: get<_i72.DeleteAssetCategory>(),
          ));
  gh.lazySingleton<_i168.ChecklistBloc>(() => _i168.ChecklistBloc(
        companyProfileBloc: get<_i154.CompanyProfileBloc>(),
        getChecklistsStream: get<_i87.GetChecklistStream>(),
      ));
  gh.factory<_i169.ChecklistManagementBloc>(() => _i169.ChecklistManagementBloc(
        companyProfileBloc: get<_i154.CompanyProfileBloc>(),
        addChecklist: get<_i136.AddChecklist>(),
        updateChecklist: get<_i127.UpdateChecklist>(),
        deleteChecklist: get<_i73.DeleteChecklist>(),
      ));
  gh.factory<_i170.FilterBloc>(() => _i170.FilterBloc(
        locationBloc: get<_i163.LocationBloc>(),
        groupBloc: get<_i155.GroupBloc>(),
        userProfileBloc: get<_i150.UserProfileBloc>(),
      ));
  gh.factory<_i171.InstructionBloc>(() => _i171.InstructionBloc(
        filterBloc: get<_i170.FilterBloc>(),
        getInstructionsStream: get<_i94.GetInstructionsStream>(),
      ));
  gh.factory<_i172.ItemsBloc>(() => _i172.ItemsBloc(
        filterBloc: get<_i170.FilterBloc>(),
        getChecklistsStream: get<_i97.GetItemsStream>(),
      ));
  gh.factory<_i173.AssetBloc>(() => _i173.AssetBloc(
        filterBloc: get<_i170.FilterBloc>(),
        getAssetsStream: get<_i86.GetAssetsStream>(),
      ));
  gh.factory<_i174.DashboardAssetActionBloc>(
      () => _i174.DashboardAssetActionBloc(
            filterBloc: get<_i170.FilterBloc>(),
            getDashboardAssetActionsStream:
                get<_i89.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                get<_i91.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i175.DashboardItemActionBloc>(() => _i175.DashboardItemActionBloc(
        filterBloc: get<_i170.FilterBloc>(),
        getDashboardItemsActionsStream:
            get<_i90.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            get<_i92.GetDashboardLastFiveItemsActionsStream>(),
      ));
  return get;
}

class _$DataConnectionCheckerModule extends _i176.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i176.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i177.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i177.FirebaseStorageService {}

class _$SharedPreferencesService extends _i177.SharedPreferencesService {}
