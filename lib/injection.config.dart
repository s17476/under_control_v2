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
    as _i54;
import 'features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i56;
import 'features/assets/data/repositories/asset_repository_impl.dart' as _i58;
import 'features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i77;
import 'features/assets/domain/repositories/asset_action_repository.dart'
    as _i53;
import 'features/assets/domain/repositories/asset_category_repository.dart'
    as _i55;
import 'features/assets/domain/repositories/asset_repository.dart' as _i57;
import 'features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i76;
import 'features/assets/domain/usecases/add_asset.dart' as _i150;
import 'features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i151;
import 'features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i81;
import 'features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i98;
import 'features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i103;
import 'features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i105;
import 'features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i112;
import 'features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i141;
import 'features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i152;
import 'features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i82;
import 'features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i99;
import 'features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i142;
import 'features/assets/domain/usecases/check_code_availability.dart' as _i67;
import 'features/assets/domain/usecases/delete_asset.dart' as _i80;
import 'features/assets/domain/usecases/get_assets_stream.dart' as _i100;
import 'features/assets/domain/usecases/update_asset.dart' as _i140;
import 'features/assets/presentation/blocs/asset/asset_bloc.dart' as _i196;
import 'features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i158;
import 'features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i185;
import 'features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i168;
import 'features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i186;
import 'features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i169;
import 'features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i197;
import 'features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i159;
import 'features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i63;
import 'features/authentication/domain/repositories/authentication_repository.dart'
    as _i62;
import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i200;
import 'features/authentication/domain/usecases/auto_signin.dart' as _i64;
import 'features/authentication/domain/usecases/check_email_verification.dart'
    as _i68;
import 'features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i128;
import 'features/authentication/domain/usecases/send_verification_email.dart'
    as _i129;
import 'features/authentication/domain/usecases/signin.dart' as _i130;
import 'features/authentication/domain/usecases/signout.dart' as _i131;
import 'features/authentication/domain/usecases/signup.dart' as _i132;
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i160;
import 'features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i70;
import 'features/checklists/domain/repositories/checklists_repository.dart'
    as _i69;
import 'features/checklists/domain/usecases/add_checklist.dart' as _i153;
import 'features/checklists/domain/usecases/delete_checklist.dart' as _i83;
import 'features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i101;
import 'features/checklists/domain/usecases/update_checklist.dart' as _i143;
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i187;
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i188;
import 'features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i72;
import 'features/company_profile/data/repositories/company_repository_impl.dart'
    as _i74;
import 'features/company_profile/domain/repositories/company_management_repository.dart'
    as _i71;
import 'features/company_profile/domain/repositories/company_repository.dart'
    as _i73;
import 'features/company_profile/domain/usecases/add_company.dart' as _i154;
import 'features/company_profile/domain/usecases/add_company_logo.dart'
    as _i155;
import 'features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i92;
import 'features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i93;
import 'features/company_profile/domain/usecases/fetch_new_users.dart' as _i94;
import 'features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i95;
import 'features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i102;
import 'features/company_profile/domain/usecases/update_company.dart' as _i144;
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i170;
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i171;
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i181;
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i182;
import 'features/core/injectable_modules/injectable_modules.dart' as _i201;
import 'features/core/network/network_info.dart' as _i23;
import 'features/core/utils/input_validator.dart' as _i8;
import 'features/filter/presentation/blocs/filter/filter_bloc.dart' as _i189;
import 'features/groups/data/datasources/group_local_data_source.dart' as _i118;
import 'features/groups/data/datasources/group_remote_data_source.dart' as _i7;
import 'features/groups/data/repositories/group_repository_impl.dart' as _i120;
import 'features/groups/domain/repositories/group_repository.dart' as _i119;
import 'features/groups/domain/usecases/add_group.dart' as _i156;
import 'features/groups/domain/usecases/cache_groups.dart' as _i161;
import 'features/groups/domain/usecases/delete_group.dart' as _i163;
import 'features/groups/domain/usecases/get_groups_stream.dart' as _i166;
import 'features/groups/domain/usecases/try_to_get_cached_groups.dart' as _i134;
import 'features/groups/domain/usecases/update_group.dart' as _i145;
import 'features/groups/presentation/blocs/group/group_bloc.dart' as _i172;
import 'features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i79;
import 'features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'features/inventory/data/repositories/item_repository_impl.dart' as _i20;
import 'features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i78;
import 'features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'features/inventory/domain/repositories/item_repository.dart' as _i19;
import 'features/inventory/domain/usecases/add_item.dart' as _i42;
import 'features/inventory/domain/usecases/add_item_photo.dart' as _i45;
import 'features/inventory/domain/usecases/delete_item.dart' as _i86;
import 'features/inventory/domain/usecases/delete_item_photo.dart' as _i89;
import 'features/inventory/domain/usecases/get_items_stream.dart' as _i111;
import 'features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i43;
import 'features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i87;
import 'features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i104;
import 'features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i106;
import 'features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i109;
import 'features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i113;
import 'features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i30;
import 'features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i44;
import 'features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i88;
import 'features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i110;
import 'features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i31;
import 'features/inventory/domain/usecases/update_item.dart' as _i29;
import 'features/inventory/domain/usecases/update_item_photo.dart' as _i32;
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i198;
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i121;
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i176;
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i177;
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i178;
import 'features/inventory/presentation/blocs/items/items_bloc.dart' as _i191;
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i179;
import 'features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'features/knowledge_base/domain/usecases/add_instruction.dart' as _i40;
import 'features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i84;
import 'features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i108;
import 'features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i41;
import 'features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i85;
import 'features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i107;
import 'features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i28;
import 'features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i27;
import 'features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i190;
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i173;
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i174;
import 'features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i175;
import 'features/locations/data/datasources/location_local_data_source.dart'
    as _i122;
