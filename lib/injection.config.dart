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
    as _i160;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i161;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i86;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i105;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i110;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i112;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i119;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i151;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i162;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i87;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i106;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i152;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i72;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i85;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i107;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i150;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i168;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i178;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i179;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i169;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i68;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i67;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i69;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i73;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i137;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i138;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i139;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i140;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i141;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i170;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i75;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i74;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i163;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i88;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i108;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i153;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i77;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i79;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i76;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i78;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i164;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i165;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i98;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i99;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i100;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i101;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i109;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i154;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i180;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i181;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i192;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i23;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i127;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i129;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i128;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i166;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i171;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i173;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i176;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i144;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i155;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i182;
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
    as _i118;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i92;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i111;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i113;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i116;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i120;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i22;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i33;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i93;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i117;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i34;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i32;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i35;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i130;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i186;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i187;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i188;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i189;
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
    as _i115;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i45;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i90;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i114;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i31;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i30;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i183;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i184;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i185;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i131;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i21;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i133;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i132;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i167;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i172;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i174;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i175;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i145;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i156;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i190;
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
    as _i123;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i36;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i51;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i96;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i121;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i122;
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
    as _i126;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i158;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i24;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i143;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i195;
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
    as _i124;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i125;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i134;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i135;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i136;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i142;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i146;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i147;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i148;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i157;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i159;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i177;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i213;
