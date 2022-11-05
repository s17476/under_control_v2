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
    as _i50;
import 'features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i52;
import 'features/assets/data/repositories/asset_repository_impl.dart' as _i54;
import 'features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i71;
import 'features/assets/domain/repositories/asset_action_repository.dart'
    as _i49;
import 'features/assets/domain/repositories/asset_category_repository.dart'
    as _i51;
import 'features/assets/domain/repositories/asset_repository.dart' as _i53;
import 'features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i70;
import 'features/assets/domain/usecases/add_asset.dart' as _i141;
import 'features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i142;
import 'features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i75;
import 'features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i90;
import 'features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i95;
import 'features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i97;
import 'features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i104;
import 'features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i132;
import 'features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i143;
import 'features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i76;
import 'features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i91;
import 'features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i133;
import 'features/assets/domain/usecases/check_code_availability.dart' as _i62;
import 'features/assets/domain/usecases/delete_asset.dart' as _i74;
import 'features/assets/domain/usecases/get_assets_stream.dart' as _i92;
import 'features/assets/domain/usecases/update_asset.dart' as _i131;
import 'features/assets/presentation/blocs/asset/asset_bloc.dart' as _i184;
import 'features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i149;
import 'features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i175;
import 'features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i159;
import 'features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i176;
import 'features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i160;
import 'features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i185;
import 'features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i150;
import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i59;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i58;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i187;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i60;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i63;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i119;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i120;
import 'features/authentication/domain/usecases/signin.dart' as _i121;
import 'features/authentication/domain/usecases/signout.dart' as _i122;
import 'features/authentication/domain/usecases/signup.dart' as _i123;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i151;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i65;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i64;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i144;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i77;
import 'features/checklists/domain/usecases/get_checklists_stream.dart' as _i93;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i134;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i177;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i178;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i67;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i69;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i66;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i68;
import 'features/company_profile/domain/usecases/add_company.dart' as _i145;
import 'features/company_profile/domain/usecases/add_company_logo.dart'
    as _i146;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i85;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i86;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i87;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i88;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i94;
import 'features/company_profile/domain/usecases/update_company.dart' as _i135;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i161;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i162;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i172;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i173;
import 'features/core/injectable_modules/injectable_modules.dart' as _i188;
import 'features/core/network/network_info.dart' as _i23;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i179;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i109;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i111;
import 'features/groups/domain/repositories/group_repository.dart' as _i110;
import 'features/groups/domain/usecases/add_group.dart' as _i147;
import 'features/groups/domain/usecases/cache_groups.dart' as _i152;
import 'features/groups/domain/usecases/delete_group.dart' as _i154;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i157;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i125;
import 'features/groups/domain/usecases/update_group.dart' as _i136;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i163;
import 'features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i73;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i20;
import 'features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i72;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'features/inventory/domain/repositories/item_repository.dart' as _i19;
import 'features/inventory/domain/usecases/add_item.dart' as _i39;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i42;
import 'features/inventory/domain/usecases/delete_item.dart' as _i80;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i83;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i103;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i40;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i81;
import 'features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i96;
import 'features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i98;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i101;
import 'features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i105;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i28;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i41;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i82;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i102;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i29;
import 'features/inventory/domain/usecases/update_item.dart' as _i27;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i30;
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i186;
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i112;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i167;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i168;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i169;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i181;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i170;
import 'features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'features/knowledge_base/domain/usecases/add_instruction.dart' as _i37;
import 'features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i78;
import 'features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i100;
import 'features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i38;
import 'features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i79;
import 'features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i99;
import 'features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i26;
import 'features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i25;
import 'features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i180;
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i164;
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i165;
import 'features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i166;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i113;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i115;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i114;
import 'features/locations/domain/usecases/add_location.dart' as _i148;
import 'features/locations/domain/usecases/cache_location.dart' as _i153;
import 'features/locations/domain/usecases/delete_location.dart' as _i155;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i156;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i126;
import 'features/locations/domain/usecases/update_location.dart' as _i137;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i171;
import 'features/tasks/data/repositories/work_order_repository_impl.dart'
    as _i36;
import 'features/tasks/domain/repositories/work_order_repository.dart' as _i35;
import 'features/tasks/domain/usecases/work_order/add_work_order.dart' as _i45;
import 'features/tasks/domain/usecases/work_order/cancel_work_order.dart'
    as _i61;
