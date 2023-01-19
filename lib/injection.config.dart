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
import 'package:shared_preferences/shared_preferences.dart' as _i26;
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i62;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i64;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i66;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i85;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i61;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i63;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i65;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i84;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i167;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i168;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i89;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i108;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i117;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i119;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i126;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i158;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i169;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i90;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i109;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i159;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i75;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i88;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i110;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i111;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i157;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i175;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i186;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i187;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i188;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i189;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i190;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i176;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i71;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i70;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i72;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i76;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i144;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i145;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i146;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i147;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i148;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i177;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i78;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i77;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i170;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i91;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i114;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i160;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i192;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i80;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i82;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i79;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i81;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i171;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i172;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i101;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i102;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i103;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i104;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i115;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i161;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i24;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i46;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i45;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i112;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i113;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i116;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i134;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i136;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i135;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i173;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i178;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i180;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i183;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i151;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i162;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i195;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i87;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i86;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i49;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i52;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i94;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i97;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i125;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i50;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i95;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i118;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i120;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i123;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i127;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i34;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i51;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i96;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i124;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i35;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i33;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i36;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i137;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i47;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i92;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i122;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i48;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i93;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i121;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i32;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i31;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i138;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i140;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i139;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i174;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i179;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i181;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i182;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i152;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i163;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i21;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i28;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i30;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i44;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i27;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i29;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i43;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i53;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i73;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i83;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i98;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i105;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i106;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i130;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i37;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i54;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i99;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i128;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i129;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i57;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i74;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i100;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i107;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i133;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i165;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i25;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i150;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i185;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i40;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i42;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i39;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i41;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i55;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i56;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i58;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i59;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i60;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i67;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i68;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i69;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i131;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i132;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i141;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i142;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i143;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i153;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i154;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i155;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i156;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i164;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i166;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i184;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i222;
import 'features/core/injectable_modules/injectable_modules.dart' as _i221;

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
  gh.factory<_i21.LanguageCubit>(() => _i21.LanguageCubit());
  gh.lazySingleton<_i22.LocationRemoteDataSource>(() =>
      _i22.LocationRemoteDataSourceImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i23.MoveItemAction>(
      () => _i23.MoveItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i24.NetworkInfo>(() => _i24.NetworkInfoImpl(
      dataConnectionChecker: gh<_i3.DataConnectionChecker>()));
  gh.factory<_i25.ReservedSparePartsBloc>(() => _i25.ReservedSparePartsBloc());
  await gh.factoryAsync<_i26.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i27.TaskActionRepository>(
      () => _i28.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i29.TaskRepository>(() => _i30.TaskRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i31.UpdateInstruction>(() =>
      _i31.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i32.UpdateInstructionCategory>(() =>
      _i32.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i33.UpdateItem>(
      () => _i33.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i34.UpdateItemAction>(
      () => _i34.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i35.UpdateItemCategory>(() =>
      _i35.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i36.UpdateItemPhoto>(
      () => _i36.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i37.UpdateTask>(
      () => _i37.UpdateTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i38.UpdateTaskAction>(
      () => _i38.UpdateTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i39.UserFilesRepository>(() =>
      _i40.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i41.UserProfileRepository>(() =>
      _i42.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i43.WorkRequestsRepository>(
      () => _i44.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i45.WorkRequestsStatusRepository>(() =>
      _i46.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i47.AddInstruction>(
      () => _i47.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i48.AddInstructionCategory>(() =>
      _i48.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i49.AddItem>(
      () => _i49.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i50.AddItemAction>(
      () => _i50.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i51.AddItemCategory>(() =>
      _i51.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i52.AddItemPhoto>(
      () => _i52.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i53.AddTask>(
      () => _i53.AddTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i54.AddTaskAction>(
      () => _i54.AddTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i55.AddUser>(
      () => _i55.AddUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i56.AddUserAvatar>(
      () => _i56.AddUserAvatar(repository: gh<_i39.UserFilesRepository>()));
  gh.lazySingleton<_i57.AddWorkRequest>(
      () => _i57.AddWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i58.ApprovePassiveUser>(() =>
      _i58.ApprovePassiveUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i59.ApproveUser>(
      () => _i59.ApproveUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i60.ApproveUserAndMakeAdmin>(() =>
      _i60.ApproveUserAndMakeAdmin(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i61.AssetActionRepository>(() =>
      _i62.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i63.AssetCategoryRepository>(() =>
      _i64.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i65.AssetRepository>(() => _i66.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i67.AssignGroupAdmin>(() =>
      _i67.AssignGroupAdmin(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i68.AssignUserToCompany>(() =>
      _i68.AssignUserToCompany(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i69.AssignUserToGroup>(() =>
      _i69.AssignUserToGroup(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i70.AuthenticationRepository>(
      () => _i71.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i24.NetworkInfo>(),
          ));
  gh.lazySingleton<_i72.AutoSignin>(() => _i72.AutoSignin(
      authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i73.CancelTask>(
      () => _i73.CancelTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i74.CancelWorkRequest>(() =>
      _i74.CancelWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i75.CheckCodeAvailability>(
      () => _i75.CheckCodeAvailability(repository: gh<_i65.AssetRepository>()));
  gh.lazySingleton<_i76.CheckEmailVerification>(() =>
      _i76.CheckEmailVerification(
          authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i77.CheckListsRepository>(() =>
      _i78.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i79.CompanyManagementRepository>(
      () => _i80.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i81.CompanyRepository>(() => _i82.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i83.CompleteTask>(
      () => _i83.CompleteTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i84.DashboardAssetActionRepository>(() =>
      _i85.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i86.DashboardItemActionRepository>(() =>
      _i87.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i88.DeleteAsset>(
      () => _i88.DeleteAsset(repository: gh<_i65.AssetRepository>()));
  gh.lazySingleton<_i89.DeleteAssetAction>(() =>
      _i89.DeleteAssetAction(repository: gh<_i61.AssetActionRepository>()));
  gh.lazySingleton<_i90.DeleteAssetCategory>(() =>
      _i90.DeleteAssetCategory(repository: gh<_i63.AssetCategoryRepository>()));
  gh.lazySingleton<_i91.DeleteChecklist>(
      () => _i91.DeleteChecklist(repository: gh<_i77.CheckListsRepository>()));
  gh.lazySingleton<_i92.DeleteInstruction>(() =>
      _i92.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i93.DeleteInstructionCategory>(() =>
      _i93.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i94.DeleteItem>(
      () => _i94.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i95.DeleteItemAction>(
      () => _i95.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i96.DeleteItemCategory>(() =>
      _i96.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i97.DeleteItemPhoto>(
      () => _i97.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i98.DeleteTask>(
      () => _i98.DeleteTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i99.DeleteTaskAction>(
      () => _i99.DeleteTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i100.DeleteWorkRequest>(() =>
      _i100.DeleteWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i101.FetchAllCompanies>(() => _i101.FetchAllCompanies(
      companyManagementRepository: gh<_i79.CompanyManagementRepository>()));
  gh.lazySingleton<_i102.FetchAllCompanyUsers>(() => _i102.FetchAllCompanyUsers(
      companyRepository: gh<_i81.CompanyRepository>()));
  gh.lazySingleton<_i103.FetchNewUsers>(() =>
      _i103.FetchNewUsers(companyRepository: gh<_i81.CompanyRepository>()));
  gh.lazySingleton<_i104.FetchSuspendedUsers>(() => _i104.FetchSuspendedUsers(
      companyRepository: gh<_i81.CompanyRepository>()));
  gh.lazySingleton<_i105.GetArchiveLatestTasksStream>(() =>
      _i105.GetArchiveLatestTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i106.GetArchiveTasksStream>(
      () => _i106.GetArchiveTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i107.GetArchiveWorkRequestsStream>(() =>
      _i107.GetArchiveWorkRequestsStream(
          repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i108.GetAssetActionsStream>(() =>
      _i108.GetAssetActionsStream(
          repository: gh<_i61.AssetActionRepository>()));
  gh.lazySingleton<_i109.GetAssetsCategoriesStream>(() =>
      _i109.GetAssetsCategoriesStream(
          repository: gh<_i63.AssetCategoryRepository>()));
  gh.lazySingleton<_i110.GetAssetsStream>(
      () => _i110.GetAssetsStream(repository: gh<_i65.AssetRepository>()));
  gh.lazySingleton<_i111.GetAssetsStreamForParent>(() =>
      _i111.GetAssetsStreamForParent(repository: gh<_i65.AssetRepository>()));
  gh.lazySingleton<_i112.GetAwaitingWorkRequestsCount>(() =>
      _i112.GetAwaitingWorkRequestsCount(
          repository: gh<_i45.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i113.GetCancelledWorkRequestsCount>(() =>
      _i113.GetCancelledWorkRequestsCount(
          repository: gh<_i45.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i114.GetChecklistStream>(() =>
      _i114.GetChecklistStream(repository: gh<_i77.CheckListsRepository>()));
  gh.lazySingleton<_i115.GetCompanyById>(() =>
      _i115.GetCompanyById(companyRepository: gh<_i81.CompanyRepository>()));
  gh.lazySingleton<_i116.GetConvertedWorkRequestsCount>(() =>
      _i116.GetConvertedWorkRequestsCount(
          repository: gh<_i45.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i117.GetDashboardAssetActionsStream>(() =>
      _i117.GetDashboardAssetActionsStream(
          repository: gh<_i84.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i118.GetDashboardItemsActionsStream>(() =>
      _i118.GetDashboardItemsActionsStream(
          repository: gh<_i86.DashboardItemActionRepository>()));
  gh.lazySingleton<_i119.GetDashboardLastFiveAssetActionsStream>(() =>
      _i119.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i84.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i120.GetDashboardLastFiveItemsActionsStream>(() =>
      _i120.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i86.DashboardItemActionRepository>()));
  gh.lazySingleton<_i121.GetInstructionsCategoriesStream>(() =>
      _i121.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i122.GetInstructionsStream>(() =>
      _i122.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i123.GetItemsActionsStream>(() =>
      _i123.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i124.GetItemsCategoriesStream>(() =>
      _i124.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i125.GetItemsStream>(
      () => _i125.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i126.GetLastFiveAssetActionsStream>(() =>
      _i126.GetLastFiveAssetActionsStream(
          repository: gh<_i61.AssetActionRepository>()));
  gh.lazySingleton<_i127.GetLastFiveItemsActionsStream>(() =>
      _i127.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i128.GetLatestTaskActionsStream>(() =>
      _i128.GetLatestTaskActionsStream(
          repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i129.GetTaskActionsStream>(() =>
      _i129.GetTaskActionsStream(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i130.GetTasksStream>(
      () => _i130.GetTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i131.GetUserById>(
      () => _i131.GetUserById(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i132.GetUserStreamById>(() => _i132.GetUserStreamById(
      userRepository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i133.GetWorkRequestsStream>(() =>
      _i133.GetWorkRequestsStream(
          repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i134.GroupLocalDataSource>(() =>
      _i134.GroupLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i135.GroupRepository>(() => _i136.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i134.GroupLocalDataSource>(),
      ));
  gh.factory<_i137.ItemActionBloc>(() => _i137.ItemActionBloc(
        getItemsActionsStream: gh<_i123.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i127.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i138.LocationLocalDataSource>(() =>
      _i138.LocationLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i139.LocationRepository>(() => _i140.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i138.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i141.MakeUserAdministrator>(() =>
      _i141.MakeUserAdministrator(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i142.RejectUser>(
      () => _i142.RejectUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i143.ResetCompany>(
      () => _i143.ResetCompany(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i144.SendPasswordResetEmail>(() =>
      _i144.SendPasswordResetEmail(
          authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i145.SendVerificationEmail>(() =>
      _i145.SendVerificationEmail(
          authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i146.Signin>(() => _i146.Signin(
      authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i147.Signout>(() => _i147.Signout(
      authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i148.Signup>(() => _i148.Signup(
      authenticationRepository: gh<_i70.AuthenticationRepository>()));
  gh.lazySingleton<_i149.SuspendUser>(
      () => _i149.SuspendUser(repository: gh<_i41.UserProfileRepository>()));
  gh.factory<_i150.TaskActionBloc>(() => _i150.TaskActionBloc(
      getTaskActionsStream: gh<_i129.GetTaskActionsStream>()));
  gh.lazySingleton<_i151.TryToGetCachedGroups>(() =>
      _i151.TryToGetCachedGroups(groupRepository: gh<_i135.GroupRepository>()));
  gh.lazySingleton<_i152.TryToGetCachedLocation>(() =>
      _i152.TryToGetCachedLocation(
          locationRepository: gh<_i139.LocationRepository>()));
  gh.lazySingleton<_i153.UnassignGroupAdmin>(() =>
      _i153.UnassignGroupAdmin(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i154.UnassignUserFromGroup>(() =>
      _i154.UnassignUserFromGroup(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i155.UnmakeUserAdministrator>(() =>
      _i155.UnmakeUserAdministrator(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i156.UnsuspendUser>(
      () => _i156.UnsuspendUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i157.UpdateAsset>(
      () => _i157.UpdateAsset(repository: gh<_i65.AssetRepository>()));
  gh.lazySingleton<_i158.UpdateAssetAction>(() =>
      _i158.UpdateAssetAction(repository: gh<_i61.AssetActionRepository>()));
  gh.lazySingleton<_i159.UpdateAssetCategory>(() => _i159.UpdateAssetCategory(
      repository: gh<_i63.AssetCategoryRepository>()));
  gh.lazySingleton<_i160.UpdateChecklist>(
      () => _i160.UpdateChecklist(repository: gh<_i77.CheckListsRepository>()));
  gh.lazySingleton<_i161.UpdateCompany>(() => _i161.UpdateCompany(
      companyRepository: gh<_i79.CompanyManagementRepository>()));
  gh.lazySingleton<_i162.UpdateGroup>(
      () => _i162.UpdateGroup(groupRepository: gh<_i135.GroupRepository>()));
  gh.lazySingleton<_i163.UpdateLocation>(() =>
      _i163.UpdateLocation(locationRepository: gh<_i139.LocationRepository>()));
  gh.lazySingleton<_i164.UpdateUserData>(
      () => _i164.UpdateUserData(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i165.UpdateWorkRequest>(() =>
      _i165.UpdateWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.factory<_i166.UserManagementBloc>(() => _i166.UserManagementBloc(
        approveUser: gh<_i59.ApproveUser>(),
        approvePassiveUser: gh<_i58.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i141.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i155.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i60.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i142.RejectUser>(),
        suspendUser: gh<_i149.SuspendUser>(),
        unsuspendUser: gh<_i156.UnsuspendUser>(),
        updateUserData: gh<_i164.UpdateUserData>(),
        assignUserToGroup: gh<_i69.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i154.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i67.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i153.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i56.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i167.AddAsset>(
      () => _i167.AddAsset(repository: gh<_i65.AssetRepository>()));
  gh.lazySingleton<_i168.AddAssetAction>(
      () => _i168.AddAssetAction(repository: gh<_i61.AssetActionRepository>()));
  gh.lazySingleton<_i169.AddAssetCategory>(() =>
      _i169.AddAssetCategory(repository: gh<_i63.AssetCategoryRepository>()));
  gh.lazySingleton<_i170.AddChecklist>(
      () => _i170.AddChecklist(repository: gh<_i77.CheckListsRepository>()));
  gh.lazySingleton<_i171.AddCompany>(() => _i171.AddCompany(
      companyManagementRepository: gh<_i79.CompanyManagementRepository>()));
  gh.lazySingleton<_i172.AddCompanyLogo>(() =>
      _i172.AddCompanyLogo(repository: gh<_i79.CompanyManagementRepository>()));
  gh.lazySingleton<_i173.AddGroup>(
      () => _i173.AddGroup(groupRepository: gh<_i135.GroupRepository>()));
  gh.lazySingleton<_i174.AddLocation>(() =>
      _i174.AddLocation(locationRepository: gh<_i139.LocationRepository>()));
  gh.factory<_i175.AssetActionBloc>(() => _i175.AssetActionBloc(
        getAssetActionsStream: gh<_i108.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i126.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i176.AssetInternalNumberCubit>(
      () => _i176.AssetInternalNumberCubit(gh<_i75.CheckCodeAvailability>()));
  gh.lazySingleton<_i177.AuthenticationBloc>(() => _i177.AuthenticationBloc(
        signin: gh<_i146.Signin>(),
        signup: gh<_i148.Signup>(),
        signout: gh<_i147.Signout>(),
        autoSignin: gh<_i72.AutoSignin>(),
        sendVerificationEmail: gh<_i145.SendVerificationEmail>(),
        checkEmailVerification: gh<_i76.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i144.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i178.CacheGroups>(
      () => _i178.CacheGroups(groupRepository: gh<_i135.GroupRepository>()));
  gh.lazySingleton<_i179.CacheLocation>(() =>
      _i179.CacheLocation(locationRepository: gh<_i139.LocationRepository>()));
  gh.lazySingleton<_i180.DeleteGroup>(
      () => _i180.DeleteGroup(groupRepository: gh<_i135.GroupRepository>()));
  gh.lazySingleton<_i181.DeleteLocation>(() =>
      _i181.DeleteLocation(locationRepository: gh<_i139.LocationRepository>()));
  gh.lazySingleton<_i182.FetchAllLocations>(() => _i182.FetchAllLocations(
      locationRepository: gh<_i139.LocationRepository>()));
  gh.lazySingleton<_i183.GetGroupsStream>(() =>
      _i183.GetGroupsStream(groupRepository: gh<_i135.GroupRepository>()));
  gh.lazySingleton<_i184.UserProfileBloc>(() => _i184.UserProfileBloc(
        authenticationBloc: gh<_i177.AuthenticationBloc>(),
        addUser: gh<_i55.AddUser>(),
        assignUserToCompany: gh<_i68.AssignUserToCompany>(),
        resetCompany: gh<_i143.ResetCompany>(),
        getUserById: gh<_i131.GetUserById>(),
        getUserStreamById: gh<_i132.GetUserStreamById>(),
        updateUserData: gh<_i164.UpdateUserData>(),
        addUserAvatar: gh<_i56.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.factory<_i185.WorkRequestManagementBloc>(
      () => _i185.WorkRequestManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addWorkRequest: gh<_i57.AddWorkRequest>(),
            deleteWorkRequest: gh<_i100.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i165.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i74.CancelWorkRequest>(),
          ));
  gh.factory<_i186.AssetActionManagementBloc>(
      () => _i186.AssetActionManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addAssetAction: gh<_i168.AddAssetAction>(),
            updateAssetAction: gh<_i158.UpdateAssetAction>(),
            deleteAssetAction: gh<_i89.DeleteAssetAction>(),
          ));
  gh.singleton<_i187.AssetCategoryBloc>(_i187.AssetCategoryBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i109.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i188.AssetCategoryManagementBloc>(
      () => _i188.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addAssetCategory: gh<_i169.AddAssetCategory>(),
            updateAssetCategory: gh<_i159.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i90.DeleteAssetCategory>(),
          ));
  gh.factory<_i189.AssetManagementBloc>(() => _i189.AssetManagementBloc(
        userProfileBloc: gh<_i184.UserProfileBloc>(),
        addAsset: gh<_i167.AddAsset>(),
        deleteAsset: gh<_i88.DeleteAsset>(),
        updateAsset: gh<_i157.UpdateAsset>(),
      ));
  gh.factory<_i190.AssetPartsBloc>(() => _i190.AssetPartsBloc(
        userProfileBloc: gh<_i184.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i111.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i191.ChecklistBloc>(_i191.ChecklistBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    getChecklistsStream: gh<_i114.GetChecklistStream>(),
  ));
  gh.factory<_i192.ChecklistManagementBloc>(() => _i192.ChecklistManagementBloc(
        userProfileBloc: gh<_i184.UserProfileBloc>(),
        addChecklist: gh<_i170.AddChecklist>(),
        updateChecklist: gh<_i160.UpdateChecklist>(),
        deleteChecklist: gh<_i91.DeleteChecklist>(),
      ));
  gh.singleton<_i193.CompanyManagementBloc>(_i193.CompanyManagementBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    inputValidator: gh<_i8.InputValidator>(),
    addCompany: gh<_i171.AddCompany>(),
    fetchAllCompanies: gh<_i101.FetchAllCompanies>(),
    addCompanyLogo: gh<_i172.AddCompanyLogo>(),
    updateCompany: gh<_i161.UpdateCompany>(),
  ));
  gh.singleton<_i194.CompanyProfileBloc>(_i194.CompanyProfileBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i102.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i115.GetCompanyById>(),
    inputValidator: gh<_i8.InputValidator>(),
  ));
  gh.singleton<_i195.GroupBloc>(_i195.GroupBloc(
    companyProfileBloc: gh<_i194.CompanyProfileBloc>(),
    addGroup: gh<_i173.AddGroup>(),
    updateGroup: gh<_i162.UpdateGroup>(),
    deleteGroup: gh<_i180.DeleteGroup>(),
    getGroupsStream: gh<_i183.GetGroupsStream>(),
    cacheGroups: gh<_i178.CacheGroups>(),
    tryToGetCachedGroups: gh<_i151.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i196.InstructionCategoryBloc>(_i196.InstructionCategoryBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i121.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i197.InstructionCategoryManagementBloc>(
      () => _i197.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addInstructionCategory: gh<_i48.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i32.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i93.DeleteInstructionCategory>(),
          ));
  gh.factory<_i198.InstructionManagementBloc>(
      () => _i198.InstructionManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addInstruction: gh<_i47.AddInstruction>(),
            deleteInstruction: gh<_i92.DeleteInstruction>(),
            updateInstruction: gh<_i31.UpdateInstruction>(),
          ));
  gh.factory<_i199.ItemActionManagementBloc>(
      () => _i199.ItemActionManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addItemAction: gh<_i50.AddItemAction>(),
            updateItemAction: gh<_i34.UpdateItemAction>(),
            deleteItemAction: gh<_i95.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.singleton<_i200.ItemCategoryBloc>(_i200.ItemCategoryBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i124.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i201.ItemCategoryManagementBloc>(
      () => _i201.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addItemCategory: gh<_i51.AddItemCategory>(),
            updateItemCategory: gh<_i35.UpdateItemCategory>(),
            deleteItemCategory: gh<_i96.DeleteItemCategory>(),
          ));
  gh.factory<_i202.ItemsManagementBloc>(() => _i202.ItemsManagementBloc(
        addItemPhoto: gh<_i52.AddItemPhoto>(),
        deleteItemPhoto: gh<_i97.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i36.UpdateItemPhoto>(),
        userProfileBloc: gh<_i184.UserProfileBloc>(),
        addItem: gh<_i49.AddItem>(),
        deleteItem: gh<_i94.DeleteItem>(),
        updateItem: gh<_i33.UpdateItem>(),
      ));
  gh.singleton<_i203.LocationBloc>(_i203.LocationBloc(
    userProfileBloc: gh<_i184.UserProfileBloc>(),
    addLocation: gh<_i174.AddLocation>(),
    cacheLocation: gh<_i179.CacheLocation>(),
    deleteLocation: gh<_i181.DeleteLocation>(),
    fetchAllLocations: gh<_i182.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i152.TryToGetCachedLocation>(),
    updateLocation: gh<_i163.UpdateLocation>(),
  ));
  gh.singleton<_i204.NewUsersBloc>(_i204.NewUsersBloc(
    gh<_i194.CompanyProfileBloc>(),
    gh<_i103.FetchNewUsers>(),
  ));
  gh.singleton<_i205.SuspendedUsersBloc>(_i205.SuspendedUsersBloc(
    gh<_i194.CompanyProfileBloc>(),
    gh<_i104.FetchSuspendedUsers>(),
  ));
  gh.factory<_i206.TaskActionManagementBloc>(
      () => _i206.TaskActionManagementBloc(
            userProfileBloc: gh<_i184.UserProfileBloc>(),
            addTaskAction: gh<_i54.AddTaskAction>(),
            deleteTaskAction: gh<_i99.DeleteTaskAction>(),
            updateTaskAction: gh<_i38.UpdateTaskAction>(),
          ));
  gh.factory<_i207.TaskManagementBloc>(() => _i207.TaskManagementBloc(
        userProfileBloc: gh<_i184.UserProfileBloc>(),
        addTask: gh<_i53.AddTask>(),
        deleteTask: gh<_i98.DeleteTask>(),
        updateTask: gh<_i37.UpdateTask>(),
        cancelTask: gh<_i73.CancelTask>(),
        completeTask: gh<_i83.CompleteTask>(),
      ));
  gh.singleton<_i208.FilterBloc>(_i208.FilterBloc(
    locationBloc: gh<_i203.LocationBloc>(),
    groupBloc: gh<_i195.GroupBloc>(),
    userProfileBloc: gh<_i184.UserProfileBloc>(),
  ));
  gh.singleton<_i209.InstructionBloc>(_i209.InstructionBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getInstructionsStream: gh<_i122.GetInstructionsStream>(),
  ));
  gh.singleton<_i210.ItemsBloc>(_i210.ItemsBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getChecklistsStream: gh<_i125.GetItemsStream>(),
  ));
  gh.singleton<_i211.TaskArchiveBloc>(_i211.TaskArchiveBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getArchiveTasksStream: gh<_i106.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i212.TaskArchiveLatestBloc>(_i212.TaskArchiveLatestBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i105.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i213.TaskBloc>(_i213.TaskBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getTasksStream: gh<_i130.GetTasksStream>(),
  ));
  gh.singleton<_i214.WorkRequestArchiveBloc>(_i214.WorkRequestArchiveBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i107.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i215.WorkRequestBloc>(_i215.WorkRequestBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getWorkRequestsStream: gh<_i133.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i216.WorkRequestsStatusBloc>(_i216.WorkRequestsStatusBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i112.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i116.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i113.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i217.AssetBloc>(_i217.AssetBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getAssetsStream: gh<_i110.GetAssetsStream>(),
  ));
  gh.singleton<_i218.DashboardAssetActionBloc>(_i218.DashboardAssetActionBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i117.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i119.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i219.DashboardItemActionBloc>(_i219.DashboardItemActionBloc(
    filterBloc: gh<_i208.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i118.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i120.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i220.TaskFilterBloc>(_i220.TaskFilterBloc(
    gh<_i184.UserProfileBloc>(),
    gh<_i213.TaskBloc>(),
    gh<_i215.WorkRequestBloc>(),
  ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i221.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i221.FirebaseStorageService {}

class _$SharedPreferencesService extends _i221.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i222.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i222.DataConnectionCheckerModule {}
