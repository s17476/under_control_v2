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
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i58;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i60;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i62;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i81;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i57;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i59;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i61;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i80;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i157;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i158;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i85;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i103;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i108;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i110;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i117;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i148;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i159;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i86;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i104;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i149;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i71;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i84;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i105;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i147;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i165;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i192;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i175;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i176;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i166;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i67;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i66;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i68;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i72;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i135;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i136;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i137;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i138;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i139;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i167;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i74;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i73;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i160;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i87;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i106;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i150;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i195;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i76;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i78;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i75;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i77;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i161;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i162;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i97;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i98;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i99;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i100;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i107;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i151;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i177;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i178;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i188;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i189;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i23;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i125;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i127;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i126;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i163;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i168;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i170;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i173;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i141;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i152;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i179;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i83;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i82;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i45;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i90;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i93;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i116;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i91;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i109;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i111;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i114;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i118;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i32;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i92;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i115;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i33;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i31;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i34;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i128;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i183;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i184;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i185;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i186;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i43;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i88;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i113;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i44;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i89;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i112;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i30;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i29;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i180;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i181;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i182;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i129;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i131;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i130;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i164;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i169;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i171;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i172;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i142;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i153;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i187;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i26;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i28;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i42;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i25;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i27;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i41;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i49;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i69;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i79;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i94;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i101;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i121;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i35;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i50;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i95;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i119;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i120;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i36;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i53;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i70;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i96;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i102;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i124;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i155;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i190;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i38;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i40;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i37;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i39;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i51;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i52;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i54;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i55;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i56;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i63;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i64;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i65;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i122;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i123;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i132;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i133;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i134;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i140;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i143;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i144;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i145;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i146;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i154;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i156;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i174;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i208;
import 'features/core/injectable_modules/injectable_modules.dart' as _i207;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
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
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i8.InputValidator>(() => _i8.InputValidator());
  gh.lazySingleton<_i9.InstructionCategoryRepository>(() =>
      _i10.InstructionCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.InstructionRepository>(
      () => _i12.InstructionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i13.ItemActionRepository>(() =>
      _i14.ItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i15.ItemCategoryRepository>(() =>
      _i16.ItemCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i17.ItemFilesRepository>(() =>
      _i18.ItemFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i19.ItemRepository>(() => _i20.ItemRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i21.LocationRemoteDataSource>(() =>
      _i21.LocationRemoteDataSourceImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i22.MoveItemAction>(
      () => _i22.MoveItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i23.NetworkInfo>(() => _i23.NetworkInfoImpl(
      dataConnectionChecker: gh<_i3.DataConnectionChecker>()));
  await gh.factoryAsync<_i24.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i25.TaskActionRepository>(
      () => _i26.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i27.TaskRepository>(() => _i28.TaskRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i29.UpdateInstruction>(() =>
      _i29.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i30.UpdateInstructionCategory>(() =>
      _i30.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i31.UpdateItem>(
      () => _i31.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i32.UpdateItemAction>(
      () => _i32.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i33.UpdateItemCategory>(() =>
      _i33.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i34.UpdateItemPhoto>(
      () => _i34.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i35.UpdateTask>(
      () => _i35.UpdateTask(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i36.UpdateTaskAction>(
      () => _i36.UpdateTaskAction(repository: gh<_i25.TaskActionRepository>()));
  gh.lazySingleton<_i37.UserFilesRepository>(() =>
      _i38.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i39.UserProfileRepository>(() =>
      _i40.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i41.WorkRequestsRepository>(
      () => _i42.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i43.AddInstruction>(
      () => _i43.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i44.AddInstructionCategory>(() =>
      _i44.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i45.AddItem>(
      () => _i45.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i46.AddItemAction>(
      () => _i46.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i47.AddItemCategory>(() =>
      _i47.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i48.AddItemPhoto>(
      () => _i48.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i49.AddTask>(
      () => _i49.AddTask(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i50.AddTaskAction>(
      () => _i50.AddTaskAction(repository: gh<_i25.TaskActionRepository>()));
  gh.lazySingleton<_i51.AddUser>(
      () => _i51.AddUser(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i52.AddUserAvatar>(
      () => _i52.AddUserAvatar(repository: gh<_i37.UserFilesRepository>()));
  gh.lazySingleton<_i53.AddWorkRequest>(
      () => _i53.AddWorkRequest(repository: gh<_i41.WorkRequestsRepository>()));
  gh.lazySingleton<_i54.ApprovePassiveUser>(() =>
      _i54.ApprovePassiveUser(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i55.ApproveUser>(
      () => _i55.ApproveUser(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i56.ApproveUserAndMakeAdmin>(() =>
      _i56.ApproveUserAndMakeAdmin(
          repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i57.AssetActionRepository>(() =>
      _i58.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i59.AssetCategoryRepository>(() =>
      _i60.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i61.AssetRepository>(() => _i62.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i63.AssignGroupAdmin>(() =>
      _i63.AssignGroupAdmin(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i64.AssignUserToCompany>(() =>
      _i64.AssignUserToCompany(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i65.AssignUserToGroup>(() =>
      _i65.AssignUserToGroup(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i66.AuthenticationRepository>(
      () => _i67.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i23.NetworkInfo>(),
          ));
  gh.lazySingleton<_i68.AutoSignin>(() => _i68.AutoSignin(
      authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i69.CancelTask>(
      () => _i69.CancelTask(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i70.CancelWorkRequest>(() =>
      _i70.CancelWorkRequest(repository: gh<_i41.WorkRequestsRepository>()));
  gh.lazySingleton<_i71.CheckCodeAvailability>(
      () => _i71.CheckCodeAvailability(repository: gh<_i61.AssetRepository>()));
  gh.lazySingleton<_i72.CheckEmailVerification>(() =>
      _i72.CheckEmailVerification(
          authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i73.CheckListsRepository>(() =>
      _i74.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i75.CompanyManagementRepository>(
      () => _i76.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i77.CompanyRepository>(() => _i78.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i79.CompleteTask>(
      () => _i79.CompleteTask(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i80.DashboardAssetActionRepository>(() =>
      _i81.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i82.DashboardItemActionRepository>(() =>
      _i83.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i84.DeleteAsset>(
      () => _i84.DeleteAsset(repository: gh<_i61.AssetRepository>()));
  gh.lazySingleton<_i85.DeleteAssetAction>(() =>
      _i85.DeleteAssetAction(repository: gh<_i57.AssetActionRepository>()));
  gh.lazySingleton<_i86.DeleteAssetCategory>(() =>
      _i86.DeleteAssetCategory(repository: gh<_i59.AssetCategoryRepository>()));
  gh.lazySingleton<_i87.DeleteChecklist>(
      () => _i87.DeleteChecklist(repository: gh<_i73.CheckListsRepository>()));
  gh.lazySingleton<_i88.DeleteInstruction>(() =>
      _i88.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i89.DeleteInstructionCategory>(() =>
      _i89.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i90.DeleteItem>(
      () => _i90.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i91.DeleteItemAction>(
      () => _i91.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i92.DeleteItemCategory>(() =>
      _i92.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i93.DeleteItemPhoto>(
      () => _i93.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i94.DeleteTask>(
      () => _i94.DeleteTask(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i95.DeleteTaskAction>(
      () => _i95.DeleteTaskAction(repository: gh<_i25.TaskActionRepository>()));
  gh.lazySingleton<_i96.DeleteWorkRequest>(() =>
      _i96.DeleteWorkRequest(repository: gh<_i41.WorkRequestsRepository>()));
  gh.lazySingleton<_i97.FetchAllCompanies>(() => _i97.FetchAllCompanies(
      companyManagementRepository: gh<_i75.CompanyManagementRepository>()));
  gh.lazySingleton<_i98.FetchAllCompanyUsers>(() => _i98.FetchAllCompanyUsers(
      companyRepository: gh<_i77.CompanyRepository>()));
  gh.lazySingleton<_i99.FetchNewUsers>(() =>
      _i99.FetchNewUsers(companyRepository: gh<_i77.CompanyRepository>()));
  gh.lazySingleton<_i100.FetchSuspendedUsers>(() => _i100.FetchSuspendedUsers(
      companyRepository: gh<_i77.CompanyRepository>()));
  gh.lazySingleton<_i101.GetArchiveTasksStream>(
      () => _i101.GetArchiveTasksStream(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i102.GetArchiveWorkRequestsStream>(() =>
      _i102.GetArchiveWorkRequestsStream(
          repository: gh<_i41.WorkRequestsRepository>()));
  gh.lazySingleton<_i103.GetAssetActionsStream>(() =>
      _i103.GetAssetActionsStream(
          repository: gh<_i57.AssetActionRepository>()));
  gh.lazySingleton<_i104.GetAssetsCategoriesStream>(() =>
      _i104.GetAssetsCategoriesStream(
          repository: gh<_i59.AssetCategoryRepository>()));
  gh.lazySingleton<_i105.GetAssetsStream>(
      () => _i105.GetAssetsStream(repository: gh<_i61.AssetRepository>()));
  gh.lazySingleton<_i106.GetChecklistStream>(() =>
      _i106.GetChecklistStream(repository: gh<_i73.CheckListsRepository>()));
  gh.lazySingleton<_i107.GetCompanyById>(() =>
      _i107.GetCompanyById(companyRepository: gh<_i77.CompanyRepository>()));
  gh.lazySingleton<_i108.GetDashboardAssetActionsStream>(() =>
      _i108.GetDashboardAssetActionsStream(
          repository: gh<_i80.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i109.GetDashboardItemsActionsStream>(() =>
      _i109.GetDashboardItemsActionsStream(
          repository: gh<_i82.DashboardItemActionRepository>()));
  gh.lazySingleton<_i110.GetDashboardLastFiveAssetActionsStream>(() =>
      _i110.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i80.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i111.GetDashboardLastFiveItemsActionsStream>(() =>
      _i111.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i82.DashboardItemActionRepository>()));
  gh.lazySingleton<_i112.GetInstructionsCategoriesStream>(() =>
      _i112.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i113.GetInstructionsStream>(() =>
      _i113.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i114.GetItemsActionsStream>(() =>
      _i114.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i115.GetItemsCategoriesStream>(() =>
      _i115.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i116.GetItemsStream>(
      () => _i116.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i117.GetLastFiveAssetActionsStream>(() =>
      _i117.GetLastFiveAssetActionsStream(
          repository: gh<_i57.AssetActionRepository>()));
  gh.lazySingleton<_i118.GetLastFiveItemsActionsStream>(() =>
      _i118.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i119.GetLatestTaskActionsStream>(() =>
      _i119.GetLatestTaskActionsStream(
          repository: gh<_i25.TaskActionRepository>()));
  gh.lazySingleton<_i120.GetTaskActionsStream>(() =>
      _i120.GetTaskActionsStream(repository: gh<_i25.TaskActionRepository>()));
  gh.lazySingleton<_i121.GetTasksStream>(
      () => _i121.GetTasksStream(repository: gh<_i27.TaskRepository>()));
  gh.lazySingleton<_i122.GetUserById>(
      () => _i122.GetUserById(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i123.GetUserStreamById>(() => _i123.GetUserStreamById(
      userRepository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i124.GetWorkRequestsStream>(() =>
      _i124.GetWorkRequestsStream(
          repository: gh<_i41.WorkRequestsRepository>()));
  gh.lazySingleton<_i125.GroupLocalDataSource>(() =>
      _i125.GroupLocalDataSourceImpl(source: gh<_i24.SharedPreferences>()));
  gh.lazySingleton<_i126.GroupRepository>(() => _i127.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i125.GroupLocalDataSource>(),
      ));
  gh.factory<_i128.ItemActionBloc>(() => _i128.ItemActionBloc(
        getItemsActionsStream: gh<_i114.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i118.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i129.LocationLocalDataSource>(() =>
      _i129.LocationLocalDataSourceImpl(source: gh<_i24.SharedPreferences>()));
  gh.lazySingleton<_i130.LocationRepository>(() => _i131.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i129.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i132.MakeUserAdministrator>(() =>
      _i132.MakeUserAdministrator(
          repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i133.RejectUser>(
      () => _i133.RejectUser(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i134.ResetCompany>(
      () => _i134.ResetCompany(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i135.SendPasswordResetEmail>(() =>
      _i135.SendPasswordResetEmail(
          authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i136.SendVerificationEmail>(() =>
      _i136.SendVerificationEmail(
          authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i137.Signin>(() => _i137.Signin(
      authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i138.Signout>(() => _i138.Signout(
      authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i139.Signup>(() => _i139.Signup(
      authenticationRepository: gh<_i66.AuthenticationRepository>()));
  gh.lazySingleton<_i140.SuspendUser>(
      () => _i140.SuspendUser(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i141.TryToGetCachedGroups>(() =>
      _i141.TryToGetCachedGroups(groupRepository: gh<_i126.GroupRepository>()));
  gh.lazySingleton<_i142.TryToGetCachedLocation>(() =>
      _i142.TryToGetCachedLocation(
          locationRepository: gh<_i130.LocationRepository>()));
  gh.lazySingleton<_i143.UnassignGroupAdmin>(() =>
      _i143.UnassignGroupAdmin(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i144.UnassignUserFromGroup>(() =>
      _i144.UnassignUserFromGroup(
          repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i145.UnmakeUserAdministrator>(() =>
      _i145.UnmakeUserAdministrator(
          repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i146.UnsuspendUser>(
      () => _i146.UnsuspendUser(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i147.UpdateAsset>(
      () => _i147.UpdateAsset(repository: gh<_i61.AssetRepository>()));
  gh.lazySingleton<_i148.UpdateAssetAction>(() =>
      _i148.UpdateAssetAction(repository: gh<_i57.AssetActionRepository>()));
  gh.lazySingleton<_i149.UpdateAssetCategory>(() => _i149.UpdateAssetCategory(
      repository: gh<_i59.AssetCategoryRepository>()));
  gh.lazySingleton<_i150.UpdateChecklist>(
      () => _i150.UpdateChecklist(repository: gh<_i73.CheckListsRepository>()));
  gh.lazySingleton<_i151.UpdateCompany>(() => _i151.UpdateCompany(
      companyRepository: gh<_i75.CompanyManagementRepository>()));
  gh.lazySingleton<_i152.UpdateGroup>(
      () => _i152.UpdateGroup(groupRepository: gh<_i126.GroupRepository>()));
  gh.lazySingleton<_i153.UpdateLocation>(() =>
      _i153.UpdateLocation(locationRepository: gh<_i130.LocationRepository>()));
  gh.lazySingleton<_i154.UpdateUserData>(
      () => _i154.UpdateUserData(repository: gh<_i39.UserProfileRepository>()));
  gh.lazySingleton<_i155.UpdateWorkRequest>(() =>
      _i155.UpdateWorkRequest(repository: gh<_i41.WorkRequestsRepository>()));
  gh.factory<_i156.UserManagementBloc>(() => _i156.UserManagementBloc(
        approveUser: gh<_i55.ApproveUser>(),
        approvePassiveUser: gh<_i54.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i132.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i145.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i56.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i133.RejectUser>(),
        suspendUser: gh<_i140.SuspendUser>(),
        unsuspendUser: gh<_i146.UnsuspendUser>(),
        updateUserData: gh<_i154.UpdateUserData>(),
        assignUserToGroup: gh<_i65.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i144.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i63.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i143.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i52.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i157.AddAsset>(
      () => _i157.AddAsset(repository: gh<_i61.AssetRepository>()));
  gh.lazySingleton<_i158.AddAssetAction>(
      () => _i158.AddAssetAction(repository: gh<_i57.AssetActionRepository>()));
  gh.lazySingleton<_i159.AddAssetCategory>(() =>
      _i159.AddAssetCategory(repository: gh<_i59.AssetCategoryRepository>()));
  gh.lazySingleton<_i160.AddChecklist>(
      () => _i160.AddChecklist(repository: gh<_i73.CheckListsRepository>()));
  gh.lazySingleton<_i161.AddCompany>(() => _i161.AddCompany(
      companyManagementRepository: gh<_i75.CompanyManagementRepository>()));
  gh.lazySingleton<_i162.AddCompanyLogo>(() =>
      _i162.AddCompanyLogo(repository: gh<_i75.CompanyManagementRepository>()));
  gh.lazySingleton<_i163.AddGroup>(
      () => _i163.AddGroup(groupRepository: gh<_i126.GroupRepository>()));
  gh.lazySingleton<_i164.AddLocation>(() =>
      _i164.AddLocation(locationRepository: gh<_i130.LocationRepository>()));
  gh.factory<_i165.AssetActionBloc>(() => _i165.AssetActionBloc(
        getAssetActionsStream: gh<_i103.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i117.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i166.AssetInternalNumberCubit>(
      () => _i166.AssetInternalNumberCubit(gh<_i71.CheckCodeAvailability>()));
  gh.factory<_i167.AuthenticationBloc>(() => _i167.AuthenticationBloc(
        signin: gh<_i137.Signin>(),
        signup: gh<_i139.Signup>(),
        signout: gh<_i138.Signout>(),
        autoSignin: gh<_i68.AutoSignin>(),
        sendVerificationEmail: gh<_i136.SendVerificationEmail>(),
        checkEmailVerification: gh<_i72.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i135.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i168.CacheGroups>(
      () => _i168.CacheGroups(groupRepository: gh<_i126.GroupRepository>()));
  gh.lazySingleton<_i169.CacheLocation>(() =>
      _i169.CacheLocation(locationRepository: gh<_i130.LocationRepository>()));
  gh.lazySingleton<_i170.DeleteGroup>(
      () => _i170.DeleteGroup(groupRepository: gh<_i126.GroupRepository>()));
  gh.lazySingleton<_i171.DeleteLocation>(() =>
      _i171.DeleteLocation(locationRepository: gh<_i130.LocationRepository>()));
  gh.lazySingleton<_i172.FetchAllLocations>(() => _i172.FetchAllLocations(
      locationRepository: gh<_i130.LocationRepository>()));
  gh.lazySingleton<_i173.GetGroupsStream>(() =>
      _i173.GetGroupsStream(groupRepository: gh<_i126.GroupRepository>()));
  gh.factory<_i174.UserProfileBloc>(() => _i174.UserProfileBloc(
        authenticationBloc: gh<_i167.AuthenticationBloc>(),
        addUser: gh<_i51.AddUser>(),
        assignUserToCompany: gh<_i64.AssignUserToCompany>(),
        resetCompany: gh<_i134.ResetCompany>(),
        getUserById: gh<_i122.GetUserById>(),
        getUserStreamById: gh<_i123.GetUserStreamById>(),
        updateUserData: gh<_i154.UpdateUserData>(),
        addUserAvatar: gh<_i52.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i175.AssetCategoryBloc>(() => _i175.AssetCategoryBloc(
        userProfileBloc: gh<_i174.UserProfileBloc>(),
        getAssetsCategoriesStream: gh<_i104.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i176.AssetManagementBloc>(() => _i176.AssetManagementBloc(
        userProfileBloc: gh<_i174.UserProfileBloc>(),
        addAsset: gh<_i157.AddAsset>(),
        deleteAsset: gh<_i84.DeleteAsset>(),
        updateAsset: gh<_i147.UpdateAsset>(),
      ));
  gh.factory<_i177.CompanyManagementBloc>(() => _i177.CompanyManagementBloc(
        userProfileBloc: gh<_i174.UserProfileBloc>(),
        inputValidator: gh<_i8.InputValidator>(),
        addCompany: gh<_i161.AddCompany>(),
        fetchAllCompanies: gh<_i97.FetchAllCompanies>(),
        addCompanyLogo: gh<_i162.AddCompanyLogo>(),
        updateCompany: gh<_i151.UpdateCompany>(),
      ));
  gh.factory<_i178.CompanyProfileBloc>(() => _i178.CompanyProfileBloc(
        userProfileBloc: gh<_i174.UserProfileBloc>(),
        fetchAllCompanyUsers: gh<_i98.FetchAllCompanyUsers>(),
        getCompanyById: gh<_i107.GetCompanyById>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i179.GroupBloc>(() => _i179.GroupBloc(
        companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
        addGroup: gh<_i163.AddGroup>(),
        updateGroup: gh<_i152.UpdateGroup>(),
        deleteGroup: gh<_i170.DeleteGroup>(),
        getGroupsStream: gh<_i173.GetGroupsStream>(),
        cacheGroups: gh<_i168.CacheGroups>(),
        tryToGetCachedGroups: gh<_i141.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i180.InstructionCategoryBloc>(
      () => _i180.InstructionCategoryBloc(
            userProfileBloc: gh<_i174.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                gh<_i112.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i181.InstructionCategoryManagementBloc>(
      () => _i181.InstructionCategoryManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addInstructionCategory: gh<_i44.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i30.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i89.DeleteInstructionCategory>(),
          ));
  gh.factory<_i182.InstructionManagementBloc>(
      () => _i182.InstructionManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addInstruction: gh<_i43.AddInstruction>(),
            deleteInstruction: gh<_i88.DeleteInstruction>(),
            updateInstruction: gh<_i29.UpdateInstruction>(),
          ));
  gh.factory<_i183.ItemActionManagementBloc>(
      () => _i183.ItemActionManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addItemAction: gh<_i46.AddItemAction>(),
            updateItemAction: gh<_i32.UpdateItemAction>(),
            deleteItemAction: gh<_i91.DeleteItemAction>(),
            moveItemAction: gh<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i184.ItemCategoryBloc>(() => _i184.ItemCategoryBloc(
        userProfileBloc: gh<_i174.UserProfileBloc>(),
        getItemsCategoriesStream: gh<_i115.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i185.ItemCategoryManagementBloc>(
      () => _i185.ItemCategoryManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addItemCategory: gh<_i47.AddItemCategory>(),
            updateItemCategory: gh<_i33.UpdateItemCategory>(),
            deleteItemCategory: gh<_i92.DeleteItemCategory>(),
          ));
  gh.factory<_i186.ItemsManagementBloc>(() => _i186.ItemsManagementBloc(
        addItemPhoto: gh<_i48.AddItemPhoto>(),
        deleteItemPhoto: gh<_i93.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i34.UpdateItemPhoto>(),
        companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
        addItem: gh<_i45.AddItem>(),
        deleteItem: gh<_i90.DeleteItem>(),
        updateItem: gh<_i31.UpdateItem>(),
      ));
  gh.lazySingleton<_i187.LocationBloc>(() => _i187.LocationBloc(
        companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
        addLocation: gh<_i164.AddLocation>(),
        cacheLocation: gh<_i169.CacheLocation>(),
        deleteLocation: gh<_i171.DeleteLocation>(),
        fetchAllLocations: gh<_i172.FetchAllLocations>(),
        tryToGetCachedLocation: gh<_i142.TryToGetCachedLocation>(),
        updateLocation: gh<_i153.UpdateLocation>(),
      ));
  gh.factory<_i188.NewUsersBloc>(() => _i188.NewUsersBloc(
        gh<_i178.CompanyProfileBloc>(),
        gh<_i99.FetchNewUsers>(),
      ));
  gh.factory<_i189.SuspendedUsersBloc>(() => _i189.SuspendedUsersBloc(
        gh<_i178.CompanyProfileBloc>(),
        gh<_i100.FetchSuspendedUsers>(),
      ));
  gh.factory<_i190.TaskManagementBloc>(() => _i190.TaskManagementBloc(
        companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
        addTask: gh<_i49.AddTask>(),
        deleteTask: gh<_i94.DeleteTask>(),
        updateTask: gh<_i35.UpdateTask>(),
        cancelTask: gh<_i69.CancelTask>(),
      ));
  gh.factory<_i191.WorkRequestManagementBloc>(
      () => _i191.WorkRequestManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addWorkRequest: gh<_i53.AddWorkRequest>(),
            deleteWorkRequest: gh<_i96.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i155.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i70.CancelWorkRequest>(),
          ));
  gh.factory<_i192.AssetActionManagementBloc>(
      () => _i192.AssetActionManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addAssetAction: gh<_i158.AddAssetAction>(),
            updateAssetAction: gh<_i148.UpdateAssetAction>(),
            deleteAssetAction: gh<_i85.DeleteAssetAction>(),
          ));
  gh.factory<_i193.AssetCategoryManagementBloc>(
      () => _i193.AssetCategoryManagementBloc(
            companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
            addAssetCategory: gh<_i159.AddAssetCategory>(),
            updateAssetCategory: gh<_i149.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i86.DeleteAssetCategory>(),
          ));
  gh.factory<_i194.ChecklistBloc>(() => _i194.ChecklistBloc(
        companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
        getChecklistsStream: gh<_i106.GetChecklistStream>(),
      ));
  gh.factory<_i195.ChecklistManagementBloc>(() => _i195.ChecklistManagementBloc(
        companyProfileBloc: gh<_i178.CompanyProfileBloc>(),
        addChecklist: gh<_i160.AddChecklist>(),
        updateChecklist: gh<_i150.UpdateChecklist>(),
        deleteChecklist: gh<_i87.DeleteChecklist>(),
      ));
  gh.factory<_i196.FilterBloc>(() => _i196.FilterBloc(
        locationBloc: gh<_i187.LocationBloc>(),
        groupBloc: gh<_i179.GroupBloc>(),
        userProfileBloc: gh<_i174.UserProfileBloc>(),
      ));
  gh.factory<_i197.InstructionBloc>(() => _i197.InstructionBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getInstructionsStream: gh<_i113.GetInstructionsStream>(),
      ));
  gh.factory<_i198.ItemsBloc>(() => _i198.ItemsBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getChecklistsStream: gh<_i116.GetItemsStream>(),
      ));
  gh.factory<_i199.TaskArchiveBloc>(() => _i199.TaskArchiveBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getArchiveTasksStream: gh<_i101.GetArchiveTasksStream>(),
      ));
  gh.factory<_i200.TaskBloc>(() => _i200.TaskBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getTasksStream: gh<_i121.GetTasksStream>(),
      ));
  gh.factory<_i201.WorkRequestArchiveBloc>(() => _i201.WorkRequestArchiveBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getArchiveWorkRequestsStream: gh<_i102.GetArchiveWorkRequestsStream>(),
      ));
  gh.factory<_i202.WorkRequestBloc>(() => _i202.WorkRequestBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getWorkRequestsStream: gh<_i124.GetWorkRequestsStream>(),
      ));
  gh.factory<_i203.AssetBloc>(() => _i203.AssetBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getAssetsStream: gh<_i105.GetAssetsStream>(),
      ));
  gh.factory<_i204.DashboardAssetActionBloc>(
      () => _i204.DashboardAssetActionBloc(
            filterBloc: gh<_i196.FilterBloc>(),
            getDashboardAssetActionsStream:
                gh<_i108.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                gh<_i110.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i205.DashboardItemActionBloc>(() => _i205.DashboardItemActionBloc(
        filterBloc: gh<_i196.FilterBloc>(),
        getDashboardItemsActionsStream:
            gh<_i109.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            gh<_i111.GetDashboardLastFiveItemsActionsStream>(),
      ));
  gh.factory<_i206.TaskFilterBloc>(() => _i206.TaskFilterBloc(
        gh<_i174.UserProfileBloc>(),
        gh<_i200.TaskBloc>(),
        gh<_i202.WorkRequestBloc>(),
      ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i207.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i207.FirebaseStorageService {}

class _$SharedPreferencesService extends _i207.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i208.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i208.DataConnectionCheckerModule {}