import 'features/tasks/domain/usecases/work_order/delete_work_order.dart'
    as _i84;
import 'features/tasks/domain/usecases/work_order/get_archive_work_orders_stream.dart'
    as _i89;
import 'features/tasks/domain/usecases/work_order/get_work_orders_stream.dart'
    as _i108;
import 'features/tasks/domain/usecases/work_order/update_work_order.dart'
    as _i139;
import 'features/tasks/presentation/blocs/work_order/work_order_bloc.dart'
    as _i183;
import 'features/tasks/presentation/blocs/work_order_archive/work_order_archive_bloc.dart'
    as _i182;
import 'features/tasks/presentation/blocs/work_order_management/work_order_management_bloc.dart'
    as _i174;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i32;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i34;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i31;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i33;
import 'features/user_profile/domain/usecases/add_user.dart' as _i43;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i44;
import 'features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i46;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i47;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i48;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i55;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i56;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i57;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i106;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i107;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i116;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i117;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i118;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i124;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i127;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i128;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i129;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i130;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i138;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i140;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i158; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i35.WorkOrdersRepository>(
      () => _i36.WorkOrdersRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i37.AddInstruction>(
      () => _i37.AddInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i38.AddInstructionCategory>(() =>
      _i38.AddInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i39.AddItem>(
      () => _i39.AddItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i40.AddItemAction>(
      () => _i40.AddItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i41.AddItemCategory>(() =>
      _i41.AddItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i42.AddItemPhoto>(
      () => _i42.AddItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i43.AddUser>(
      () => _i43.AddUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i44.AddUserAvatar>(
      () => _i44.AddUserAvatar(repository: get<_i31.UserFilesRepository>()));
  gh.lazySingleton<_i45.AddWorkOrder>(
      () => _i45.AddWorkOrder(repository: get<_i35.WorkOrdersRepository>()));
  gh.lazySingleton<_i46.ApprovePassiveUser>(() =>
      _i46.ApprovePassiveUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i47.ApproveUser>(
      () => _i47.ApproveUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i48.ApproveUserAndMakeAdmin>(() =>
      _i48.ApproveUserAndMakeAdmin(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i49.AssetActionRepository>(() =>
      _i50.AssetActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i51.AssetCategoryRepository>(() =>
      _i52.AssetCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i53.AssetRepository>(() => _i54.AssetRepositoryImpl(
        firebaseFirestore: get<_i5.FirebaseFirestore>(),
        firebaseStorage: get<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i55.AssignGroupAdmin>(() =>
      _i55.AssignGroupAdmin(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i56.AssignUserToCompany>(() =>
      _i56.AssignUserToCompany(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i57.AssignUserToGroup>(() =>
      _i57.AssignUserToGroup(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i58.AuthenticationRepository>(
      () => _i59.AuthenticationRepositoryImpl(
            firebaseAuth: get<_i4.FirebaseAuth>(),
            networkInfo: get<_i23.NetworkInfo>(),
          ));
  gh.lazySingleton<_i60.AutoSignin>(() => _i60.AutoSignin(
      authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i61.CancelWorkOrder>(
      () => _i61.CancelWorkOrder(repository: get<_i35.WorkOrdersRepository>()));
  gh.lazySingleton<_i62.CheckCodeAvailability>(() =>
      _i62.CheckCodeAvailability(repository: get<_i53.AssetRepository>()));
  gh.lazySingleton<_i63.CheckEmailVerification>(() =>
      _i63.CheckEmailVerification(
          authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i64.CheckListsRepository>(() =>
      _i65.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i66.CompanyManagementRepository>(
      () => _i67.CompanyManagementRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i68.CompanyRepository>(() => _i69.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i70.DashboardAssetActionRepository>(() =>
      _i71.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i72.DashboardItemActionRepository>(() =>
      _i73.DashboardItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i74.DeleteAsset>(
      () => _i74.DeleteAsset(repository: get<_i53.AssetRepository>()));
  gh.lazySingleton<_i75.DeleteAssetAction>(() =>
      _i75.DeleteAssetAction(repository: get<_i49.AssetActionRepository>()));
  gh.lazySingleton<_i76.DeleteAssetCategory>(() => _i76.DeleteAssetCategory(
      repository: get<_i51.AssetCategoryRepository>()));
  gh.lazySingleton<_i77.DeleteChecklist>(
      () => _i77.DeleteChecklist(repository: get<_i64.CheckListsRepository>()));
  gh.lazySingleton<_i78.DeleteInstruction>(() =>
      _i78.DeleteInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i79.DeleteInstructionCategory>(() =>
      _i79.DeleteInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i80.DeleteItem>(
      () => _i80.DeleteItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i81.DeleteItemAction>(() =>
      _i81.DeleteItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i82.DeleteItemCategory>(() =>
      _i82.DeleteItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i83.DeleteItemPhoto>(
      () => _i83.DeleteItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i84.DeleteWorkOrder>(
      () => _i84.DeleteWorkOrder(repository: get<_i35.WorkOrdersRepository>()));
  gh.lazySingleton<_i85.FetchAllCompanies>(() => _i85.FetchAllCompanies(
      companyManagementRepository: get<_i66.CompanyManagementRepository>()));
  gh.lazySingleton<_i86.FetchAllCompanyUsers>(() => _i86.FetchAllCompanyUsers(
      companyRepository: get<_i68.CompanyRepository>()));
  gh.lazySingleton<_i87.FetchNewUsers>(() =>
      _i87.FetchNewUsers(companyRepository: get<_i68.CompanyRepository>()));
  gh.lazySingleton<_i88.FetchSuspendedUsers>(() => _i88.FetchSuspendedUsers(
      companyRepository: get<_i68.CompanyRepository>()));
  gh.lazySingleton<_i89.GetArchiveWorkOrdersStream>(() =>
      _i89.GetArchiveWorkOrdersStream(
          repository: get<_i35.WorkOrdersRepository>()));
  gh.lazySingleton<_i90.GetAssetActionsStream>(() => _i90.GetAssetActionsStream(
      repository: get<_i49.AssetActionRepository>()));
  gh.lazySingleton<_i91.GetAssetsCategoriesStream>(() =>
      _i91.GetAssetsCategoriesStream(
          repository: get<_i51.AssetCategoryRepository>()));
  gh.lazySingleton<_i92.GetAssetsStream>(
      () => _i92.GetAssetsStream(repository: get<_i53.AssetRepository>()));
  gh.lazySingleton<_i93.GetChecklistStream>(() =>
      _i93.GetChecklistStream(repository: get<_i64.CheckListsRepository>()));
  gh.lazySingleton<_i94.GetCompanyById>(() =>
      _i94.GetCompanyById(companyRepository: get<_i68.CompanyRepository>()));
  gh.lazySingleton<_i95.GetDashboardAssetActionsStream>(() =>
      _i95.GetDashboardAssetActionsStream(
          repository: get<_i70.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i96.GetDashboardItemsActionsStream>(() =>
      _i96.GetDashboardItemsActionsStream(
          repository: get<_i72.DashboardItemActionRepository>()));
  gh.lazySingleton<_i97.GetDashboardLastFiveAssetActionsStream>(() =>
      _i97.GetDashboardLastFiveAssetActionsStream(
          repository: get<_i70.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i98.GetDashboardLastFiveItemsActionsStream>(() =>
      _i98.GetDashboardLastFiveItemsActionsStream(
          repository: get<_i72.DashboardItemActionRepository>()));
  gh.lazySingleton<_i99.GetInstructionsCategoriesStream>(() =>
      _i99.GetInstructionsCategoriesStream(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i100.GetInstructionsStream>(() =>
      _i100.GetInstructionsStream(
          repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i101.GetItemsActionsStream>(() =>
      _i101.GetItemsActionsStream(
          repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i102.GetItemsCategoriesStream>(() =>
      _i102.GetItemsCategoriesStream(
          repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i103.GetItemsStream>(
      () => _i103.GetItemsStream(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i104.GetLastFiveAssetActionsStream>(() =>
      _i104.GetLastFiveAssetActionsStream(
          repository: get<_i49.AssetActionRepository>()));
  gh.lazySingleton<_i105.GetLastFiveItemsActionsStream>(() =>
      _i105.GetLastFiveItemsActionsStream(
          repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i106.GetUserById>(
      () => _i106.GetUserById(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i107.GetUserStreamById>(() => _i107.GetUserStreamById(
      userRepository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i108.GetWorkOrdersStream>(() =>
      _i108.GetWorkOrdersStream(repository: get<_i35.WorkOrdersRepository>()));
  gh.lazySingleton<_i109.GroupLocalDataSource>(() =>
      _i109.GroupLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i110.GroupRepository>(() => _i111.GroupRepositoryImpl(
        groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: get<_i109.GroupLocalDataSource>(),
      ));
  gh.factory<_i112.ItemActionBloc>(() => _i112.ItemActionBloc(
        getItemsActionsStream: get<_i101.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            get<_i105.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i113.LocationLocalDataSource>(() =>
      _i113.LocationLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i114.LocationRepository>(() => _i115.LocationRepositoryImpl(
        locationLocalDataSource: get<_i113.LocationLocalDataSource>(),
        locationRemoteDataSource: get<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i116.MakeUserAdministrator>(() =>
      _i116.MakeUserAdministrator(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i117.RejectUser>(
      () => _i117.RejectUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i118.ResetCompany>(
      () => _i118.ResetCompany(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i119.SendPasswordResetEmail>(() =>
      _i119.SendPasswordResetEmail(
          authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i120.SendVerificationEmail>(() =>
      _i120.SendVerificationEmail(
          authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i121.Signin>(() => _i121.Signin(
      authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i122.Signout>(() => _i122.Signout(
      authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i123.Signup>(() => _i123.Signup(
      authenticationRepository: get<_i58.AuthenticationRepository>()));
  gh.lazySingleton<_i124.SuspendUser>(
      () => _i124.SuspendUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i125.TryToGetCachedGroups>(() => _i125.TryToGetCachedGroups(
      groupRepository: get<_i110.GroupRepository>()));
  gh.lazySingleton<_i126.TryToGetCachedLocation>(() =>
      _i126.TryToGetCachedLocation(
          locationRepository: get<_i114.LocationRepository>()));
  gh.lazySingleton<_i127.UnassignGroupAdmin>(() =>
      _i127.UnassignGroupAdmin(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i128.UnassignUserFromGroup>(() =>
      _i128.UnassignUserFromGroup(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i129.UnmakeUserAdministrator>(() =>
      _i129.UnmakeUserAdministrator(
          repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i130.UnsuspendUser>(
      () => _i130.UnsuspendUser(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i131.UpdateAsset>(
      () => _i131.UpdateAsset(repository: get<_i53.AssetRepository>()));
  gh.lazySingleton<_i132.UpdateAssetAction>(() =>
      _i132.UpdateAssetAction(repository: get<_i49.AssetActionRepository>()));
  gh.lazySingleton<_i133.UpdateAssetCategory>(() => _i133.UpdateAssetCategory(
      repository: get<_i51.AssetCategoryRepository>()));
  gh.lazySingleton<_i134.UpdateChecklist>(() =>
      _i134.UpdateChecklist(repository: get<_i64.CheckListsRepository>()));
  gh.lazySingleton<_i135.UpdateCompany>(() => _i135.UpdateCompany(
      companyRepository: get<_i66.CompanyManagementRepository>()));
  gh.lazySingleton<_i136.UpdateGroup>(
      () => _i136.UpdateGroup(groupRepository: get<_i110.GroupRepository>()));
  gh.lazySingleton<_i137.UpdateLocation>(() => _i137.UpdateLocation(
      locationRepository: get<_i114.LocationRepository>()));
  gh.lazySingleton<_i138.UpdateUserData>(() =>
      _i138.UpdateUserData(repository: get<_i33.UserProfileRepository>()));
  gh.lazySingleton<_i139.UpdateWorkOrder>(() =>
      _i139.UpdateWorkOrder(repository: get<_i35.WorkOrdersRepository>()));
  gh.factory<_i140.UserManagementBloc>(() => _i140.UserManagementBloc(
        approveUser: get<_i47.ApproveUser>(),
        approvePassiveUser: get<_i46.ApprovePassiveUser>(),
        makeUserAdministrator: get<_i116.MakeUserAdministrator>(),
        unmakeUserAdministrator: get<_i129.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: get<_i48.ApproveUserAndMakeAdmin>(),
        rejectUser: get<_i117.RejectUser>(),
        suspendUser: get<_i124.SuspendUser>(),
        unsuspendUser: get<_i130.UnsuspendUser>(),
        updateUserData: get<_i138.UpdateUserData>(),
        assignUserToGroup: get<_i57.AssignUserToGroup>(),
        unassignUserFromGroup: get<_i128.UnassignUserFromGroup>(),
        assignGroupAdmin: get<_i55.AssignGroupAdmin>(),
        unassignGroupAdmin: get<_i127.UnassignGroupAdmin>(),
        addUserAvatar: get<_i44.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i141.AddAsset>(
      () => _i141.AddAsset(repository: get<_i53.AssetRepository>()));
  gh.lazySingleton<_i142.AddAssetAction>(() =>
      _i142.AddAssetAction(repository: get<_i49.AssetActionRepository>()));
  gh.lazySingleton<_i143.AddAssetCategory>(() =>
      _i143.AddAssetCategory(repository: get<_i51.AssetCategoryRepository>()));
  gh.lazySingleton<_i144.AddChecklist>(
      () => _i144.AddChecklist(repository: get<_i64.CheckListsRepository>()));
  gh.lazySingleton<_i145.AddCompany>(() => _i145.AddCompany(
      companyManagementRepository: get<_i66.CompanyManagementRepository>()));
  gh.lazySingleton<_i146.AddCompanyLogo>(() => _i146.AddCompanyLogo(
      repository: get<_i66.CompanyManagementRepository>()));
  gh.lazySingleton<_i147.AddGroup>(
      () => _i147.AddGroup(groupRepository: get<_i110.GroupRepository>()));
  gh.lazySingleton<_i148.AddLocation>(() =>
      _i148.AddLocation(locationRepository: get<_i114.LocationRepository>()));
  gh.factory<_i149.AssetActionBloc>(() => _i149.AssetActionBloc(
        getAssetActionsStream: get<_i90.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            get<_i104.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i150.AssetInternalNumberCubit>(
      () => _i150.AssetInternalNumberCubit(get<_i62.CheckCodeAvailability>()));
  gh.factory<_i151.AuthenticationBloc>(() => _i151.AuthenticationBloc(
        signin: get<_i121.Signin>(),
        signup: get<_i123.Signup>(),
        signout: get<_i122.Signout>(),
        autoSignin: get<_i60.AutoSignin>(),
        sendVerificationEmail: get<_i120.SendVerificationEmail>(),
        checkEmailVerification: get<_i63.CheckEmailVerification>(),
        sendPasswordResetEmail: get<_i119.SendPasswordResetEmail>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i152.CacheGroups>(
      () => _i152.CacheGroups(groupRepository: get<_i110.GroupRepository>()));
  gh.lazySingleton<_i153.CacheLocation>(() =>
      _i153.CacheLocation(locationRepository: get<_i114.LocationRepository>()));
  gh.lazySingleton<_i154.DeleteGroup>(
      () => _i154.DeleteGroup(groupRepository: get<_i110.GroupRepository>()));
  gh.lazySingleton<_i155.DeleteLocation>(() => _i155.DeleteLocation(
      locationRepository: get<_i114.LocationRepository>()));
  gh.lazySingleton<_i156.FetchAllLocations>(() => _i156.FetchAllLocations(
      locationRepository: get<_i114.LocationRepository>()));
  gh.lazySingleton<_i157.GetGroupsStream>(() =>
      _i157.GetGroupsStream(groupRepository: get<_i110.GroupRepository>()));
  gh.factory<_i158.UserProfileBloc>(() => _i158.UserProfileBloc(
        authenticationBloc: get<_i151.AuthenticationBloc>(),
        addUser: get<_i43.AddUser>(),
        assignUserToCompany: get<_i56.AssignUserToCompany>(),
        resetCompany: get<_i118.ResetCompany>(),
        getUserById: get<_i106.GetUserById>(),
        getUserStreamById: get<_i107.GetUserStreamById>(),
        updateUserData: get<_i138.UpdateUserData>(),
        addUserAvatar: get<_i44.AddUserAvatar>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i159.AssetCategoryBloc>(() => _i159.AssetCategoryBloc(
        userProfileBloc: get<_i158.UserProfileBloc>(),
        getAssetsCategoriesStream: get<_i91.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i160.AssetManagementBloc>(() => _i160.AssetManagementBloc(
        userProfileBloc: get<_i158.UserProfileBloc>(),
        addAsset: get<_i141.AddAsset>(),
        deleteAsset: get<_i74.DeleteAsset>(),
        updateAsset: get<_i131.UpdateAsset>(),
      ));
  gh.factory<_i161.CompanyManagementBloc>(() => _i161.CompanyManagementBloc(
        userProfileBloc: get<_i158.UserProfileBloc>(),
        inputValidator: get<_i8.InputValidator>(),
        addCompany: get<_i145.AddCompany>(),
        fetchAllCompanies: get<_i85.FetchAllCompanies>(),
        addCompanyLogo: get<_i146.AddCompanyLogo>(),
        updateCompany: get<_i135.UpdateCompany>(),
      ));
  gh.factory<_i162.CompanyProfileBloc>(() => _i162.CompanyProfileBloc(
        userProfileBloc: get<_i158.UserProfileBloc>(),
        fetchAllCompanyUsers: get<_i86.FetchAllCompanyUsers>(),
        getCompanyById: get<_i94.GetCompanyById>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i163.GroupBloc>(() => _i163.GroupBloc(
        companyProfileBloc: get<_i162.CompanyProfileBloc>(),
        addGroup: get<_i147.AddGroup>(),
        updateGroup: get<_i136.UpdateGroup>(),
        deleteGroup: get<_i154.DeleteGroup>(),
        getGroupsStream: get<_i157.GetGroupsStream>(),
        cacheGroups: get<_i152.CacheGroups>(),
        tryToGetCachedGroups: get<_i125.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i164.InstructionCategoryBloc>(
      () => _i164.InstructionCategoryBloc(
            userProfileBloc: get<_i158.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                get<_i99.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i165.InstructionCategoryManagementBloc>(
      () => _i165.InstructionCategoryManagementBloc(
            companyProfileBloc: get<_i162.CompanyProfileBloc>(),
            addInstructionCategory: get<_i38.AddInstructionCategory>(),
            updateInstructionCategory: get<_i26.UpdateInstructionCategory>(),
            deleteInstructionCategory: get<_i79.DeleteInstructionCategory>(),
          ));
  gh.factory<_i166.InstructionManagementBloc>(
      () => _i166.InstructionManagementBloc(
            companyProfileBloc: get<_i162.CompanyProfileBloc>(),
            addInstruction: get<_i37.AddInstruction>(),
            deleteInstruction: get<_i78.DeleteInstruction>(),
            updateInstruction: get<_i25.UpdateInstruction>(),
          ));
  gh.factory<_i167.ItemActionManagementBloc>(
      () => _i167.ItemActionManagementBloc(
            companyProfileBloc: get<_i162.CompanyProfileBloc>(),
            addItemAction: get<_i40.AddItemAction>(),
            updateItemAction: get<_i28.UpdateItemAction>(),
            deleteItemAction: get<_i81.DeleteItemAction>(),
            moveItemAction: get<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i168.ItemCategoryBloc>(() => _i168.ItemCategoryBloc(
        userProfileBloc: get<_i158.UserProfileBloc>(),
        getItemsCategoriesStream: get<_i102.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i169.ItemCategoryManagementBloc>(
      () => _i169.ItemCategoryManagementBloc(
            companyProfileBloc: get<_i162.CompanyProfileBloc>(),
            addItemCategory: get<_i41.AddItemCategory>(),
            updateItemCategory: get<_i29.UpdateItemCategory>(),
            deleteItemCategory: get<_i82.DeleteItemCategory>(),
          ));
  gh.factory<_i170.ItemsManagementBloc>(() => _i170.ItemsManagementBloc(
        addItemPhoto: get<_i42.AddItemPhoto>(),
        deleteItemPhoto: get<_i83.DeleteItemPhoto>(),
        updateItemPhoto: get<_i30.UpdateItemPhoto>(),
        companyProfileBloc: get<_i162.CompanyProfileBloc>(),
        addItem: get<_i39.AddItem>(),
        deleteItem: get<_i80.DeleteItem>(),
        updateItem: get<_i27.UpdateItem>(),
      ));
  gh.lazySingleton<_i171.LocationBloc>(() => _i171.LocationBloc(
        companyProfileBloc: get<_i162.CompanyProfileBloc>(),
        addLocation: get<_i148.AddLocation>(),
        cacheLocation: get<_i153.CacheLocation>(),
        deleteLocation: get<_i155.DeleteLocation>(),
        fetchAllLocations: get<_i156.FetchAllLocations>(),
        tryToGetCachedLocation: get<_i126.TryToGetCachedLocation>(),
        updateLocation: get<_i137.UpdateLocation>(),
      ));
  gh.factory<_i172.NewUsersBloc>(() => _i172.NewUsersBloc(
        get<_i162.CompanyProfileBloc>(),
        get<_i87.FetchNewUsers>(),
      ));
  gh.factory<_i173.SuspendedUsersBloc>(() => _i173.SuspendedUsersBloc(
        get<_i162.CompanyProfileBloc>(),
        get<_i88.FetchSuspendedUsers>(),
      ));
  gh.factory<_i174.WorkOrderManagementBloc>(() => _i174.WorkOrderManagementBloc(
        companyProfileBloc: get<_i162.CompanyProfileBloc>(),
        addWorkOrder: get<_i45.AddWorkOrder>(),
        deleteWorkOrder: get<_i84.DeleteWorkOrder>(),
        updateWorkOrder: get<_i139.UpdateWorkOrder>(),
        cancelWorkOrder: get<_i61.CancelWorkOrder>(),
      ));
  gh.factory<_i175.AssetActionManagementBloc>(
      () => _i175.AssetActionManagementBloc(
            companyProfileBloc: get<_i162.CompanyProfileBloc>(),
            addAssetAction: get<_i142.AddAssetAction>(),
            updateAssetAction: get<_i132.UpdateAssetAction>(),
            deleteAssetAction: get<_i75.DeleteAssetAction>(),
          ));
  gh.factory<_i176.AssetCategoryManagementBloc>(
      () => _i176.AssetCategoryManagementBloc(
            companyProfileBloc: get<_i162.CompanyProfileBloc>(),
            addAssetCategory: get<_i143.AddAssetCategory>(),
            updateAssetCategory: get<_i133.UpdateAssetCategory>(),
            deleteAssetCategory: get<_i76.DeleteAssetCategory>(),
          ));
  gh.lazySingleton<_i177.ChecklistBloc>(() => _i177.ChecklistBloc(
        companyProfileBloc: get<_i162.CompanyProfileBloc>(),
        getChecklistsStream: get<_i93.GetChecklistStream>(),
      ));
  gh.factory<_i178.ChecklistManagementBloc>(() => _i178.ChecklistManagementBloc(
        companyProfileBloc: get<_i162.CompanyProfileBloc>(),
        addChecklist: get<_i144.AddChecklist>(),
        updateChecklist: get<_i134.UpdateChecklist>(),
        deleteChecklist: get<_i77.DeleteChecklist>(),
      ));
  gh.factory<_i179.FilterBloc>(() => _i179.FilterBloc(
        locationBloc: get<_i171.LocationBloc>(),
        groupBloc: get<_i163.GroupBloc>(),
        userProfileBloc: get<_i158.UserProfileBloc>(),
      ));
  gh.factory<_i180.InstructionBloc>(() => _i180.InstructionBloc(
        filterBloc: get<_i179.FilterBloc>(),
        getInstructionsStream: get<_i100.GetInstructionsStream>(),
      ));
  gh.factory<_i181.ItemsBloc>(() => _i181.ItemsBloc(
        filterBloc: get<_i179.FilterBloc>(),
        getChecklistsStream: get<_i103.GetItemsStream>(),
      ));
  gh.factory<_i182.WorkOrderArchiveBloc>(() => _i182.WorkOrderArchiveBloc(
        filterBloc: get<_i179.FilterBloc>(),
        getArchiveWorkOrdersStream: get<_i89.GetArchiveWorkOrdersStream>(),
      ));
  gh.factory<_i183.WorkOrderBloc>(() => _i183.WorkOrderBloc(
        filterBloc: get<_i179.FilterBloc>(),
        getWorkOrdersStream: get<_i108.GetWorkOrdersStream>(),
      ));
  gh.factory<_i184.AssetBloc>(() => _i184.AssetBloc(
        filterBloc: get<_i179.FilterBloc>(),
        getAssetsStream: get<_i92.GetAssetsStream>(),
      ));
  gh.factory<_i185.DashboardAssetActionBloc>(
      () => _i185.DashboardAssetActionBloc(
            filterBloc: get<_i179.FilterBloc>(),
            getDashboardAssetActionsStream:
                get<_i95.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                get<_i97.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i186.DashboardItemActionBloc>(() => _i186.DashboardItemActionBloc(
        filterBloc: get<_i179.FilterBloc>(),
        getDashboardItemsActionsStream:
            get<_i96.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            get<_i98.GetDashboardLastFiveItemsActionsStream>(),
      ));
  return get;
}

class _$DataConnectionCheckerModule extends _i187.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i187.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i188.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i188.FirebaseStorageService {}

class _$SharedPreferencesService extends _i188.SharedPreferencesService {}