import 'features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'features/locations/data/repositories/location_repository_impl.dart'
    as _i124;
import 'features/locations/domain/repositories/location_repository.dart'
    as _i123;
import 'features/locations/domain/usecases/add_location.dart' as _i157;
import 'features/locations/domain/usecases/cache_location.dart' as _i162;
import 'features/locations/domain/usecases/delete_location.dart' as _i164;
import 'features/locations/domain/usecases/fetch_all_locations.dart' as _i165;
import 'features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i135;
import 'features/locations/domain/usecases/update_location.dart' as _i146;
import 'features/locations/presentation/blocs/bloc/location_bloc.dart' as _i180;
import 'features/tasks/data/repositories/task_repository_impl.dart' as _i26;
import 'features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i39;
import 'features/tasks/domain/repositories/task_repository.dart' as _i25;
import 'features/tasks/domain/repositories/work_request_repository.dart'
    as _i38;
import 'features/tasks/domain/usecases/task/add_task.dart' as _i46;
import 'features/tasks/domain/usecases/task/cancel_task.dart' as _i65;
import 'features/tasks/domain/usecases/task/complete_task.dart' as _i75;
import 'features/tasks/domain/usecases/task/delete_task.dart' as _i90;
import 'features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i96;
import 'features/tasks/domain/usecases/task/get_tasks_stream.dart' as _i114;
import 'features/tasks/domain/usecases/task/update_task.dart' as _i33;
import 'features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i49;
import 'features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i66;
import 'features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i91;
import 'features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i97;
import 'features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i117;
import 'features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i148;
import 'features/tasks/presentation/blocs/task/task_bloc.dart' as _i193;
import 'features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i192;
import 'features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i199;
import 'features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i183;
import 'features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i195;
import 'features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i194;
import 'features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i184;
import 'features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i35;
import 'features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i37;
import 'features/user_profile/domain/repositories/user_files_repository.dart'
    as _i34;
