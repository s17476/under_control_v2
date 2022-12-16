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
import 'package:shared_preferences/shared_preferences.dart' as _i25;
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i59;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i61;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i63;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i82;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i58;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i60;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i62;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i81;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i161;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i162;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i86;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i105;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i111;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i113;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i120;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i152;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i163;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i87;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i106;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i153;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i72;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i85;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i107;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i108;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i151;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i169;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i179;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i180;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i170;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i68;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i67;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i69;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i73;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i138;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i139;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i140;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i141;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i142;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i171;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i75;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i74;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i164;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i88;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i109;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i154;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i77;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i79;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i76;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i78;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i165;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i166;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i98;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i99;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i100;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i101;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i110;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i155;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i181;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i182;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i192;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i23;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i128;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i130;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i129;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i167;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i172;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i174;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i177;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i145;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i156;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i183;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i84;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i83;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i49;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i91;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i94;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i119;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i92;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i112;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i114;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i117;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i121;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i33;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i93;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i118;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i34;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i32;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i35;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i131;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i187;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i188;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i189;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i190;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i44;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i89;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i116;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i45;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i90;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i115;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i31;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i30;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i184;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i185;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i186;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i132;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i134;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i133;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i168;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i173;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i175;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i176;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i146;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i157;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i29;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i43;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i26;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i28;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i42;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i50;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i70;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i80;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i95;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i102;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i103;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i124;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i36;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i51;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i96;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i122;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i123;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i37;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i54;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i71;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i97;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i104;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i127;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i159;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i24;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i144;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i195;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i39;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i41;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i38;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i40;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i52;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i53;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i55;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i56;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i57;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i64;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i65;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i66;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i125;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i126;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i135;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i136;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i137;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i143;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i147;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i148;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i150;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i158;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i160;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i178;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i215;
import 'features/core/injectable_modules/injectable_modules.dart' as _i214;

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
  gh.factory<_i24.ReservedSparePartsBloc>(() => _i24.ReservedSparePartsBloc());
  await gh.factoryAsync<_i25.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i26.TaskActionRepository>(
      () => _i27.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i28.TaskRepository>(() => _i29.TaskRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i30.UpdateInstruction>(() =>
      _i30.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i31.UpdateInstructionCategory>(() =>
      _i31.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i32.UpdateItem>(
      () => _i32.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i33.UpdateItemAction>(
      () => _i33.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i34.UpdateItemCategory>(() =>
      _i34.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i35.UpdateItemPhoto>(
      () => _i35.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i36.UpdateTask>(
      () => _i36.UpdateTask(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i37.UpdateTaskAction>(
      () => _i37.UpdateTaskAction(repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i38.UserFilesRepository>(() =>
      _i39.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i40.UserProfileRepository>(() =>
      _i41.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i42.WorkRequestsRepository>(
      () => _i43.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i44.AddInstruction>(
      () => _i44.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i45.AddInstructionCategory>(() =>
      _i45.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i46.AddItem>(
      () => _i46.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i47.AddItemAction>(
      () => _i47.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i48.AddItemCategory>(() =>
      _i48.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i49.AddItemPhoto>(
      () => _i49.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i50.AddTask>(
      () => _i50.AddTask(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i51.AddTaskAction>(
      () => _i51.AddTaskAction(repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i52.AddUser>(
      () => _i52.AddUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i53.AddUserAvatar>(
      () => _i53.AddUserAvatar(repository: gh<_i38.UserFilesRepository>()));
  gh.lazySingleton<_i54.AddWorkRequest>(
      () => _i54.AddWorkRequest(repository: gh<_i42.WorkRequestsRepository>()));
  gh.lazySingleton<_i55.ApprovePassiveUser>(() =>
      _i55.ApprovePassiveUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i56.ApproveUser>(
      () => _i56.ApproveUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i57.ApproveUserAndMakeAdmin>(() =>
      _i57.ApproveUserAndMakeAdmin(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i58.AssetActionRepository>(() =>
      _i59.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i60.AssetCategoryRepository>(() =>
      _i61.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i62.AssetRepository>(() => _i63.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i64.AssignGroupAdmin>(() =>
      _i64.AssignGroupAdmin(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i65.AssignUserToCompany>(() =>
      _i65.AssignUserToCompany(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i66.AssignUserToGroup>(() =>
      _i66.AssignUserToGroup(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i67.AuthenticationRepository>(
      () => _i68.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i23.NetworkInfo>(),
          ));
  gh.lazySingleton<_i69.AutoSignin>(() => _i69.AutoSignin(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i70.CancelTask>(
      () => _i70.CancelTask(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i71.CancelWorkRequest>(() =>
      _i71.CancelWorkRequest(repository: gh<_i42.WorkRequestsRepository>()));
  gh.lazySingleton<_i72.CheckCodeAvailability>(
      () => _i72.CheckCodeAvailability(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i73.CheckEmailVerification>(() =>
      _i73.CheckEmailVerification(
          authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i74.CheckListsRepository>(() =>
      _i75.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i76.CompanyManagementRepository>(
      () => _i77.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i78.CompanyRepository>(() => _i79.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i80.CompleteTask>(
      () => _i80.CompleteTask(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i81.DashboardAssetActionRepository>(() =>
      _i82.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i83.DashboardItemActionRepository>(() =>
      _i84.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i85.DeleteAsset>(
      () => _i85.DeleteAsset(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i86.DeleteAssetAction>(() =>
      _i86.DeleteAssetAction(repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i87.DeleteAssetCategory>(() =>
      _i87.DeleteAssetCategory(repository: gh<_i60.AssetCategoryRepository>()));
  gh.lazySingleton<_i88.DeleteChecklist>(
      () => _i88.DeleteChecklist(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i89.DeleteInstruction>(() =>
      _i89.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i90.DeleteInstructionCategory>(() =>
      _i90.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i91.DeleteItem>(
      () => _i91.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i92.DeleteItemAction>(
      () => _i92.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i93.DeleteItemCategory>(() =>
      _i93.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i94.DeleteItemPhoto>(
      () => _i94.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i95.DeleteTask>(
      () => _i95.DeleteTask(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i96.DeleteTaskAction>(
      () => _i96.DeleteTaskAction(repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i97.DeleteWorkRequest>(() =>
      _i97.DeleteWorkRequest(repository: gh<_i42.WorkRequestsRepository>()));
  gh.lazySingleton<_i98.FetchAllCompanies>(() => _i98.FetchAllCompanies(
      companyManagementRepository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i99.FetchAllCompanyUsers>(() => _i99.FetchAllCompanyUsers(
      companyRepository: gh<_i78.CompanyRepository>()));
  gh.lazySingleton<_i100.FetchNewUsers>(() =>
      _i100.FetchNewUsers(companyRepository: gh<_i78.CompanyRepository>()));
  gh.lazySingleton<_i101.FetchSuspendedUsers>(() => _i101.FetchSuspendedUsers(
      companyRepository: gh<_i78.CompanyRepository>()));
  gh.lazySingleton<_i102.GetArchiveLatestTasksStream>(() =>
      _i102.GetArchiveLatestTasksStream(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i103.GetArchiveTasksStream>(
      () => _i103.GetArchiveTasksStream(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i104.GetArchiveWorkRequestsStream>(() =>
      _i104.GetArchiveWorkRequestsStream(
          repository: gh<_i42.WorkRequestsRepository>()));
  gh.lazySingleton<_i105.GetAssetActionsStream>(() =>
      _i105.GetAssetActionsStream(
          repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i106.GetAssetsCategoriesStream>(() =>
      _i106.GetAssetsCategoriesStream(
          repository: gh<_i60.AssetCategoryRepository>()));
  gh.lazySingleton<_i107.GetAssetsStream>(
      () => _i107.GetAssetsStream(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i108.GetAssetsStreamForParent>(() =>
      _i108.GetAssetsStreamForParent(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i109.GetChecklistStream>(() =>
      _i109.GetChecklistStream(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i110.GetCompanyById>(() =>
      _i110.GetCompanyById(companyRepository: gh<_i78.CompanyRepository>()));
  gh.lazySingleton<_i111.GetDashboardAssetActionsStream>(() =>
      _i111.GetDashboardAssetActionsStream(
          repository: gh<_i81.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i112.GetDashboardItemsActionsStream>(() =>
      _i112.GetDashboardItemsActionsStream(
          repository: gh<_i83.DashboardItemActionRepository>()));
  gh.lazySingleton<_i113.GetDashboardLastFiveAssetActionsStream>(() =>
      _i113.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i81.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i114.GetDashboardLastFiveItemsActionsStream>(() =>
      _i114.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i83.DashboardItemActionRepository>()));
  gh.lazySingleton<_i115.GetInstructionsCategoriesStream>(() =>
      _i115.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i116.GetInstructionsStream>(() =>
      _i116.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i117.GetItemsActionsStream>(() =>
      _i117.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i118.GetItemsCategoriesStream>(() =>
      _i118.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i119.GetItemsStream>(
      () => _i119.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i120.GetLastFiveAssetActionsStream>(() =>
      _i120.GetLastFiveAssetActionsStream(
          repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i121.GetLastFiveItemsActionsStream>(() =>
      _i121.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i122.GetLatestTaskActionsStream>(() =>
      _i122.GetLatestTaskActionsStream(
          repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i123.GetTaskActionsStream>(() =>
      _i123.GetTaskActionsStream(repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i124.GetTasksStream>(
      () => _i124.GetTasksStream(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i125.GetUserById>(
      () => _i125.GetUserById(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i126.GetUserStreamById>(() => _i126.GetUserStreamById(
      userRepository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i127.GetWorkRequestsStream>(() =>
      _i127.GetWorkRequestsStream(
          repository: gh<_i42.WorkRequestsRepository>()));
  gh.lazySingleton<_i128.GroupLocalDataSource>(() =>
      _i128.GroupLocalDataSourceImpl(source: gh<_i25.SharedPreferences>()));
  gh.lazySingleton<_i129.GroupRepository>(() => _i130.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i128.GroupLocalDataSource>(),
      ));
  gh.factory<_i131.ItemActionBloc>(() => _i131.ItemActionBloc(
        getItemsActionsStream: gh<_i117.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i121.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i132.LocationLocalDataSource>(() =>
      _i132.LocationLocalDataSourceImpl(source: gh<_i25.SharedPreferences>()));
  gh.lazySingleton<_i133.LocationRepository>(() => _i134.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i132.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i135.MakeUserAdministrator>(() =>
      _i135.MakeUserAdministrator(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i136.RejectUser>(
      () => _i136.RejectUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i137.ResetCompany>(
      () => _i137.ResetCompany(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i138.SendPasswordResetEmail>(() =>
      _i138.SendPasswordResetEmail(
          authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i139.SendVerificationEmail>(() =>
      _i139.SendVerificationEmail(
          authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i140.Signin>(() => _i140.Signin(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i141.Signout>(() => _i141.Signout(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i142.Signup>(() => _i142.Signup(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i143.SuspendUser>(
      () => _i143.SuspendUser(repository: gh<_i40.UserProfileRepository>()));
  gh.factory<_i144.TaskActionBloc>(() => _i144.TaskActionBloc(
      getTaskActionsStream: gh<_i123.GetTaskActionsStream>()));
  gh.lazySingleton<_i145.TryToGetCachedGroups>(() =>
      _i145.TryToGetCachedGroups(groupRepository: gh<_i129.GroupRepository>()));
  gh.lazySingleton<_i146.TryToGetCachedLocation>(() =>
      _i146.TryToGetCachedLocation(
          locationRepository: gh<_i133.LocationRepository>()));
  gh.lazySingleton<_i147.UnassignGroupAdmin>(() =>
      _i147.UnassignGroupAdmin(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i148.UnassignUserFromGroup>(() =>
      _i148.UnassignUserFromGroup(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i149.UnmakeUserAdministrator>(() =>
      _i149.UnmakeUserAdministrator(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i150.UnsuspendUser>(
      () => _i150.UnsuspendUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i151.UpdateAsset>(
      () => _i151.UpdateAsset(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i152.UpdateAssetAction>(() =>
      _i152.UpdateAssetAction(repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i153.UpdateAssetCategory>(() => _i153.UpdateAssetCategory(
      repository: gh<_i60.AssetCategoryRepository>()));
  gh.lazySingleton<_i154.UpdateChecklist>(
      () => _i154.UpdateChecklist(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i155.UpdateCompany>(() => _i155.UpdateCompany(
      companyRepository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i156.UpdateGroup>(
      () => _i156.UpdateGroup(groupRepository: gh<_i129.GroupRepository>()));
  gh.lazySingleton<_i157.UpdateLocation>(() =>
      _i157.UpdateLocation(locationRepository: gh<_i133.LocationRepository>()));
  gh.lazySingleton<_i158.UpdateUserData>(
      () => _i158.UpdateUserData(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i159.UpdateWorkRequest>(() =>
      _i159.UpdateWorkRequest(repository: gh<_i42.WorkRequestsRepository>()));
  gh.factory<_i160.UserManagementBloc>(() => _i160.UserManagementBloc(
        approveUser: gh<_i56.ApproveUser>(),
        approvePassiveUser: gh<_i55.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i135.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i149.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i57.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i136.RejectUser>(),
        suspendUser: gh<_i143.SuspendUser>(),
        unsuspendUser: gh<_i150.UnsuspendUser>(),
        updateUserData: gh<_i158.UpdateUserData>(),
        assignUserToGroup: gh<_i66.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i148.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i64.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i147.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i53.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i161.AddAsset>(
      () => _i161.AddAsset(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i162.AddAssetAction>(
      () => _i162.AddAssetAction(repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i163.AddAssetCategory>(() =>
      _i163.AddAssetCategory(repository: gh<_i60.AssetCategoryRepository>()));
  gh.lazySingleton<_i164.AddChecklist>(
      () => _i164.AddChecklist(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i165.AddCompany>(() => _i165.AddCompany(
      companyManagementRepository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i166.AddCompanyLogo>(() =>
      _i166.AddCompanyLogo(repository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i167.AddGroup>(
      () => _i167.AddGroup(groupRepository: gh<_i129.GroupRepository>()));
  gh.lazySingleton<_i168.AddLocation>(() =>
      _i168.AddLocation(locationRepository: gh<_i133.LocationRepository>()));
  gh.factory<_i169.AssetActionBloc>(() => _i169.AssetActionBloc(
        getAssetActionsStream: gh<_i105.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i120.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i170.AssetInternalNumberCubit>(
      () => _i170.AssetInternalNumberCubit(gh<_i72.CheckCodeAvailability>()));
  gh.factory<_i171.AuthenticationBloc>(() => _i171.AuthenticationBloc(
        signin: gh<_i140.Signin>(),
        signup: gh<_i142.Signup>(),
        signout: gh<_i141.Signout>(),
        autoSignin: gh<_i69.AutoSignin>(),
        sendVerificationEmail: gh<_i139.SendVerificationEmail>(),
        checkEmailVerification: gh<_i73.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i138.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i172.CacheGroups>(
      () => _i172.CacheGroups(groupRepository: gh<_i129.GroupRepository>()));
  gh.lazySingleton<_i173.CacheLocation>(() =>
      _i173.CacheLocation(locationRepository: gh<_i133.LocationRepository>()));
  gh.lazySingleton<_i174.DeleteGroup>(
      () => _i174.DeleteGroup(groupRepository: gh<_i129.GroupRepository>()));
  gh.lazySingleton<_i175.DeleteLocation>(() =>
      _i175.DeleteLocation(locationRepository: gh<_i133.LocationRepository>()));
  gh.lazySingleton<_i176.FetchAllLocations>(() => _i176.FetchAllLocations(
      locationRepository: gh<_i133.LocationRepository>()));
  gh.lazySingleton<_i177.GetGroupsStream>(() =>
      _i177.GetGroupsStream(groupRepository: gh<_i129.GroupRepository>()));
  gh.factory<_i178.UserProfileBloc>(() => _i178.UserProfileBloc(
        authenticationBloc: gh<_i171.AuthenticationBloc>(),
        addUser: gh<_i52.AddUser>(),
        assignUserToCompany: gh<_i65.AssignUserToCompany>(),
        resetCompany: gh<_i137.ResetCompany>(),
        getUserById: gh<_i125.GetUserById>(),
        getUserStreamById: gh<_i126.GetUserStreamById>(),
        updateUserData: gh<_i158.UpdateUserData>(),
        addUserAvatar: gh<_i53.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i179.AssetCategoryBloc>(() => _i179.AssetCategoryBloc(
        userProfileBloc: gh<_i178.UserProfileBloc>(),
        getAssetsCategoriesStream: gh<_i106.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i180.AssetManagementBloc>(() => _i180.AssetManagementBloc(
        userProfileBloc: gh<_i178.UserProfileBloc>(),
        addAsset: gh<_i161.AddAsset>(),
        deleteAsset: gh<_i85.DeleteAsset>(),
        updateAsset: gh<_i151.UpdateAsset>(),
      ));
  gh.factory<_i181.CompanyManagementBloc>(() => _i181.CompanyManagementBloc(
        userProfileBloc: gh<_i178.UserProfileBloc>(),
        inputValidator: gh<_i8.InputValidator>(),
        addCompany: gh<_i165.AddCompany>(),
        fetchAllCompanies: gh<_i98.FetchAllCompanies>(),
        addCompanyLogo: gh<_i166.AddCompanyLogo>(),
        updateCompany: gh<_i155.UpdateCompany>(),
      ));
  gh.factory<_i182.CompanyProfileBloc>(() => _i182.CompanyProfileBloc(
        userProfileBloc: gh<_i178.UserProfileBloc>(),
        fetchAllCompanyUsers: gh<_i99.FetchAllCompanyUsers>(),
        getCompanyById: gh<_i110.GetCompanyById>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i183.GroupBloc>(() => _i183.GroupBloc(
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        addGroup: gh<_i167.AddGroup>(),
        updateGroup: gh<_i156.UpdateGroup>(),
        deleteGroup: gh<_i174.DeleteGroup>(),
        getGroupsStream: gh<_i177.GetGroupsStream>(),
        cacheGroups: gh<_i172.CacheGroups>(),
        tryToGetCachedGroups: gh<_i145.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i184.InstructionCategoryBloc>(
      () => _i184.InstructionCategoryBloc(
            userProfileBloc: gh<_i178.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                gh<_i115.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i185.InstructionCategoryManagementBloc>(
      () => _i185.InstructionCategoryManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addInstructionCategory: gh<_i45.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i31.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i90.DeleteInstructionCategory>(),
          ));
  gh.factory<_i186.InstructionManagementBloc>(
      () => _i186.InstructionManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addInstruction: gh<_i44.AddInstruction>(),
            deleteInstruction: gh<_i89.DeleteInstruction>(),
            updateInstruction: gh<_i30.UpdateInstruction>(),
          ));
  gh.factory<_i187.ItemActionManagementBloc>(
      () => _i187.ItemActionManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addItemAction: gh<_i47.AddItemAction>(),
            updateItemAction: gh<_i33.UpdateItemAction>(),
            deleteItemAction: gh<_i92.DeleteItemAction>(),
            moveItemAction: gh<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i188.ItemCategoryBloc>(() => _i188.ItemCategoryBloc(
        userProfileBloc: gh<_i178.UserProfileBloc>(),
        getItemsCategoriesStream: gh<_i118.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i189.ItemCategoryManagementBloc>(
      () => _i189.ItemCategoryManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addItemCategory: gh<_i48.AddItemCategory>(),
            updateItemCategory: gh<_i34.UpdateItemCategory>(),
            deleteItemCategory: gh<_i93.DeleteItemCategory>(),
          ));
  gh.factory<_i190.ItemsManagementBloc>(() => _i190.ItemsManagementBloc(
        addItemPhoto: gh<_i49.AddItemPhoto>(),
        deleteItemPhoto: gh<_i94.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i35.UpdateItemPhoto>(),
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        addItem: gh<_i46.AddItem>(),
        deleteItem: gh<_i91.DeleteItem>(),
        updateItem: gh<_i32.UpdateItem>(),
      ));
  gh.lazySingleton<_i191.LocationBloc>(() => _i191.LocationBloc(
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        addLocation: gh<_i168.AddLocation>(),
        cacheLocation: gh<_i173.CacheLocation>(),
        deleteLocation: gh<_i175.DeleteLocation>(),
        fetchAllLocations: gh<_i176.FetchAllLocations>(),
        tryToGetCachedLocation: gh<_i146.TryToGetCachedLocation>(),
        updateLocation: gh<_i157.UpdateLocation>(),
      ));
  gh.factory<_i192.NewUsersBloc>(() => _i192.NewUsersBloc(
        gh<_i182.CompanyProfileBloc>(),
        gh<_i100.FetchNewUsers>(),
      ));
  gh.factory<_i193.SuspendedUsersBloc>(() => _i193.SuspendedUsersBloc(
        gh<_i182.CompanyProfileBloc>(),
        gh<_i101.FetchSuspendedUsers>(),
      ));
  gh.factory<_i194.TaskActionManagementBloc>(
      () => _i194.TaskActionManagementBloc(
            userProfileBloc: gh<_i178.UserProfileBloc>(),
            addTaskAction: gh<_i51.AddTaskAction>(),
            deleteTaskAction: gh<_i96.DeleteTaskAction>(),
            updateTaskAction: gh<_i37.UpdateTaskAction>(),
          ));
  gh.factory<_i195.TaskManagementBloc>(() => _i195.TaskManagementBloc(
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        addTask: gh<_i50.AddTask>(),
        deleteTask: gh<_i95.DeleteTask>(),
        updateTask: gh<_i36.UpdateTask>(),
        cancelTask: gh<_i70.CancelTask>(),
      ));
  gh.factory<_i196.WorkRequestManagementBloc>(
      () => _i196.WorkRequestManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addWorkRequest: gh<_i54.AddWorkRequest>(),
            deleteWorkRequest: gh<_i97.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i159.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i71.CancelWorkRequest>(),
          ));
  gh.factory<_i197.AssetActionManagementBloc>(
      () => _i197.AssetActionManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addAssetAction: gh<_i162.AddAssetAction>(),
            updateAssetAction: gh<_i152.UpdateAssetAction>(),
            deleteAssetAction: gh<_i86.DeleteAssetAction>(),
          ));
  gh.factory<_i198.AssetCategoryManagementBloc>(
      () => _i198.AssetCategoryManagementBloc(
            companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
            addAssetCategory: gh<_i163.AddAssetCategory>(),
            updateAssetCategory: gh<_i153.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i87.DeleteAssetCategory>(),
          ));
  gh.factory<_i199.AssetPartsBloc>(() => _i199.AssetPartsBloc(
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        getAssetsStreamForParent: gh<_i108.GetAssetsStreamForParent>(),
      ));
  gh.factory<_i200.ChecklistBloc>(() => _i200.ChecklistBloc(
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        getChecklistsStream: gh<_i109.GetChecklistStream>(),
      ));
  gh.factory<_i201.ChecklistManagementBloc>(() => _i201.ChecklistManagementBloc(
        companyProfileBloc: gh<_i182.CompanyProfileBloc>(),
        addChecklist: gh<_i164.AddChecklist>(),
        updateChecklist: gh<_i154.UpdateChecklist>(),
        deleteChecklist: gh<_i88.DeleteChecklist>(),
      ));
  gh.factory<_i202.FilterBloc>(() => _i202.FilterBloc(
        locationBloc: gh<_i191.LocationBloc>(),
        groupBloc: gh<_i183.GroupBloc>(),
        userProfileBloc: gh<_i178.UserProfileBloc>(),
      ));
  gh.factory<_i203.InstructionBloc>(() => _i203.InstructionBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getInstructionsStream: gh<_i116.GetInstructionsStream>(),
      ));
  gh.factory<_i204.ItemsBloc>(() => _i204.ItemsBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getChecklistsStream: gh<_i119.GetItemsStream>(),
      ));
  gh.factory<_i205.TaskArchiveBloc>(() => _i205.TaskArchiveBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getArchiveTasksStream: gh<_i103.GetArchiveTasksStream>(),
      ));
  gh.factory<_i206.TaskArchiveLatestBloc>(() => _i206.TaskArchiveLatestBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getArchiveLatestTasksStream: gh<_i102.GetArchiveLatestTasksStream>(),
      ));
  gh.factory<_i207.TaskBloc>(() => _i207.TaskBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getTasksStream: gh<_i124.GetTasksStream>(),
      ));
  gh.factory<_i208.WorkRequestArchiveBloc>(() => _i208.WorkRequestArchiveBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getArchiveWorkRequestsStream: gh<_i104.GetArchiveWorkRequestsStream>(),
      ));
  gh.factory<_i209.WorkRequestBloc>(() => _i209.WorkRequestBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getWorkRequestsStream: gh<_i127.GetWorkRequestsStream>(),
      ));
  gh.factory<_i210.AssetBloc>(() => _i210.AssetBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getAssetsStream: gh<_i107.GetAssetsStream>(),
      ));
  gh.factory<_i211.DashboardAssetActionBloc>(
      () => _i211.DashboardAssetActionBloc(
            filterBloc: gh<_i202.FilterBloc>(),
            getDashboardAssetActionsStream:
                gh<_i111.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                gh<_i113.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i212.DashboardItemActionBloc>(() => _i212.DashboardItemActionBloc(
        filterBloc: gh<_i202.FilterBloc>(),
        getDashboardItemsActionsStream:
            gh<_i112.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            gh<_i114.GetDashboardLastFiveItemsActionsStream>(),
      ));
  gh.factory<_i213.TaskFilterBloc>(() => _i213.TaskFilterBloc(
        gh<_i178.UserProfileBloc>(),
        gh<_i207.TaskBloc>(),
        gh<_i209.WorkRequestBloc>(),
      ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i214.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i214.FirebaseStorageService {}

class _$SharedPreferencesService extends _i214.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i215.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i215.DataConnectionCheckerModule {}
