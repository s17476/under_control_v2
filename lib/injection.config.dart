// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i9;
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart'
    as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i8;
import 'package:firebase_storage/firebase_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i30;

import 'features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i57;
import 'features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i59;
import 'features/assets/data/repositories/asset_repository_impl.dart' as _i61;
import 'features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i78;
import 'features/assets/domain/repositories/asset_action_repository.dart'
    as _i56;
import 'features/assets/domain/repositories/asset_category_repository.dart'
    as _i58;
import 'features/assets/domain/repositories/asset_repository.dart' as _i60;
import 'features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i77;
import 'features/assets/domain/usecases/add_asset.dart' as _i148;
import 'features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i149;
import 'features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i82;
import 'features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i97;
import 'features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i102;
import 'features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i104;
import 'features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i111;
import 'features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i139;
import 'features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i150;
import 'features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i83;
import 'features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i98;
import 'features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i140;
import 'features/assets/domain/usecases/check_code_availability.dart' as _i69;
import 'features/assets/domain/usecases/delete_asset.dart' as _i81;
import 'features/assets/domain/usecases/get_assets_stream.dart' as _i99;
import 'features/assets/domain/usecases/update_asset.dart' as _i138;
import 'features/assets/presentation/blocs/asset/asset_bloc.dart' as _i191;
import 'features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i156;
import 'features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i182;
import 'features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i166;
import 'features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i183;
import 'features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i167;
import 'features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i192;
import 'features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i157;
import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i66;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i65;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i194;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i67;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i70;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i126;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i127;
import 'features/authentication/domain/usecases/signin.dart' as _i128;
import 'features/authentication/domain/usecases/signout.dart' as _i129;
import 'features/authentication/domain/usecases/signup.dart' as _i130;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i158;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i72;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i71;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i151;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i84;
import 'features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i100;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i141;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i184;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i185;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i74;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i76;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i73;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i75;
import 'features/company_profile/domain/usecases/add_company.dart' as _i152;
import 'features/company_profile/domain/usecases/add_company_logo.dart'
    as _i153;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i92;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i93;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i94;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i95;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i101;
import 'features/company_profile/domain/usecases/update_company.dart' as _i142;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i168;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i169;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i179;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i180;
import 'features/core/injectable_modules/injectable_modules.dart' as _i195;
import 'features/core/network/network_info.dart' as _i29;
import 'features/core/utils/input_validator.dart' as _i14;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i186;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i116;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i13;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i118;
import 'features/groups/domain/repositories/group_repository.dart' as _i117;
import 'features/groups/domain/usecases/add_group.dart' as _i154;
import 'features/groups/domain/usecases/cache_groups.dart' as _i159;
import 'features/groups/domain/usecases/delete_group.dart' as _i161;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i164;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i132;
import 'features/groups/domain/usecases/update_group.dart' as _i143;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i170;
import 'features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i80;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i20;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i22;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i24;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i26;
import 'features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i79;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i19;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i21;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i23;
import 'features/inventory/domain/repositories/item_repository.dart' as _i25;
import 'features/inventory/domain/usecases/add_item.dart' as _i46;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i49;
import 'features/inventory/domain/usecases/delete_item.dart' as _i87;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i90;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i110;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i47;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i88;
import 'features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i103;
import 'features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i105;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i108;
import 'features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i112;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i28;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i34;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i48;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i89;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i109;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i35;
import 'features/inventory/domain/usecases/update_item.dart' as _i33;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i36;
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i193;
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i119;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i174;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i175;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i176;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i188;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i177;
import 'features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i16;
import 'features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i18;
import 'features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i15;
import 'features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i17;
import 'features/knowledge_base/domain/usecases/add_instruction.dart' as _i44;
import 'features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i85;
import 'features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i107;
import 'features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i45;
import 'features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i86;
import 'features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i106;
import 'features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i32;
import 'features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i31;
import 'features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i187;
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i171;
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i172;
import 'features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i173;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i120;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i27;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i122;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i121;
import 'features/locations/domain/usecases/add_location.dart' as _i155;
import 'features/locations/domain/usecases/cache_location.dart' as _i160;
import 'features/locations/domain/usecases/delete_location.dart' as _i162;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i163;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i133;
import 'features/locations/domain/usecases/update_location.dart' as _i144;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i178;
import 'features/tasks/data/repositories/work_order_repository_impl.dart'
    as _i43;
import 'features/tasks/domain/repositories/task_repository.dart' as _i4;
import 'features/tasks/domain/repositories/work_order_repository.dart' as _i42;
import 'features/tasks/domain/usecases/task/add_task.dart' as _i3;
import 'features/tasks/domain/usecases/task/cancel_task.dart' as _i5;
import 'features/tasks/domain/usecases/task/delete_task.dart' as _i7;
import 'features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i11;
import 'features/tasks/domain/usecases/task/get_tasks_stream.dart' as _i12;
import 'features/tasks/domain/usecases/task/update_task.dart' as _i37;
import 'features/tasks/domain/usecases/work_order/add_work_order.dart' as _i52;
import 'features/tasks/domain/usecases/work_order/cancel_work_order.dart'
    as _i68;