import 'features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i36;
import 'features/user_profile/domain/usecases/add_user.dart' as _i47;
import 'features/user_profile/domain/usecases/add_user_avatar.dart' as _i48;
import 'features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i50;
import 'features/user_profile/domain/usecases/approve_user.dart' as _i51;
import 'features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i52;
import 'features/user_profile/domain/usecases/assign_group_admin.dart' as _i59;
import 'features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i60;
import 'features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i61;
import 'features/user_profile/domain/usecases/get_user_by_id.dart' as _i115;
import 'features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i116;
import 'features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i125;
import 'features/user_profile/domain/usecases/reject_user.dart' as _i126;
import 'features/user_profile/domain/usecases/reset_company.dart' as _i127;
import 'features/user_profile/domain/usecases/suspend_user.dart' as _i133;
import 'features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i136;
import 'features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i137;
import 'features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i138;
import 'features/user_profile/domain/usecases/unsuspend_user.dart' as _i139;
import 'features/user_profile/domain/usecases/update_user_data.dart' as _i147;
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i149;
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i167; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i25.TaskRepository>(() => _i26.TaskRepositoryImpl(
        firebaseFirestore: get<_i5.FirebaseFirestore>(),
        firebaseStorage: get<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i27.UpdateInstruction>(() =>
      _i27.UpdateInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i28.UpdateInstructionCategory>(() =>
      _i28.UpdateInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i29.UpdateItem>(
      () => _i29.UpdateItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i30.UpdateItemAction>(() =>
      _i30.UpdateItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i31.UpdateItemCategory>(() =>
      _i31.UpdateItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i32.UpdateItemPhoto>(
      () => _i32.UpdateItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i33.UpdateTask>(
      () => _i33.UpdateTask(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i34.UserFilesRepository>(() => _i35.UserFilesRepositoryImpl(
      firebaseStorage: get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i36.UserProfileRepository>(() =>
      _i37.UserProfileRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i38.WorkRequestsRepository>(
      () => _i39.WorkRequestsRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i40.AddInstruction>(
      () => _i40.AddInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i41.AddInstructionCategory>(() =>
      _i41.AddInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i42.AddItem>(
      () => _i42.AddItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i43.AddItemAction>(
      () => _i43.AddItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i44.AddItemCategory>(() =>
      _i44.AddItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i45.AddItemPhoto>(
      () => _i45.AddItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i46.AddTask>(
      () => _i46.AddTask(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i47.AddUser>(
      () => _i47.AddUser(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i48.AddUserAvatar>(
      () => _i48.AddUserAvatar(repository: get<_i34.UserFilesRepository>()));
  gh.lazySingleton<_i49.AddWorkRequest>(() =>
      _i49.AddWorkRequest(repository: get<_i38.WorkRequestsRepository>()));
  gh.lazySingleton<_i50.ApprovePassiveUser>(() =>
      _i50.ApprovePassiveUser(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i51.ApproveUser>(
      () => _i51.ApproveUser(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i52.ApproveUserAndMakeAdmin>(() =>
      _i52.ApproveUserAndMakeAdmin(
          repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i53.AssetActionRepository>(() =>
      _i54.AssetActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i55.AssetCategoryRepository>(() =>
      _i56.AssetCategoryRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i57.AssetRepository>(() => _i58.AssetRepositoryImpl(
        firebaseFirestore: get<_i5.FirebaseFirestore>(),
        firebaseStorage: get<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i59.AssignGroupAdmin>(() =>
      _i59.AssignGroupAdmin(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i60.AssignUserToCompany>(() =>
      _i60.AssignUserToCompany(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i61.AssignUserToGroup>(() =>
      _i61.AssignUserToGroup(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i62.AuthenticationRepository>(
      () => _i63.AuthenticationRepositoryImpl(
            firebaseAuth: get<_i4.FirebaseAuth>(),
            networkInfo: get<_i23.NetworkInfo>(),
          ));
  gh.lazySingleton<_i64.AutoSignin>(() => _i64.AutoSignin(
      authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i65.CancelTask>(
      () => _i65.CancelTask(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i66.CancelWorkRequest>(() =>
      _i66.CancelWorkRequest(repository: get<_i38.WorkRequestsRepository>()));
  gh.lazySingleton<_i67.CheckCodeAvailability>(() =>
      _i67.CheckCodeAvailability(repository: get<_i57.AssetRepository>()));
  gh.lazySingleton<_i68.CheckEmailVerification>(() =>
      _i68.CheckEmailVerification(
          authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i69.CheckListsRepository>(() =>
      _i70.ChecklistsRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i71.CompanyManagementRepository>(
      () => _i72.CompanyManagementRepositoryImpl(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseStorage: get<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i73.CompanyRepository>(() => _i74.CompanyRepositoryImpl(
      firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i75.CompleteTask>(
      () => _i75.CompleteTask(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i76.DashboardAssetActionRepository>(() =>
      _i77.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i78.DashboardItemActionRepository>(() =>
      _i79.DashboardItemActionRepositoryImpl(
          firebaseFirestore: get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i80.DeleteAsset>(
      () => _i80.DeleteAsset(repository: get<_i57.AssetRepository>()));
  gh.lazySingleton<_i81.DeleteAssetAction>(() =>
      _i81.DeleteAssetAction(repository: get<_i53.AssetActionRepository>()));
  gh.lazySingleton<_i82.DeleteAssetCategory>(() => _i82.DeleteAssetCategory(
      repository: get<_i55.AssetCategoryRepository>()));
  gh.lazySingleton<_i83.DeleteChecklist>(
      () => _i83.DeleteChecklist(repository: get<_i69.CheckListsRepository>()));
  gh.lazySingleton<_i84.DeleteInstruction>(() =>
      _i84.DeleteInstruction(repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i85.DeleteInstructionCategory>(() =>
      _i85.DeleteInstructionCategory(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i86.DeleteItem>(
      () => _i86.DeleteItem(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i87.DeleteItemAction>(() =>
      _i87.DeleteItemAction(repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i88.DeleteItemCategory>(() =>
      _i88.DeleteItemCategory(repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i89.DeleteItemPhoto>(
      () => _i89.DeleteItemPhoto(repository: get<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i90.DeleteTask>(
      () => _i90.DeleteTask(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i91.DeleteWorkRequest>(() =>
      _i91.DeleteWorkRequest(repository: get<_i38.WorkRequestsRepository>()));
  gh.lazySingleton<_i92.FetchAllCompanies>(() => _i92.FetchAllCompanies(
      companyManagementRepository: get<_i71.CompanyManagementRepository>()));
  gh.lazySingleton<_i93.FetchAllCompanyUsers>(() => _i93.FetchAllCompanyUsers(
      companyRepository: get<_i73.CompanyRepository>()));
  gh.lazySingleton<_i94.FetchNewUsers>(() =>
      _i94.FetchNewUsers(companyRepository: get<_i73.CompanyRepository>()));
  gh.lazySingleton<_i95.FetchSuspendedUsers>(() => _i95.FetchSuspendedUsers(
      companyRepository: get<_i73.CompanyRepository>()));
  gh.lazySingleton<_i96.GetArchiveTasksStream>(
      () => _i96.GetArchiveTasksStream(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i97.GetArchiveWorkRequestsStream>(() =>
      _i97.GetArchiveWorkRequestsStream(
          repository: get<_i38.WorkRequestsRepository>()));
  gh.lazySingleton<_i98.GetAssetActionsStream>(() => _i98.GetAssetActionsStream(
      repository: get<_i53.AssetActionRepository>()));
  gh.lazySingleton<_i99.GetAssetsCategoriesStream>(() =>
      _i99.GetAssetsCategoriesStream(
          repository: get<_i55.AssetCategoryRepository>()));
  gh.lazySingleton<_i100.GetAssetsStream>(
      () => _i100.GetAssetsStream(repository: get<_i57.AssetRepository>()));
  gh.lazySingleton<_i101.GetChecklistStream>(() =>
      _i101.GetChecklistStream(repository: get<_i69.CheckListsRepository>()));
  gh.lazySingleton<_i102.GetCompanyById>(() =>
      _i102.GetCompanyById(companyRepository: get<_i73.CompanyRepository>()));
  gh.lazySingleton<_i103.GetDashboardAssetActionsStream>(() =>
      _i103.GetDashboardAssetActionsStream(
          repository: get<_i76.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i104.GetDashboardItemsActionsStream>(() =>
      _i104.GetDashboardItemsActionsStream(
          repository: get<_i78.DashboardItemActionRepository>()));
  gh.lazySingleton<_i105.GetDashboardLastFiveAssetActionsStream>(() =>
      _i105.GetDashboardLastFiveAssetActionsStream(
          repository: get<_i76.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i106.GetDashboardLastFiveItemsActionsStream>(() =>
      _i106.GetDashboardLastFiveItemsActionsStream(
          repository: get<_i78.DashboardItemActionRepository>()));
  gh.lazySingleton<_i107.GetInstructionsCategoriesStream>(() =>
      _i107.GetInstructionsCategoriesStream(
          repository: get<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i108.GetInstructionsStream>(() =>
      _i108.GetInstructionsStream(
          repository: get<_i11.InstructionRepository>()));
  gh.lazySingleton<_i109.GetItemsActionsStream>(() =>
      _i109.GetItemsActionsStream(
          repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i110.GetItemsCategoriesStream>(() =>
      _i110.GetItemsCategoriesStream(
          repository: get<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i111.GetItemsStream>(
      () => _i111.GetItemsStream(repository: get<_i19.ItemRepository>()));
  gh.lazySingleton<_i112.GetLastFiveAssetActionsStream>(() =>
      _i112.GetLastFiveAssetActionsStream(
          repository: get<_i53.AssetActionRepository>()));
  gh.lazySingleton<_i113.GetLastFiveItemsActionsStream>(() =>
      _i113.GetLastFiveItemsActionsStream(
          repository: get<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i114.GetTasksStream>(
      () => _i114.GetTasksStream(repository: get<_i25.TaskRepository>()));
  gh.lazySingleton<_i115.GetUserById>(
      () => _i115.GetUserById(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i116.GetUserStreamById>(() => _i116.GetUserStreamById(
      userRepository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i117.GetWorkRequestsStream>(() =>
      _i117.GetWorkRequestsStream(
          repository: get<_i38.WorkRequestsRepository>()));
  gh.lazySingleton<_i118.GroupLocalDataSource>(() =>
      _i118.GroupLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i119.GroupRepository>(() => _i120.GroupRepositoryImpl(
        groupRemoteDataSource: get<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: get<_i118.GroupLocalDataSource>(),
      ));
  gh.factory<_i121.ItemActionBloc>(() => _i121.ItemActionBloc(
        getItemsActionsStream: get<_i109.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            get<_i113.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i122.LocationLocalDataSource>(() =>
      _i122.LocationLocalDataSourceImpl(source: get<_i24.SharedPreferences>()));
  gh.lazySingleton<_i123.LocationRepository>(() => _i124.LocationRepositoryImpl(
        locationLocalDataSource: get<_i122.LocationLocalDataSource>(),
        locationRemoteDataSource: get<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i125.MakeUserAdministrator>(() =>
      _i125.MakeUserAdministrator(
          repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i126.RejectUser>(
      () => _i126.RejectUser(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i127.ResetCompany>(
      () => _i127.ResetCompany(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i128.SendPasswordResetEmail>(() =>
      _i128.SendPasswordResetEmail(
          authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i129.SendVerificationEmail>(() =>
      _i129.SendVerificationEmail(
          authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i130.Signin>(() => _i130.Signin(
      authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i131.Signout>(() => _i131.Signout(
      authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i132.Signup>(() => _i132.Signup(
      authenticationRepository: get<_i62.AuthenticationRepository>()));
  gh.lazySingleton<_i133.SuspendUser>(
      () => _i133.SuspendUser(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i134.TryToGetCachedGroups>(() => _i134.TryToGetCachedGroups(
      groupRepository: get<_i119.GroupRepository>()));
  gh.lazySingleton<_i135.TryToGetCachedLocation>(() =>
      _i135.TryToGetCachedLocation(
          locationRepository: get<_i123.LocationRepository>()));
  gh.lazySingleton<_i136.UnassignGroupAdmin>(() =>
      _i136.UnassignGroupAdmin(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i137.UnassignUserFromGroup>(() =>
      _i137.UnassignUserFromGroup(
          repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i138.UnmakeUserAdministrator>(() =>
      _i138.UnmakeUserAdministrator(
          repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i139.UnsuspendUser>(
      () => _i139.UnsuspendUser(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i140.UpdateAsset>(
      () => _i140.UpdateAsset(repository: get<_i57.AssetRepository>()));
  gh.lazySingleton<_i141.UpdateAssetAction>(() =>
      _i141.UpdateAssetAction(repository: get<_i53.AssetActionRepository>()));
  gh.lazySingleton<_i142.UpdateAssetCategory>(() => _i142.UpdateAssetCategory(
      repository: get<_i55.AssetCategoryRepository>()));
  gh.lazySingleton<_i143.UpdateChecklist>(() =>
      _i143.UpdateChecklist(repository: get<_i69.CheckListsRepository>()));
  gh.lazySingleton<_i144.UpdateCompany>(() => _i144.UpdateCompany(
      companyRepository: get<_i71.CompanyManagementRepository>()));
  gh.lazySingleton<_i145.UpdateGroup>(
      () => _i145.UpdateGroup(groupRepository: get<_i119.GroupRepository>()));
  gh.lazySingleton<_i146.UpdateLocation>(() => _i146.UpdateLocation(
      locationRepository: get<_i123.LocationRepository>()));
  gh.lazySingleton<_i147.UpdateUserData>(() =>
      _i147.UpdateUserData(repository: get<_i36.UserProfileRepository>()));
  gh.lazySingleton<_i148.UpdateWorkRequest>(() =>
      _i148.UpdateWorkRequest(repository: get<_i38.WorkRequestsRepository>()));
  gh.factory<_i149.UserManagementBloc>(() => _i149.UserManagementBloc(
        approveUser: get<_i51.ApproveUser>(),
        approvePassiveUser: get<_i50.ApprovePassiveUser>(),
        makeUserAdministrator: get<_i125.MakeUserAdministrator>(),
        unmakeUserAdministrator: get<_i138.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: get<_i52.ApproveUserAndMakeAdmin>(),
        rejectUser: get<_i126.RejectUser>(),
        suspendUser: get<_i133.SuspendUser>(),
        unsuspendUser: get<_i139.UnsuspendUser>(),
        updateUserData: get<_i147.UpdateUserData>(),
        assignUserToGroup: get<_i61.AssignUserToGroup>(),
        unassignUserFromGroup: get<_i137.UnassignUserFromGroup>(),
        assignGroupAdmin: get<_i59.AssignGroupAdmin>(),
        unassignGroupAdmin: get<_i136.UnassignGroupAdmin>(),
        addUserAvatar: get<_i48.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i150.AddAsset>(
      () => _i150.AddAsset(repository: get<_i57.AssetRepository>()));
  gh.lazySingleton<_i151.AddAssetAction>(() =>
      _i151.AddAssetAction(repository: get<_i53.AssetActionRepository>()));
  gh.lazySingleton<_i152.AddAssetCategory>(() =>
      _i152.AddAssetCategory(repository: get<_i55.AssetCategoryRepository>()));
  gh.lazySingleton<_i153.AddChecklist>(
      () => _i153.AddChecklist(repository: get<_i69.CheckListsRepository>()));
  gh.lazySingleton<_i154.AddCompany>(() => _i154.AddCompany(
      companyManagementRepository: get<_i71.CompanyManagementRepository>()));
  gh.lazySingleton<_i155.AddCompanyLogo>(() => _i155.AddCompanyLogo(
      repository: get<_i71.CompanyManagementRepository>()));
  gh.lazySingleton<_i156.AddGroup>(
      () => _i156.AddGroup(groupRepository: get<_i119.GroupRepository>()));
  gh.lazySingleton<_i157.AddLocation>(() =>
      _i157.AddLocation(locationRepository: get<_i123.LocationRepository>()));
  gh.factory<_i158.AssetActionBloc>(() => _i158.AssetActionBloc(
        getAssetActionsStream: get<_i98.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            get<_i112.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i159.AssetInternalNumberCubit>(
      () => _i159.AssetInternalNumberCubit(get<_i67.CheckCodeAvailability>()));
  gh.factory<_i160.AuthenticationBloc>(() => _i160.AuthenticationBloc(
        signin: get<_i130.Signin>(),
        signup: get<_i132.Signup>(),
        signout: get<_i131.Signout>(),
        autoSignin: get<_i64.AutoSignin>(),
        sendVerificationEmail: get<_i129.SendVerificationEmail>(),
        checkEmailVerification: get<_i68.CheckEmailVerification>(),
        sendPasswordResetEmail: get<_i128.SendPasswordResetEmail>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i161.CacheGroups>(
      () => _i161.CacheGroups(groupRepository: get<_i119.GroupRepository>()));
  gh.lazySingleton<_i162.CacheLocation>(() =>
      _i162.CacheLocation(locationRepository: get<_i123.LocationRepository>()));
  gh.lazySingleton<_i163.DeleteGroup>(
      () => _i163.DeleteGroup(groupRepository: get<_i119.GroupRepository>()));
  gh.lazySingleton<_i164.DeleteLocation>(() => _i164.DeleteLocation(
      locationRepository: get<_i123.LocationRepository>()));
  gh.lazySingleton<_i165.FetchAllLocations>(() => _i165.FetchAllLocations(
      locationRepository: get<_i123.LocationRepository>()));
  gh.lazySingleton<_i166.GetGroupsStream>(() =>
      _i166.GetGroupsStream(groupRepository: get<_i119.GroupRepository>()));
  gh.factory<_i167.UserProfileBloc>(() => _i167.UserProfileBloc(
        authenticationBloc: get<_i160.AuthenticationBloc>(),
        addUser: get<_i47.AddUser>(),
        assignUserToCompany: get<_i60.AssignUserToCompany>(),
        resetCompany: get<_i127.ResetCompany>(),
        getUserById: get<_i115.GetUserById>(),
        getUserStreamById: get<_i116.GetUserStreamById>(),
        updateUserData: get<_i147.UpdateUserData>(),
        addUserAvatar: get<_i48.AddUserAvatar>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i168.AssetCategoryBloc>(() => _i168.AssetCategoryBloc(
        userProfileBloc: get<_i167.UserProfileBloc>(),
        getAssetsCategoriesStream: get<_i99.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i169.AssetManagementBloc>(() => _i169.AssetManagementBloc(
        userProfileBloc: get<_i167.UserProfileBloc>(),
        addAsset: get<_i150.AddAsset>(),
        deleteAsset: get<_i80.DeleteAsset>(),
        updateAsset: get<_i140.UpdateAsset>(),
      ));
  gh.factory<_i170.CompanyManagementBloc>(() => _i170.CompanyManagementBloc(
        userProfileBloc: get<_i167.UserProfileBloc>(),
        inputValidator: get<_i8.InputValidator>(),
        addCompany: get<_i154.AddCompany>(),
        fetchAllCompanies: get<_i92.FetchAllCompanies>(),
        addCompanyLogo: get<_i155.AddCompanyLogo>(),
        updateCompany: get<_i144.UpdateCompany>(),
      ));
  gh.factory<_i171.CompanyProfileBloc>(() => _i171.CompanyProfileBloc(
        userProfileBloc: get<_i167.UserProfileBloc>(),
        fetchAllCompanyUsers: get<_i93.FetchAllCompanyUsers>(),
        getCompanyById: get<_i102.GetCompanyById>(),
        inputValidator: get<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i172.GroupBloc>(() => _i172.GroupBloc(
        companyProfileBloc: get<_i171.CompanyProfileBloc>(),
        addGroup: get<_i156.AddGroup>(),
        updateGroup: get<_i145.UpdateGroup>(),
        deleteGroup: get<_i163.DeleteGroup>(),
        getGroupsStream: get<_i166.GetGroupsStream>(),
        cacheGroups: get<_i161.CacheGroups>(),
        tryToGetCachedGroups: get<_i134.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i173.InstructionCategoryBloc>(
      () => _i173.InstructionCategoryBloc(
            userProfileBloc: get<_i167.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                get<_i107.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i174.InstructionCategoryManagementBloc>(
      () => _i174.InstructionCategoryManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addInstructionCategory: get<_i41.AddInstructionCategory>(),
            updateInstructionCategory: get<_i28.UpdateInstructionCategory>(),
            deleteInstructionCategory: get<_i85.DeleteInstructionCategory>(),
          ));
  gh.factory<_i175.InstructionManagementBloc>(
      () => _i175.InstructionManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addInstruction: get<_i40.AddInstruction>(),
            deleteInstruction: get<_i84.DeleteInstruction>(),
            updateInstruction: get<_i27.UpdateInstruction>(),
          ));
  gh.factory<_i176.ItemActionManagementBloc>(
      () => _i176.ItemActionManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addItemAction: get<_i43.AddItemAction>(),
            updateItemAction: get<_i30.UpdateItemAction>(),
            deleteItemAction: get<_i87.DeleteItemAction>(),
            moveItemAction: get<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i177.ItemCategoryBloc>(() => _i177.ItemCategoryBloc(
        userProfileBloc: get<_i167.UserProfileBloc>(),
        getItemsCategoriesStream: get<_i110.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i178.ItemCategoryManagementBloc>(
      () => _i178.ItemCategoryManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addItemCategory: get<_i44.AddItemCategory>(),
            updateItemCategory: get<_i31.UpdateItemCategory>(),
            deleteItemCategory: get<_i88.DeleteItemCategory>(),
          ));
  gh.factory<_i179.ItemsManagementBloc>(() => _i179.ItemsManagementBloc(
        addItemPhoto: get<_i45.AddItemPhoto>(),
        deleteItemPhoto: get<_i89.DeleteItemPhoto>(),
        updateItemPhoto: get<_i32.UpdateItemPhoto>(),
        companyProfileBloc: get<_i171.CompanyProfileBloc>(),
        addItem: get<_i42.AddItem>(),
        deleteItem: get<_i86.DeleteItem>(),
        updateItem: get<_i29.UpdateItem>(),
      ));
  gh.lazySingleton<_i180.LocationBloc>(() => _i180.LocationBloc(
        companyProfileBloc: get<_i171.CompanyProfileBloc>(),
        addLocation: get<_i157.AddLocation>(),
        cacheLocation: get<_i162.CacheLocation>(),
        deleteLocation: get<_i164.DeleteLocation>(),
        fetchAllLocations: get<_i165.FetchAllLocations>(),
        tryToGetCachedLocation: get<_i135.TryToGetCachedLocation>(),
        updateLocation: get<_i146.UpdateLocation>(),
      ));
  gh.factory<_i181.NewUsersBloc>(() => _i181.NewUsersBloc(
        get<_i171.CompanyProfileBloc>(),
        get<_i94.FetchNewUsers>(),
      ));
  gh.factory<_i182.SuspendedUsersBloc>(() => _i182.SuspendedUsersBloc(
        get<_i171.CompanyProfileBloc>(),
        get<_i95.FetchSuspendedUsers>(),
      ));
  gh.factory<_i183.TaskManagementBloc>(() => _i183.TaskManagementBloc(
        companyProfileBloc: get<_i171.CompanyProfileBloc>(),
        addTask: get<_i46.AddTask>(),
        deleteTask: get<_i90.DeleteTask>(),
        updateTask: get<_i33.UpdateTask>(),
        cancelTask: get<_i65.CancelTask>(),
      ));
  gh.factory<_i184.WorkRequestManagementBloc>(
      () => _i184.WorkRequestManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addWorkRequest: get<_i49.AddWorkRequest>(),
            deleteWorkRequest: get<_i91.DeleteWorkRequest>(),
            updateWorkRequest: get<_i148.UpdateWorkRequest>(),
            cancelWorkRequest: get<_i66.CancelWorkRequest>(),
          ));
  gh.factory<_i185.AssetActionManagementBloc>(
      () => _i185.AssetActionManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addAssetAction: get<_i151.AddAssetAction>(),
            updateAssetAction: get<_i141.UpdateAssetAction>(),
            deleteAssetAction: get<_i81.DeleteAssetAction>(),
          ));
  gh.factory<_i186.AssetCategoryManagementBloc>(
      () => _i186.AssetCategoryManagementBloc(
            companyProfileBloc: get<_i171.CompanyProfileBloc>(),
            addAssetCategory: get<_i152.AddAssetCategory>(),
            updateAssetCategory: get<_i142.UpdateAssetCategory>(),
            deleteAssetCategory: get<_i82.DeleteAssetCategory>(),
          ));
  gh.lazySingleton<_i187.ChecklistBloc>(() => _i187.ChecklistBloc(
        companyProfileBloc: get<_i171.CompanyProfileBloc>(),
        getChecklistsStream: get<_i101.GetChecklistStream>(),
      ));
  gh.factory<_i188.ChecklistManagementBloc>(() => _i188.ChecklistManagementBloc(
        companyProfileBloc: get<_i171.CompanyProfileBloc>(),
        addChecklist: get<_i153.AddChecklist>(),
        updateChecklist: get<_i143.UpdateChecklist>(),
        deleteChecklist: get<_i83.DeleteChecklist>(),
      ));
  gh.factory<_i189.FilterBloc>(() => _i189.FilterBloc(
        locationBloc: get<_i180.LocationBloc>(),
        groupBloc: get<_i172.GroupBloc>(),
        userProfileBloc: get<_i167.UserProfileBloc>(),
      ));
  gh.factory<_i190.InstructionBloc>(() => _i190.InstructionBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getInstructionsStream: get<_i108.GetInstructionsStream>(),
      ));
  gh.factory<_i191.ItemsBloc>(() => _i191.ItemsBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getChecklistsStream: get<_i111.GetItemsStream>(),
      ));
  gh.factory<_i192.TaskArchiveBloc>(() => _i192.TaskArchiveBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getArchiveTasksStream: get<_i96.GetArchiveTasksStream>(),
      ));
  gh.factory<_i193.TaskBloc>(() => _i193.TaskBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getTasksStream: get<_i114.GetTasksStream>(),
      ));
  gh.factory<_i194.WorkRequestArchiveBloc>(() => _i194.WorkRequestArchiveBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getArchiveWorkRequestsStream: get<_i97.GetArchiveWorkRequestsStream>(),
      ));
  gh.factory<_i195.WorkRequestBloc>(() => _i195.WorkRequestBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getWorkRequestsStream: get<_i117.GetWorkRequestsStream>(),
      ));
  gh.factory<_i196.AssetBloc>(() => _i196.AssetBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getAssetsStream: get<_i100.GetAssetsStream>(),
      ));
  gh.factory<_i197.DashboardAssetActionBloc>(
      () => _i197.DashboardAssetActionBloc(
            filterBloc: get<_i189.FilterBloc>(),
            getDashboardAssetActionsStream:
                get<_i103.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                get<_i105.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i198.DashboardItemActionBloc>(() => _i198.DashboardItemActionBloc(
        filterBloc: get<_i189.FilterBloc>(),
        getDashboardItemsActionsStream:
            get<_i104.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            get<_i106.GetDashboardLastFiveItemsActionsStream>(),
      ));
  gh.factory<_i199.TaskFilterBloc>(() => _i199.TaskFilterBloc(
        get<_i167.UserProfileBloc>(),
        get<_i193.TaskBloc>(),
        get<_i195.WorkRequestBloc>(),
      ));
  return get;
}

class _$DataConnectionCheckerModule extends _i200.DataConnectionCheckerModule {}

class _$FirebaseAuthenticationService
    extends _i200.FirebaseAuthenticationService {}

class _$FirebaseFirestoreService extends _i201.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i201.FirebaseStorageService {}

class _$SharedPreferencesService extends _i201.SharedPreferencesService {}