import 'features/core/injectable_modules/injectable_modules.dart' as _i212;

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
  gh.lazySingleton<_i108.GetChecklistStream>(() =>
      _i108.GetChecklistStream(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i109.GetCompanyById>(() =>
      _i109.GetCompanyById(companyRepository: gh<_i78.CompanyRepository>()));
  gh.lazySingleton<_i110.GetDashboardAssetActionsStream>(() =>
      _i110.GetDashboardAssetActionsStream(
          repository: gh<_i81.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i111.GetDashboardItemsActionsStream>(() =>
      _i111.GetDashboardItemsActionsStream(
          repository: gh<_i83.DashboardItemActionRepository>()));
  gh.lazySingleton<_i112.GetDashboardLastFiveAssetActionsStream>(() =>
      _i112.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i81.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i113.GetDashboardLastFiveItemsActionsStream>(() =>
      _i113.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i83.DashboardItemActionRepository>()));
  gh.lazySingleton<_i114.GetInstructionsCategoriesStream>(() =>
      _i114.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i115.GetInstructionsStream>(() =>
      _i115.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i116.GetItemsActionsStream>(() =>
      _i116.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i117.GetItemsCategoriesStream>(() =>
      _i117.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i118.GetItemsStream>(
      () => _i118.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i119.GetLastFiveAssetActionsStream>(() =>
      _i119.GetLastFiveAssetActionsStream(
          repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i120.GetLastFiveItemsActionsStream>(() =>
      _i120.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i121.GetLatestTaskActionsStream>(() =>
      _i121.GetLatestTaskActionsStream(
          repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i122.GetTaskActionsStream>(() =>
      _i122.GetTaskActionsStream(repository: gh<_i26.TaskActionRepository>()));
  gh.lazySingleton<_i123.GetTasksStream>(
      () => _i123.GetTasksStream(repository: gh<_i28.TaskRepository>()));
  gh.lazySingleton<_i124.GetUserById>(
      () => _i124.GetUserById(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i125.GetUserStreamById>(() => _i125.GetUserStreamById(
      userRepository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i126.GetWorkRequestsStream>(() =>
      _i126.GetWorkRequestsStream(
          repository: gh<_i42.WorkRequestsRepository>()));
  gh.lazySingleton<_i127.GroupLocalDataSource>(() =>
      _i127.GroupLocalDataSourceImpl(source: gh<_i25.SharedPreferences>()));
  gh.lazySingleton<_i128.GroupRepository>(() => _i129.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i127.GroupLocalDataSource>(),
      ));
  gh.factory<_i130.ItemActionBloc>(() => _i130.ItemActionBloc(
        getItemsActionsStream: gh<_i116.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i120.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i131.LocationLocalDataSource>(() =>
      _i131.LocationLocalDataSourceImpl(source: gh<_i25.SharedPreferences>()));
  gh.lazySingleton<_i132.LocationRepository>(() => _i133.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i131.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i21.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i134.MakeUserAdministrator>(() =>
      _i134.MakeUserAdministrator(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i135.RejectUser>(
      () => _i135.RejectUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i136.ResetCompany>(
      () => _i136.ResetCompany(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i137.SendPasswordResetEmail>(() =>
      _i137.SendPasswordResetEmail(
          authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i138.SendVerificationEmail>(() =>
      _i138.SendVerificationEmail(
          authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i139.Signin>(() => _i139.Signin(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i140.Signout>(() => _i140.Signout(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i141.Signup>(() => _i141.Signup(
      authenticationRepository: gh<_i67.AuthenticationRepository>()));
  gh.lazySingleton<_i142.SuspendUser>(
      () => _i142.SuspendUser(repository: gh<_i40.UserProfileRepository>()));
  gh.factory<_i143.TaskActionBloc>(() => _i143.TaskActionBloc(
      getTaskActionsStream: gh<_i122.GetTaskActionsStream>()));
  gh.lazySingleton<_i144.TryToGetCachedGroups>(() =>
      _i144.TryToGetCachedGroups(groupRepository: gh<_i128.GroupRepository>()));
  gh.lazySingleton<_i145.TryToGetCachedLocation>(() =>
      _i145.TryToGetCachedLocation(
          locationRepository: gh<_i132.LocationRepository>()));
  gh.lazySingleton<_i146.UnassignGroupAdmin>(() =>
      _i146.UnassignGroupAdmin(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i147.UnassignUserFromGroup>(() =>
      _i147.UnassignUserFromGroup(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i148.UnmakeUserAdministrator>(() =>
      _i148.UnmakeUserAdministrator(
          repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i149.UnsuspendUser>(
      () => _i149.UnsuspendUser(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i150.UpdateAsset>(
      () => _i150.UpdateAsset(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i151.UpdateAssetAction>(() =>
      _i151.UpdateAssetAction(repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i152.UpdateAssetCategory>(() => _i152.UpdateAssetCategory(
      repository: gh<_i60.AssetCategoryRepository>()));
  gh.lazySingleton<_i153.UpdateChecklist>(
      () => _i153.UpdateChecklist(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i154.UpdateCompany>(() => _i154.UpdateCompany(
      companyRepository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i155.UpdateGroup>(
      () => _i155.UpdateGroup(groupRepository: gh<_i128.GroupRepository>()));
  gh.lazySingleton<_i156.UpdateLocation>(() =>
      _i156.UpdateLocation(locationRepository: gh<_i132.LocationRepository>()));
  gh.lazySingleton<_i157.UpdateUserData>(
      () => _i157.UpdateUserData(repository: gh<_i40.UserProfileRepository>()));
  gh.lazySingleton<_i158.UpdateWorkRequest>(() =>
      _i158.UpdateWorkRequest(repository: gh<_i42.WorkRequestsRepository>()));
  gh.factory<_i159.UserManagementBloc>(() => _i159.UserManagementBloc(
        approveUser: gh<_i56.ApproveUser>(),
        approvePassiveUser: gh<_i55.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i134.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i148.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i57.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i135.RejectUser>(),
        suspendUser: gh<_i142.SuspendUser>(),
        unsuspendUser: gh<_i149.UnsuspendUser>(),
        updateUserData: gh<_i157.UpdateUserData>(),
        assignUserToGroup: gh<_i66.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i147.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i64.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i146.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i53.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i160.AddAsset>(
      () => _i160.AddAsset(repository: gh<_i62.AssetRepository>()));
  gh.lazySingleton<_i161.AddAssetAction>(
      () => _i161.AddAssetAction(repository: gh<_i58.AssetActionRepository>()));
  gh.lazySingleton<_i162.AddAssetCategory>(() =>
      _i162.AddAssetCategory(repository: gh<_i60.AssetCategoryRepository>()));
  gh.lazySingleton<_i163.AddChecklist>(
      () => _i163.AddChecklist(repository: gh<_i74.CheckListsRepository>()));
  gh.lazySingleton<_i164.AddCompany>(() => _i164.AddCompany(
      companyManagementRepository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i165.AddCompanyLogo>(() =>
      _i165.AddCompanyLogo(repository: gh<_i76.CompanyManagementRepository>()));
  gh.lazySingleton<_i166.AddGroup>(
      () => _i166.AddGroup(groupRepository: gh<_i128.GroupRepository>()));
  gh.lazySingleton<_i167.AddLocation>(() =>
      _i167.AddLocation(locationRepository: gh<_i132.LocationRepository>()));
  gh.factory<_i168.AssetActionBloc>(() => _i168.AssetActionBloc(
        getAssetActionsStream: gh<_i105.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i119.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i169.AssetInternalNumberCubit>(
      () => _i169.AssetInternalNumberCubit(gh<_i72.CheckCodeAvailability>()));
  gh.factory<_i170.AuthenticationBloc>(() => _i170.AuthenticationBloc(
        signin: gh<_i139.Signin>(),
        signup: gh<_i141.Signup>(),
        signout: gh<_i140.Signout>(),
        autoSignin: gh<_i69.AutoSignin>(),
        sendVerificationEmail: gh<_i138.SendVerificationEmail>(),
        checkEmailVerification: gh<_i73.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i137.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i171.CacheGroups>(
      () => _i171.CacheGroups(groupRepository: gh<_i128.GroupRepository>()));
  gh.lazySingleton<_i172.CacheLocation>(() =>
      _i172.CacheLocation(locationRepository: gh<_i132.LocationRepository>()));
  gh.lazySingleton<_i173.DeleteGroup>(
      () => _i173.DeleteGroup(groupRepository: gh<_i128.GroupRepository>()));
  gh.lazySingleton<_i174.DeleteLocation>(() =>
      _i174.DeleteLocation(locationRepository: gh<_i132.LocationRepository>()));
  gh.lazySingleton<_i175.FetchAllLocations>(() => _i175.FetchAllLocations(
      locationRepository: gh<_i132.LocationRepository>()));
  gh.lazySingleton<_i176.GetGroupsStream>(() =>
      _i176.GetGroupsStream(groupRepository: gh<_i128.GroupRepository>()));
  gh.factory<_i177.UserProfileBloc>(() => _i177.UserProfileBloc(
        authenticationBloc: gh<_i170.AuthenticationBloc>(),
        addUser: gh<_i52.AddUser>(),
        assignUserToCompany: gh<_i65.AssignUserToCompany>(),
        resetCompany: gh<_i136.ResetCompany>(),
        getUserById: gh<_i124.GetUserById>(),
        getUserStreamById: gh<_i125.GetUserStreamById>(),
        updateUserData: gh<_i157.UpdateUserData>(),
        addUserAvatar: gh<_i53.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i178.AssetCategoryBloc>(() => _i178.AssetCategoryBloc(
        userProfileBloc: gh<_i177.UserProfileBloc>(),
        getAssetsCategoriesStream: gh<_i106.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i179.AssetManagementBloc>(() => _i179.AssetManagementBloc(
        userProfileBloc: gh<_i177.UserProfileBloc>(),
        addAsset: gh<_i160.AddAsset>(),
        deleteAsset: gh<_i85.DeleteAsset>(),
        updateAsset: gh<_i150.UpdateAsset>(),
      ));
  gh.factory<_i180.CompanyManagementBloc>(() => _i180.CompanyManagementBloc(
        userProfileBloc: gh<_i177.UserProfileBloc>(),
        inputValidator: gh<_i8.InputValidator>(),
        addCompany: gh<_i164.AddCompany>(),
        fetchAllCompanies: gh<_i98.FetchAllCompanies>(),
        addCompanyLogo: gh<_i165.AddCompanyLogo>(),
        updateCompany: gh<_i154.UpdateCompany>(),
      ));
  gh.factory<_i181.CompanyProfileBloc>(() => _i181.CompanyProfileBloc(
        userProfileBloc: gh<_i177.UserProfileBloc>(),
        fetchAllCompanyUsers: gh<_i99.FetchAllCompanyUsers>(),
        getCompanyById: gh<_i109.GetCompanyById>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i182.GroupBloc>(() => _i182.GroupBloc(
        companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
        addGroup: gh<_i166.AddGroup>(),
        updateGroup: gh<_i155.UpdateGroup>(),
        deleteGroup: gh<_i173.DeleteGroup>(),
        getGroupsStream: gh<_i176.GetGroupsStream>(),
        cacheGroups: gh<_i171.CacheGroups>(),
        tryToGetCachedGroups: gh<_i144.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i183.InstructionCategoryBloc>(
      () => _i183.InstructionCategoryBloc(
            userProfileBloc: gh<_i177.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                gh<_i114.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i184.InstructionCategoryManagementBloc>(
      () => _i184.InstructionCategoryManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addInstructionCategory: gh<_i45.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i31.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i90.DeleteInstructionCategory>(),
          ));
  gh.factory<_i185.InstructionManagementBloc>(
      () => _i185.InstructionManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addInstruction: gh<_i44.AddInstruction>(),
            deleteInstruction: gh<_i89.DeleteInstruction>(),
            updateInstruction: gh<_i30.UpdateInstruction>(),
          ));
  gh.factory<_i186.ItemActionManagementBloc>(
      () => _i186.ItemActionManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addItemAction: gh<_i47.AddItemAction>(),
            updateItemAction: gh<_i33.UpdateItemAction>(),
            deleteItemAction: gh<_i92.DeleteItemAction>(),
            moveItemAction: gh<_i22.MoveItemAction>(),
          ));
  gh.lazySingleton<_i187.ItemCategoryBloc>(() => _i187.ItemCategoryBloc(
        userProfileBloc: gh<_i177.UserProfileBloc>(),
        getItemsCategoriesStream: gh<_i117.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i188.ItemCategoryManagementBloc>(
      () => _i188.ItemCategoryManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addItemCategory: gh<_i48.AddItemCategory>(),
            updateItemCategory: gh<_i34.UpdateItemCategory>(),
            deleteItemCategory: gh<_i93.DeleteItemCategory>(),
          ));
  gh.factory<_i189.ItemsManagementBloc>(() => _i189.ItemsManagementBloc(
        addItemPhoto: gh<_i49.AddItemPhoto>(),
        deleteItemPhoto: gh<_i94.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i35.UpdateItemPhoto>(),
        companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
        addItem: gh<_i46.AddItem>(),
        deleteItem: gh<_i91.DeleteItem>(),
        updateItem: gh<_i32.UpdateItem>(),
      ));
  gh.lazySingleton<_i190.LocationBloc>(() => _i190.LocationBloc(
        companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
        addLocation: gh<_i167.AddLocation>(),
        cacheLocation: gh<_i172.CacheLocation>(),
        deleteLocation: gh<_i174.DeleteLocation>(),
        fetchAllLocations: gh<_i175.FetchAllLocations>(),
        tryToGetCachedLocation: gh<_i145.TryToGetCachedLocation>(),
        updateLocation: gh<_i156.UpdateLocation>(),
      ));
  gh.factory<_i191.NewUsersBloc>(() => _i191.NewUsersBloc(
        gh<_i181.CompanyProfileBloc>(),
        gh<_i100.FetchNewUsers>(),
      ));
  gh.factory<_i192.SuspendedUsersBloc>(() => _i192.SuspendedUsersBloc(
        gh<_i181.CompanyProfileBloc>(),
        gh<_i101.FetchSuspendedUsers>(),
      ));
  gh.factory<_i193.TaskActionManagementBloc>(
      () => _i193.TaskActionManagementBloc(
            userProfileBloc: gh<_i177.UserProfileBloc>(),
            addTaskAction: gh<_i51.AddTaskAction>(),
            deleteTaskAction: gh<_i96.DeleteTaskAction>(),
            updateTaskAction: gh<_i37.UpdateTaskAction>(),
          ));
  gh.factory<_i194.TaskManagementBloc>(() => _i194.TaskManagementBloc(
        companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
        addTask: gh<_i50.AddTask>(),
        deleteTask: gh<_i95.DeleteTask>(),
        updateTask: gh<_i36.UpdateTask>(),
        cancelTask: gh<_i70.CancelTask>(),
      ));
  gh.factory<_i195.WorkRequestManagementBloc>(
      () => _i195.WorkRequestManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addWorkRequest: gh<_i54.AddWorkRequest>(),
            deleteWorkRequest: gh<_i97.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i158.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i71.CancelWorkRequest>(),
          ));
  gh.factory<_i196.AssetActionManagementBloc>(
      () => _i196.AssetActionManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addAssetAction: gh<_i161.AddAssetAction>(),
            updateAssetAction: gh<_i151.UpdateAssetAction>(),
            deleteAssetAction: gh<_i86.DeleteAssetAction>(),
          ));
  gh.factory<_i197.AssetCategoryManagementBloc>(
      () => _i197.AssetCategoryManagementBloc(
            companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
            addAssetCategory: gh<_i162.AddAssetCategory>(),
            updateAssetCategory: gh<_i152.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i87.DeleteAssetCategory>(),
          ));
  gh.factory<_i198.ChecklistBloc>(() => _i198.ChecklistBloc(
        companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
        getChecklistsStream: gh<_i108.GetChecklistStream>(),
      ));
  gh.factory<_i199.ChecklistManagementBloc>(() => _i199.ChecklistManagementBloc(
        companyProfileBloc: gh<_i181.CompanyProfileBloc>(),
        addChecklist: gh<_i163.AddChecklist>(),
        updateChecklist: gh<_i153.UpdateChecklist>(),
        deleteChecklist: gh<_i88.DeleteChecklist>(),
      ));
  gh.factory<_i200.FilterBloc>(() => _i200.FilterBloc(
        locationBloc: gh<_i190.LocationBloc>(),
        groupBloc: gh<_i182.GroupBloc>(),
        userProfileBloc: gh<_i177.UserProfileBloc>(),
      ));
  gh.factory<_i201.InstructionBloc>(() => _i201.InstructionBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getInstructionsStream: gh<_i115.GetInstructionsStream>(),
      ));
  gh.factory<_i202.ItemsBloc>(() => _i202.ItemsBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getChecklistsStream: gh<_i118.GetItemsStream>(),
      ));
  gh.factory<_i203.TaskArchiveBloc>(() => _i203.TaskArchiveBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getArchiveTasksStream: gh<_i103.GetArchiveTasksStream>(),
      ));
  gh.factory<_i204.TaskArchiveLatestBloc>(() => _i204.TaskArchiveLatestBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getArchiveLatestTasksStream: gh<_i102.GetArchiveLatestTasksStream>(),
      ));
  gh.factory<_i205.TaskBloc>(() => _i205.TaskBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getTasksStream: gh<_i123.GetTasksStream>(),
      ));
  gh.factory<_i206.WorkRequestArchiveBloc>(() => _i206.WorkRequestArchiveBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getArchiveWorkRequestsStream: gh<_i104.GetArchiveWorkRequestsStream>(),
      ));
  gh.factory<_i207.WorkRequestBloc>(() => _i207.WorkRequestBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getWorkRequestsStream: gh<_i126.GetWorkRequestsStream>(),
      ));
  gh.factory<_i208.AssetBloc>(() => _i208.AssetBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getAssetsStream: gh<_i107.GetAssetsStream>(),
      ));
  gh.factory<_i209.DashboardAssetActionBloc>(
      () => _i209.DashboardAssetActionBloc(
            filterBloc: gh<_i200.FilterBloc>(),
            getDashboardAssetActionsStream:
                gh<_i110.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                gh<_i112.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i210.DashboardItemActionBloc>(() => _i210.DashboardItemActionBloc(
        filterBloc: gh<_i200.FilterBloc>(),
        getDashboardItemsActionsStream:
            gh<_i111.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            gh<_i113.GetDashboardLastFiveItemsActionsStream>(),
      ));
  gh.factory<_i211.TaskFilterBloc>(() => _i211.TaskFilterBloc(
        gh<_i177.UserProfileBloc>(),
        gh<_i205.TaskBloc>(),
        gh<_i207.WorkRequestBloc>(),
      ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i212.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i212.FirebaseStorageService {}

class _$SharedPreferencesService extends _i212.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i213.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i213.DataConnectionCheckerModule {}