import 'features/tasks/domain/usecases/work_order/delete_work_order.dart'
    as _i91;
import 'features/tasks/domain/usecases/work_order/get_archive_work_orders_stream.dart'
    as _i96;
import 'features/tasks/domain/usecases/work_order/get_work_orders_stream.dart'
    as _i115;
import 'features/tasks/domain/usecases/work_order/update_work_order.dart'
    as _i146;
import 'features/tasks/presentation/blocs/work_order/work_order_bloc.dart'
    as _i190;
import 'features/tasks/presentation/blocs/work_order_archive/work_order_archive_bloc.dart'
    as _i189;
import 'features/tasks/presentation/blocs/work_order_management/work_order_management_bloc.dart'
    as _i181;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i39;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i41;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i38;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i40;
import 'features/user_profile/domain/usecases/add_user.dart' as _i50;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i51;
import 'features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i53;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i54;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i55;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i62;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i63;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i64;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i113;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i114;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i123;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i124;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i125;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i131;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i134;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i135;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i136;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i137;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i145;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i147;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i165; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i3.AddTask>(
      () => _i3.AddTask(repository: get<_i4.TaskRepository>()));
  gh.lazySingleton<_i5.CancelTask>(
      () => _i5.CancelTask(repository: get<_i4.TaskRepository>()));
  gh.lazySingleton<_i6.DataConnectionChecker>(
      () => dataConnectionCheckerModule.httpClient);
  gh.lazySingleton<_i7.DeleteTask>(
      () => _i7.DeleteTask(repository: get<_i4.TaskRepository>()));
  gh.lazySingleton<_i8.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i9.FirebaseFirestore>(
      () => firebaseFirestoreService.firebaseFirestore);
  gh.lazySingleton<_i10.FirebaseStorage>(
      () => firebaseStorageService.firebaseStorage);
  gh.lazySingleton<_i11.GetArchiveTasksStream>(
      () => _i11.GetArchiveTasksStream(repository: get<_i4.TaskRepository>()));
  gh.lazySingleton<_i12.GetTasksStream>(
      () => _i12.GetTasksStream(repository: get<_i4.TaskRepository>()));
  gh.lazySingleton<_i13.GroupRemoteDataSource>(() =>
      _i13.GroupRemoteDataSourceImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i14.InputValidator>(() => _i14.InputValidator());
  gh.lazySingleton<_i15.InstructionCategoryRepository>(() =>
      _i16.InstructionCategoryRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i17.InstructionRepository>(
      () => _i18.InstructionRepositoryImpl(
            firebaseFirestore: get<_i9.FirebaseFirestore>(),
            firebaseStorage: get<_i10.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i19.ItemActionRepository>(() =>
      _i20.ItemActionRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i21.ItemCategoryRepository>(() =>
      _i22.ItemCategoryRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i23.ItemFilesRepository>(() => _i24.ItemFilesRepositoryImpl(
      firebaseStorage: get<_i10.FirebaseStorage>()));
  gh.lazySingleton<_i25.ItemRepository>(() => _i26.ItemRepositoryImpl(
        firebaseFirestore: get<_i9.FirebaseFirestore>(),
        firebaseStorage: get<_i10.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i27.LocationRemoteDataSource>(() =>
      _i27.LocationRemoteDataSourceImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i28.MoveItemAction>(
      () => _i28.MoveItemAction(repository: get<_i19.ItemActionRepository>()));
  gh.lazySingleton<_i29.NetworkInfo>(() => _i29.NetworkInfoImpl(
      dataConnectionChecker: get<_i6.DataConnectionChecker>()));
  await gh.factoryAsync<_i30.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i31.UpdateInstruction>(() =>
      _i31.UpdateInstruction(repository: get<_i17.InstructionRepository>()));
  gh.lazySingleton<_i32.UpdateInstructionCategory>(() =>
      _i32.UpdateInstructionCategory(
          repository: get<_i15.InstructionCategoryRepository>()));
  gh.lazySingleton<_i33.UpdateItem>(
      () => _i33.UpdateItem(repository: get<_i25.ItemRepository>()));
  gh.lazySingleton<_i34.UpdateItemAction>(() =>
      _i34.UpdateItemAction(repository: get<_i19.ItemActionRepository>()));
  gh.lazySingleton<_i35.UpdateItemCategory>(() =>
      _i35.UpdateItemCategory(repository: get<_i21.ItemCategoryRepository>()));
  gh.lazySingleton<_i36.UpdateItemPhoto>(
      () => _i36.UpdateItemPhoto(repository: get<_i23.ItemFilesRepository>()));
  gh.lazySingleton<_i37.UpdateTask>(
      () => _i37.UpdateTask(repository: get<_i4.TaskRepository>()));
  gh.lazySingleton<_i38.UserFilesRepository>(() => _i39.UserFilesRepositoryImpl(
      firebaseStorage: get<_i10.FirebaseStorage>()));
  gh.lazySingleton<_i40.UserProfileRepository>(() =>
      _i41.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i42.WorkOrdersRepository>(
      () => _i43.WorkOrdersRepositoryImpl(
            firebaseFirestore: get<_i9.FirebaseFirestore>(),
            firebaseStorage: get<_i10.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i44.AddInstruction>(
      () => _i44.AddInstruction(repository: get<_i17.InstructionRepository>()));
  gh.lazySingleton<_i45.AddInstructionCategory>(() =>
      _i45.AddInstructionCategory(
          repository: get<_i15.InstructionCategoryRepository>()));
  gh.lazySingleton<_i46.AddItem>(
      () => _i46.AddItem(repository: get<_i25.ItemRepository>()));
  gh.lazySingleton<_i47.AddItemAction>(
      () => _i47.AddItemAction(repository: get<_i19.ItemActionRepository>()));
  gh.lazySingleton<_i48.AddItemCategory>(() =>
      _i48.AddItemCategory(repository: get<_i21.ItemCategoryRepository>()));
  gh.lazySingleton<_i49.AddItemPhoto>(
      () => _i49.AddItemPhoto(repository: get<_i23.ItemFilesRepository>()));
  gh.lazySingleton<_i50.AddUser>(
      () => _i50.AddUser(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i51.AddUserAvatar>(
      () => _i51.AddUserAvatar(repository: get<_i38.UserFilesRepository>()));
  gh.lazySingleton<_i52.AddWorkOrder>(
      () => _i52.AddWorkOrder(repository: get<_i42.WorkOrdersRepository>()));
  gh.lazySingleton<_i53.ApprovePassiveUser>(() =>
      _i53.ApprovePassiveUser(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i54.ApproveUser>(
      () => _i54.ApproveUser(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i55.ApproveUserAndMakeAdmin>(() =>
      _i55.ApproveUserAndMakeAdmin(
          repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i56.AssetActionRepository>(() =>
      _i57.AssetActionRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i58.AssetCategoryRepository>(() =>
      _i59.AssetCategoryRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i60.AssetRepository>(() => _i61.AssetRepositoryImpl(
        firebaseFirestore: get<_i9.FirebaseFirestore>(),
        firebaseStorage: get<_i10.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i62.AssignGroupAdmin>(() =>
      _i62.AssignGroupAdmin(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i63.AssignUserToCompany>(() =>
      _i63.AssignUserToCompany(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i64.AssignUserToGroup>(() =>
      _i64.AssignUserToGroup(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i65.AuthenticationRepository>(
      () => _i66.AuthenticationRepositoryImpl(
            firebaseAuth: get<_i8.FirebaseAuth>(),
            networkInfo: get<_i29.NetworkInfo>(),
          ));
  gh.lazySingleton<_i67.AutoSignin>(() => _i67.AutoSignin(
      authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i68.CancelWorkOrder>(
      () => _i68.CancelWorkOrder(repository: get<_i42.WorkOrdersRepository>()));
  gh.lazySingleton<_i69.CheckCodeAvailability>(() =>
      _i69.CheckCodeAvailability(repository: get<_i60.AssetRepository>()));
  gh.lazySingleton<_i70.CheckEmailVerification>(() =>
      _i70.CheckEmailVerification(
          authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i71.CheckListsRepository>(() =>
      _i72.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i73.CompanyManagementRepository>(
      () => _i74.CompanyManagementRepositoryImpl(
            firebaseFirestore: get<_i9.FirebaseFirestore>(),
            firebaseStorage: get<_i10.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i75.CompanyRepository>(() => _i76.CompanyRepositoryImpl(
      firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i77.DashboardAssetActionRepository>(() =>
      _i78.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i79.DashboardItemActionRepository>(() =>
      _i80.DashboardItemActionRepositoryImpl(
          firebaseFirestore: get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i81.DeleteAsset>(
      () => _i81.DeleteAsset(repository: get<_i60.AssetRepository>()));
  gh.lazySingleton<_i82.DeleteAssetAction>(() =>
      _i82.DeleteAssetAction(repository: get<_i56.AssetActionRepository>()));
  gh.lazySingleton<_i83.DeleteAssetCategory>(() => _i83.DeleteAssetCategory(
      repository: get<_i58.AssetCategoryRepository>()));
  gh.lazySingleton<_i84.DeleteChecklist>(
      () => _i84.DeleteChecklist(repository: get<_i71.CheckListsRepository>()));
  gh.lazySingleton<_i85.DeleteInstruction>(() =>
      _i85.DeleteInstruction(repository: get<_i17.InstructionRepository>()));
  gh.lazySingleton<_i86.DeleteInstructionCategory>(() =>
      _i86.DeleteInstructionCategory(
          repository: get<_i15.InstructionCategoryRepository>()));
  gh.lazySingleton<_i87.DeleteItem>(
      () => _i87.DeleteItem(repository: get<_i25.ItemRepository>()));
  gh.lazySingleton<_i88.DeleteItemAction>(() =>
      _i88.DeleteItemAction(repository: get<_i19.ItemActionRepository>()));
  gh.lazySingleton<_i89.DeleteItemCategory>(() =>
      _i89.DeleteItemCategory(repository: get<_i21.ItemCategoryRepository>()));
  gh.lazySingleton<_i90.DeleteItemPhoto>(
      () => _i90.DeleteItemPhoto(repository: get<_i23.ItemFilesRepository>()));
  gh.lazySingleton<_i91.DeleteWorkOrder>(
      () => _i91.DeleteWorkOrder(repository: get<_i42.WorkOrdersRepository>()));
  gh.lazySingleton<_i92.FetchAllCompanies>(() => _i92.FetchAllCompanies(
      companyManagementRepository: get<_i73.CompanyManagementRepository>()));
  gh.lazySingleton<_i93.FetchAllCompanyUsers>(() => _i93.FetchAllCompanyUsers(
      companyRepository: get<_i75.CompanyRepository>()));
  gh.lazySingleton<_i94.FetchNewUsers>(() =>
      _i94.FetchNewUsers(companyRepository: get<_i75.CompanyRepository>()));
  gh.lazySingleton<_i95.FetchSuspendedUsers>(() => _i95.FetchSuspendedUsers(
      companyRepository: get<_i75.CompanyRepository>()));
  gh.lazySingleton<_i96.GetArchiveWorkOrdersStream>(() =>
      _i96.GetArchiveWorkOrdersStream(
          repository: get<_i42.WorkOrdersRepository>()));
  gh.lazySingleton<_i97.GetAssetActionsStream>(() => _i97.GetAssetActionsStream(
      repository: get<_i56.AssetActionRepository>()));
  gh.lazySingleton<_i98.GetAssetsCategoriesStream>(() =>
      _i98.GetAssetsCategoriesStream(
          repository: get<_i58.AssetCategoryRepository>()));
  gh.lazySingleton<_i99.GetAssetsStream>(
      () => _i99.GetAssetsStream(repository: get<_i60.AssetRepository>()));
  gh.lazySingleton<_i100.GetChecklistStream>(() =>
      _i100.GetChecklistStream(repository: get<_i71.CheckListsRepository>()));
  gh.lazySingleton<_i101.GetCompanyById>(() =>
      _i101.GetCompanyById(companyRepository: get<_i75.CompanyRepository>()));
  gh.lazySingleton<_i102.GetDashboardAssetActionsStream>(() =>
      _i102.GetDashboardAssetActionsStream(
          repository: get<_i77.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i103.GetDashboardItemsActionsStream>(() =>
      _i103.GetDashboardItemsActionsStream(
          repository: get<_i79.DashboardItemActionRepository>()));
  gh.lazySingleton<_i104.GetDashboardLastFiveAssetActionsStream>(() =>
      _i104.GetDashboardLastFiveAssetActionsStream(
          repository: get<_i77.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i105.GetDashboardLastFiveItemsActionsStream>(() =>
      _i105.GetDashboardLastFiveItemsActionsStream(
          repository: get<_i79.DashboardItemActionRepository>()));
  gh.lazySingleton<_i106.GetInstructionsCategoriesStream>(() =>
      _i106.GetInstructionsCategoriesStream(
          repository: get<_i15.InstructionCategoryRepository>()));
  gh.lazySingleton<_i107.GetInstructionsStream>(() =>
      _i107.GetInstructionsStream(
          repository: get<_i17.InstructionRepository>()));
  gh.lazySingleton<_i108.GetItemsActionsStream>(() =>
      _i108.GetItemsActionsStream(
          repository: get<_i19.ItemActionRepository>()));
  gh.lazySingleton<_i109.GetItemsCategoriesStream>(() =>
      _i109.GetItemsCategoriesStream(
          repository: get<_i21.ItemCategoryRepository>()));
  gh.lazySingleton<_i110.GetItemsStream>(
      () => _i110.GetItemsStream(repository: get<_i25.ItemRepository>()));
  gh.lazySingleton<_i111.GetLastFiveAssetActionsStream>(() =>
      _i111.GetLastFiveAssetActionsStream(
          repository: get<_i56.AssetActionRepository>()));
  gh.lazySingleton<_i112.GetLastFiveItemsActionsStream>(() =>
      _i112.GetLastFiveItemsActionsStream(
          repository: get<_i19.ItemActionRepository>()));
  gh.lazySingleton<_i113.GetUserById>(
      () => _i113.GetUserById(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i114.GetUserStreamById>(() => _i114.GetUserStreamById(
      userRepository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i115.GetWorkOrdersStream>(() =>
      _i115.GetWorkOrdersStream(repository: get<_i42.WorkOrdersRepository>()));
  gh.lazySingleton<_i116.GroupLocalDataSource>(() =>
      _i116.GroupLocalDataSourceImpl(source: get<_i30.SharedPreferences>()));
  gh.lazySingleton<_i117.GroupRepository>(() => _i118.GroupRepositoryImpl(
        groupRemoteDataSource: get<_i13.GroupRemoteDataSource>(),
        groupLocalDataSource: get<_i116.GroupLocalDataSource>(),
      ));
  gh.factory<_i119.ItemActionBloc>(() => _i119.ItemActionBloc(
        getItemsActionsStream: get<_i108.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            get<_i112.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i120.LocationLocalDataSource>(() =>
      _i120.LocationLocalDataSourceImpl(source: get<_i30.SharedPreferences>()));
  gh.lazySingleton<_i121.LocationRepository>(() => _i122.LocationRepositoryImpl(
        locationLocalDataSource: get<_i120.LocationLocalDataSource>(),
        locationRemoteDataSource: get<_i27.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i123.MakeUserAdministrator>(() =>
      _i123.MakeUserAdministrator(
          repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i124.RejectUser>(
      () => _i124.RejectUser(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i125.ResetCompany>(
      () => _i125.ResetCompany(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i126.SendPasswordResetEmail>(() =>
      _i126.SendPasswordResetEmail(
          authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i127.SendVerificationEmail>(() =>
      _i127.SendVerificationEmail(
          authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i128.Signin>(() => _i128.Signin(
      authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i129.Signout>(() => _i129.Signout(
      authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i130.Signup>(() => _i130.Signup(
      authenticationRepository: get<_i65.AuthenticationRepository>()));
  gh.lazySingleton<_i131.SuspendUser>(
      () => _i131.SuspendUser(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i132.TryToGetCachedGroups>(() => _i132.TryToGetCachedGroups(
      groupRepository: get<_i117.GroupRepository>()));
  gh.lazySingleton<_i133.TryToGetCachedLocation>(() =>
      _i133.TryToGetCachedLocation(
          locationRepository: get<_i121.LocationRepository>()));
  gh.lazySingleton<_i134.UnassignGroupAdmin>(() =>
      _i134.UnassignGroupAdmin(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i135.UnassignUserFromGroup>(() =>
      _i135.UnassignUserFromGroup(
          repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i136.UnmakeUserAdministrator>(() =>
      _i136.UnmakeUserAdministrator(
          repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i137.UnsuspendUser>(
      () => _i137.UnsuspendUser(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i138.UpdateAsset>(
      () => _i138.UpdateAsset(repository: get<_i60.AssetRepository>()));
  gh.lazySingleton<_i139.UpdateAssetAction>(() =>
      _i139.UpdateAssetAction(repository: get<_i56.AssetActionRepository>()));
  gh.lazySingleton<_i140.UpdateAssetCategory>(() => _i140.UpdateAssetCategory(
      repository: get<_i58.AssetCategoryRepository>()));
  gh.lazySingleton<_i141.UpdateChecklist>(() =>
      _i141.UpdateChecklist(repository: get<_i71.CheckListsRepository>()));
  gh.lazySingleton<_i142.UpdateCompany>(() => _i142.UpdateCompany(
      companyRepository: get<_i73.CompanyManagementRepository>()));
  gh.lazySingleton<_i143.UpdateGroup>(
      () => _i143.UpdateGroup(groupRepository: get<_i117.GroupRepository>()));
  gh.lazySingleton<_i144.UpdateLocation>(() => _i144.UpdateLocation(
      locationRepository: get<_i121.LocationRepository>()));
  gh.lazySingleton<_i145.UpdateUserData>(() =>
      _i145.UpdateUserData(repository: get<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i146.UpdateWorkOrder>(() =>
      _i146.UpdateWorkOrder(repository: get<_i42.WorkOrdersRepository>()));
  gh.factory<_i147.UserManagementBloc>(() => _i147.UserManagementBloc(
        approveUser: get<_i54.ApproveUser>(),
        approvePassiveUser: get<_i53.ApprovePassiveUser>(),
        makeUserAdministrator: get<_i123.MakeUserAdministrator>(),
        unmakeUserAdministrator: get<_i136.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: get<_i55.ApproveUserAndMakeAdmin>(),
        rejectUser: get<_i124.RejectUser>(),
        suspendUser: get<_i131.SuspendUser>(),
        unsuspendUser: get<_i137.UnsuspendUser>(),
        updateUserData: get<_i145.UpdateUserData>(),
        assignUserToGroup: get<_i64.AssignUserToGroup>(),
        unassignUserFromGroup: get<_i135.UnassignUserFromGroup>(),
        assignGroupAdmin: get<_i62.AssignGroupAdmin>(),
        unassignGroupAdmin: get<_i134.UnassignGroupAdmin>(),
        addUserAvatar: get<_i51.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i148.AddAsset>(
      () => _i148.AddAsset(repository: get<_i60.AssetRepository>()));
  gh.lazySingleton<_i149.AddAssetAction>(() =>
      _i149.AddAssetAction(repository: get<_i56.AssetActionRepository>()));
  gh.lazySingleton<_i150.AddAssetCategory>(() =>
      _i150.AddAssetCategory(repository: get<_i58.AssetCategoryRepository>()));
  gh.lazySingleton<_i151.AddChecklist>(
      () => _i151.AddChecklist(repository: get<_i71.CheckListsRepository>()));
  gh.lazySingleton<_i152.AddCompany>(() => _i152.AddCompany(
      companyManagementRepository: get<_i73.CompanyManagementRepository>()));
  gh.lazySingleton<_i153.AddCompanyLogo>(() => _i153.AddCompanyLogo(
      repository: get<_i73.CompanyManagementRepository>()));
  gh.lazySingleton<_i154.AddGroup>(
      () => _i154.AddGroup(groupRepository: get<_i117.GroupRepository>()));
  gh.lazySingleton<_i155.AddLocation>(() =>
      _i155.AddLocation(locationRepository: get<_i121.LocationRepository>()));
  gh.factory<_i156.AssetActionBloc>(() => _i156.AssetActionBloc(
        getAssetActionsStream: get<_i97.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            get<_i111.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i157.AssetInternalNumberCubit>(
      () => _i157.AssetInternalNumberCubit(get<_i69.CheckCodeAvailability>()));
  gh.factory<_i158.AuthenticationBloc>(() => _i158.AuthenticationBloc(
        signin: get<_i128.Signin>(),
        signup: get<_i130.Signup>(),
        signout: get<_i129.Signout>(),
        autoSignin: get<_i67.AutoSignin>(),
        sendVerificationEmail: get<_i127.SendVerificationEmail>(),
        checkEmailVerification: get<_i70.CheckEmailVerification>(),
        sendPasswordResetEmail: get<_i126.SendPasswordResetEmail>(),
        inputValidator: get<_i14.InputValidator>(),
      ));
  gh.lazySingleton<_i159.CacheGroups>(
      () => _i159.CacheGroups(groupRepository: get<_i117.GroupRepository>()));
  gh.lazySingleton<_i160.CacheLocation>(() =>
      _i160.CacheLocation(locationRepository: get<_i121.LocationRepository>()));
  gh.lazySingleton<_i161.DeleteGroup>(
      () => _i161.DeleteGroup(groupRepository: get<_i117.GroupRepository>()));
  gh.lazySingleton<_i162.DeleteLocation>(() => _i162.DeleteLocation(
      locationRepository: get<_i121.LocationRepository>()));
  gh.lazySingleton<_i163.FetchAllLocations>(() => _i163.FetchAllLocations(
      locationRepository: get<_i121.LocationRepository>()));
  gh.lazySingleton<_i164.GetGroupsStream>(() =>
      _i164.GetGroupsStream(groupRepository: get<_i117.GroupRepository>()));
  gh.factory<_i165.UserProfileBloc>(() => _i165.UserProfileBloc(
        authenticationBloc: get<_i158.AuthenticationBloc>(),
        addUser: get<_i50.AddUser>(),
        assignUserToCompany: get<_i63.AssignUserToCompany>(),
        resetCompany: get<_i125.ResetCompany>(),
        getUserById: get<_i113.GetUserById>(),
        getUserStreamById: get<_i114.GetUserStreamById>(),
        updateUserData: get<_i145.UpdateUserData>(),
        addUserAvatar: get<_i51.AddUserAvatar>(),
        inputValidator: get<_i14.InputValidator>(),
      ));
  gh.lazySingleton<_i166.AssetCategoryBloc>(() => _i166.AssetCategoryBloc(
        userProfileBloc: get<_i165.UserProfileBloc>(),
        getAssetsCategoriesStream: get<_i98.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i167.AssetManagementBloc>(() => _i167.AssetManagementBloc(
        userProfileBloc: get<_i165.UserProfileBloc>(),
        addAsset: get<_i148.AddAsset>(),
        deleteAsset: get<_i81.DeleteAsset>(),
        updateAsset: get<_i138.UpdateAsset>(),
      ));
  gh.factory<_i168.CompanyManagementBloc>(() => _i168.CompanyManagementBloc(
        userProfileBloc: get<_i165.UserProfileBloc>(),
        inputValidator: get<_i14.InputValidator>(),
        addCompany: get<_i152.AddCompany>(),
        fetchAllCompanies: get<_i92.FetchAllCompanies>(),
        addCompanyLogo: get<_i153.AddCompanyLogo>(),
        updateCompany: get<_i142.UpdateCompany>(),
      ));
  gh.factory<_i169.CompanyProfileBloc>(() => _i169.CompanyProfileBloc(
        userProfileBloc: get<_i165.UserProfileBloc>(),
        fetchAllCompanyUsers: get<_i93.FetchAllCompanyUsers>(),
        getCompanyById: get<_i101.GetCompanyById>(),
        inputValidator: get<_i14.InputValidator>(),
      ));
  gh.lazySingleton<_i170.GroupBloc>(() => _i170.GroupBloc(
        companyProfileBloc: get<_i169.CompanyProfileBloc>(),
        addGroup: get<_i154.AddGroup>(),
        updateGroup: get<_i143.UpdateGroup>(),
        deleteGroup: get<_i161.DeleteGroup>(),
        getGroupsStream: get<_i164.GetGroupsStream>(),
        cacheGroups: get<_i159.CacheGroups>(),
        tryToGetCachedGroups: get<_i132.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i171.InstructionCategoryBloc>(
      () => _i171.InstructionCategoryBloc(
            userProfileBloc: get<_i165.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                get<_i106.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i172.InstructionCategoryManagementBloc>(
      () => _i172.InstructionCategoryManagementBloc(
            companyProfileBloc: get<_i169.CompanyProfileBloc>(),
            addInstructionCategory: get<_i45.AddInstructionCategory>(),
            updateInstructionCategory: get<_i32.UpdateInstructionCategory>(),
            deleteInstructionCategory: get<_i86.DeleteInstructionCategory>(),
          ));
  gh.factory<_i173.InstructionManagementBloc>(
      () => _i173.InstructionManagementBloc(
            companyProfileBloc: get<_i169.CompanyProfileBloc>(),
            addInstruction: get<_i44.AddInstruction>(),
            deleteInstruction: get<_i85.DeleteInstruction>(),
            updateInstruction: get<_i31.UpdateInstruction>(),
          ));
  gh.factory<_i174.ItemActionManagementBloc>(
      () => _i174.ItemActionManagementBloc(
            companyProfileBloc: get<_i169.CompanyProfileBloc>(),
            addItemAction: get<_i47.AddItemAction>(),
            updateItemAction: get<_i34.UpdateItemAction>(),
            deleteItemAction: get<_i88.DeleteItemAction>(),
            moveItemAction: get<_i28.MoveItemAction>(),
          ));
  gh.lazySingleton<_i175.ItemCategoryBloc>(() => _i175.ItemCategoryBloc(
        userProfileBloc: get<_i165.UserProfileBloc>(),
        getItemsCategoriesStream: get<_i109.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i176.ItemCategoryManagementBloc>(
      () => _i176.ItemCategoryManagementBloc(
            companyProfileBloc: get<_i169.CompanyProfileBloc>(),
            addItemCategory: get<_i48.AddItemCategory>(),
            updateItemCategory: get<_i35.UpdateItemCategory>(),
            deleteItemCategory: get<_i89.DeleteItemCategory>(),
          ));
  gh.factory<_i177.ItemsManagementBloc>(() => _i177.ItemsManagementBloc(
        addItemPhoto: get<_i49.AddItemPhoto>(),
        deleteItemPhoto: get<_i90.DeleteItemPhoto>(),
        updateItemPhoto: get<_i36.UpdateItemPhoto>(),
        companyProfileBloc: get<_i169.CompanyProfileBloc>(),
        addItem: get<_i46.AddItem>(),
        deleteItem: get<_i87.DeleteItem>(),
        updateItem: get<_i33.UpdateItem>(),
      ));
  gh.lazySingleton<_i178.LocationBloc>(() => _i178.LocationBloc(
        companyProfileBloc: get<_i169.CompanyProfileBloc>(),
        addLocation: get<_i155.AddLocation>(),
        cacheLocation: get<_i160.CacheLocation>(),
        deleteLocation: get<_i162.DeleteLocation>(),
        fetchAllLocations: get<_i163.FetchAllLocations>(),
        tryToGetCachedLocation: get<_i133.TryToGetCachedLocation>(),
        updateLocation: get<_i144.UpdateLocation>(),
      ));
  gh.factory<_i179.NewUsersBloc>(() => _i179.NewUsersBloc(
        get<_i169.CompanyProfileBloc>(),
        get<_i94.FetchNewUsers>(),
      ));
  gh.factory<_i180.SuspendedUsersBloc>(() => _i180.SuspendedUsersBloc(
        get<_i169.CompanyProfileBloc>(),
        get<_i95.FetchSuspendedUsers>(),
      ));
  gh.factory<_i181.WorkOrderManagementBloc>(() => _i181.WorkOrderManagementBloc(
        companyProfileBloc: get<_i169.CompanyProfileBloc>(),
        addWorkOrder: get<_i52.AddWorkOrder>(),
        deleteWorkOrder: get<_i91.DeleteWorkOrder>(),
        updateWorkOrder: get<_i146.UpdateWorkOrder>(),
        cancelWorkOrder: get<_i68.CancelWorkOrder>(),
      ));
  gh.factory<_i182.AssetActionManagementBloc>(
      () => _i182.AssetActionManagementBloc(
            companyProfileBloc: get<_i169.CompanyProfileBloc>(),
            addAssetAction: get<_i149.AddAssetAction>(),
            updateAssetAction: get<_i139.UpdateAssetAction>(),
            deleteAssetAction: get<_i82.DeleteAssetAction>(),
          ));
  gh.factory<_i183.AssetCategoryManagementBloc>(
      () => _i183.AssetCategoryManagementBloc(
            companyProfileBloc: get<_i169.CompanyProfileBloc>(),
            addAssetCategory: get<_i150.AddAssetCategory>(),
            updateAssetCategory: get<_i140.UpdateAssetCategory>(),
            deleteAssetCategory: get<_i83.DeleteAssetCategory>(),
          ));
  gh.lazySingleton<_i184.ChecklistBloc>(() => _i184.ChecklistBloc(
        companyProfileBloc: get<_i169.CompanyProfileBloc>(),
        getChecklistsStream: get<_i100.GetChecklistStream>(),
      ));
  gh.factory<_i185.ChecklistManagementBloc>(() => _i185.ChecklistManagementBloc(
        companyProfileBloc: get<_i169.CompanyProfileBloc>(),
        addChecklist: get<_i151.AddChecklist>(),
        updateChecklist: get<_i141.UpdateChecklist>(),
        deleteChecklist: get<_i84.DeleteChecklist>(),
      ));
  gh.factory<_i186.FilterBloc>(() => _i186.FilterBloc(
        locationBloc: get<_i178.LocationBloc>(),
        groupBloc: get<_i170.GroupBloc>(),
        userProfileBloc: get<_i165.UserProfileBloc>(),
      ));
  gh.factory<_i187.InstructionBloc>(() => _i187.InstructionBloc(
        filterBloc: get<_i186.FilterBloc>(),
        getInstructionsStream: get<_i107.GetInstructionsStream>(),
      ));
  gh.factory<_i188.ItemsBloc>(() => _i188.ItemsBloc(
        filterBloc: get<_i186.FilterBloc>(),
        getChecklistsStream: get<_i110.GetItemsStream>(),
      ));
  gh.factory<_i189.WorkOrderArchiveBloc>(() => _i189.WorkOrderArchiveBloc(
        filterBloc: get<_i186.FilterBloc>(),
        getArchiveWorkOrdersStream: get<_i96.GetArchiveWorkOrdersStream>(),
      ));
  gh.factory<_i190.WorkOrderBloc>(() => _i190.WorkOrderBloc(
        filterBloc: get<_i186.FilterBloc>(),
        getWorkOrdersStream: get<_i115.GetWorkOrdersStream>(),
      ));
  gh.factory<_i191.AssetBloc>(() => _i191.AssetBloc(
        filterBloc: get<_i186.FilterBloc>(),
        getAssetsStream: get<_i99.GetAssetsStream>(),
      ));
  gh.factory<_i192.DashboardAssetActionBloc>(
      () => _i192.DashboardAssetActionBloc(
            filterBloc: get<_i186.FilterBloc>(),
            getDashboardAssetActionsStream:
                get<_i102.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                get<_i104.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i193.DashboardItemActionBloc>(() => _i193.DashboardItemActionBloc(
        filterBloc: get<_i186.FilterBloc>(),
        getDashboardItemsActionsStream:
            get<_i103.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            get<_i105.GetDashboardLastFiveItemsActionsStream>(),
      ));
  return get;
}

class _$DataConnectionCheckerModule extends _i194.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i194.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i195.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i195.FirebaseStorageService {}

class _$SharedPreferencesService extends _i195.SharedPreferencesService {}
