// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart'
    as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_messaging/firebase_messaging.dart' as _i6;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i33;
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i76;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i78;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i80;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i99;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i75;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i77;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i79;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i98;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i184;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i185;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i103;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i123;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i132;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i134;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i141;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i175;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i186;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i104;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i124;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i176;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i89;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i102;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i125;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i126;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i174;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i241;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i242;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i192;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i85;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i84;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i86;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i90;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i161;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i162;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i163;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i164;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i165;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i92;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i91;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i187;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i105;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i129;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i177;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i94;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i96;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i93;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i95;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i188;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i189;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i116;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i117;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i118;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i119;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i130;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i178;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i25;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i9;
import 'package:under_control_v2/features/dashboard/data/repositories/task_action_status_repository_impl.dart'
    as _i37;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i59;
import 'package:under_control_v2/features/dashboard/domain/repositories/task_action_status_repository.dart'
    as _i36;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i58;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i127;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i128;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i131;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i143;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i240;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i239;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i230;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i152;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i8;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i154;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i153;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i190;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i194;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i196;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i199;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i168;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i179;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i101;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i21;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i100;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i62;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i65;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i108;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i111;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i140;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i63;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i109;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i133;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i135;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i138;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i142;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i24;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i45;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i64;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i110;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i139;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i44;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i243;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i13;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i60;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i106;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i137;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i61;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i107;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i136;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i43;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i42;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i155;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i23;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i157;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i156;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i191;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i195;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i197;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i198;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i169;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i180;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart'
    as _i26;
import 'package:under_control_v2/features/notifications/domain/usecases/register_device_token.dart'
    as _i30;
import 'package:under_control_v2/features/notifications/domain/usecases/remove_device_token.dart'
    as _i31;
import 'package:under_control_v2/features/notifications/presentation/cubits/cubit/device_token_cubit.dart'
    as _i213;
import 'package:under_control_v2/features/settings/data/repositories/notification_settings_repository_impl.dart'
    as _i29;
import 'package:under_control_v2/features/settings/domain/repositories/notification_settings_repository.dart'
    as _i28;
import 'package:under_control_v2/features/settings/domain/usecases/get_notification_settings.dart'
    as _i145;
import 'package:under_control_v2/features/settings/domain/usecases/update_notification_settings.dart'
    as _i48;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i22;
import 'package:under_control_v2/features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart'
    as _i224;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i35;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i39;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i41;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i57;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i34;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i40;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i56;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i66;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i87;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i97;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i112;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i120;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i121;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i147;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i49;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i67;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i113;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i144;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i146;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i50;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i68;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i114;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i148;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i51;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i71;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i88;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i115;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i122;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i151;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i182;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i32;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i236;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i167;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i234;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i235;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i244;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i228;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i238;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i237;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i53;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i55;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i52;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i54;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i69;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i70;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i72;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i73;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i74;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i81;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i82;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i83;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i150;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i158;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i159;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i160;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i166;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i170;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i171;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i172;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i173;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i181;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i183;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i201;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i246;
import 'features/core/injectable_modules/injectable_modules.dart' as _i245;

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
  final firebaseMessagingService = _$FirebaseMessagingService();
  final firebaseStorageService = _$FirebaseStorageService();
  final sharedPreferencesService = _$SharedPreferencesService();
  gh.lazySingleton<_i3.DataConnectionChecker>(
      () => dataConnectionCheckerModule.httpClient);
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => firebaseFirestoreService.firebaseFirestore);
  gh.lazySingleton<_i6.FirebaseMessaging>(
      () => firebaseMessagingService.firebaseMessaging);
  gh.lazySingleton<_i7.FirebaseStorage>(
      () => firebaseStorageService.firebaseStorage);
  gh.lazySingleton<_i8.GroupRemoteDataSource>(() =>
      _i8.GroupRemoteDataSourceImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i9.InputValidator>(() => _i9.InputValidator());
  gh.lazySingleton<_i10.InstructionCategoryRepository>(() =>
      _i11.InstructionCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i12.InstructionRepository>(
      () => _i13.InstructionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i14.ItemActionRepository>(() =>
      _i15.ItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i16.ItemCategoryRepository>(() =>
      _i17.ItemCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i18.ItemFilesRepository>(() =>
      _i19.ItemFilesRepositoryImpl(firebaseStorage: gh<_i7.FirebaseStorage>()));
  gh.lazySingleton<_i20.ItemRepository>(() => _i21.ItemRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i7.FirebaseStorage>(),
      ));
  gh.factory<_i22.LanguageCubit>(() => _i22.LanguageCubit());
  gh.lazySingleton<_i23.LocationRemoteDataSource>(() =>
      _i23.LocationRemoteDataSourceImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i24.MoveItemAction>(
      () => _i24.MoveItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i25.NetworkInfo>(() => _i25.NetworkInfoImpl(
      dataConnectionChecker: gh<_i3.DataConnectionChecker>()));
  gh.lazySingleton<_i26.NotificationRepository>(
      () => _i27.NotificationRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseMessaging: gh<_i6.FirebaseMessaging>(),
          ));
  gh.lazySingleton<_i28.NotificationSettingsRepository>(() =>
      _i29.NotificationSettingsImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i30.RegisterDeviceToken>(() =>
      _i30.RegisterDeviceToken(repository: gh<_i26.NotificationRepository>()));
  gh.lazySingleton<_i31.RemoveDeviceToken>(() =>
      _i31.RemoveDeviceToken(repository: gh<_i26.NotificationRepository>()));
  gh.factory<_i32.ReservedSparePartsBloc>(() => _i32.ReservedSparePartsBloc());
  await gh.factoryAsync<_i33.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i34.TaskActionRepository>(
      () => _i35.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i36.TaskActionStatusRepository>(() =>
      _i37.TaskActionStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i38.TaskRepository>(() => _i39.TaskRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i7.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i40.TaskTemplatesRepository>(
      () => _i41.TaskTemplatesRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i42.UpdateInstruction>(() =>
      _i42.UpdateInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i43.UpdateInstructionCategory>(() =>
      _i43.UpdateInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i44.UpdateItem>(
      () => _i44.UpdateItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i45.UpdateItemAction>(
      () => _i45.UpdateItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i46.UpdateItemCategory>(() =>
      _i46.UpdateItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i47.UpdateItemPhoto>(
      () => _i47.UpdateItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i48.UpdateNotificationSettings>(() =>
      _i48.UpdateNotificationSettings(
          repository: gh<_i28.NotificationSettingsRepository>()));
  gh.lazySingleton<_i49.UpdateTask>(
      () => _i49.UpdateTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i50.UpdateTaskAction>(
      () => _i50.UpdateTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i51.UpdateTaskTemplate>(() =>
      _i51.UpdateTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i52.UserFilesRepository>(() =>
      _i53.UserFilesRepositoryImpl(firebaseStorage: gh<_i7.FirebaseStorage>()));
  gh.lazySingleton<_i54.UserProfileRepository>(() =>
      _i55.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i56.WorkRequestsRepository>(
      () => _i57.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i58.WorkRequestsStatusRepository>(() =>
      _i59.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i60.AddInstruction>(
      () => _i60.AddInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i61.AddInstructionCategory>(() =>
      _i61.AddInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i62.AddItem>(
      () => _i62.AddItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i63.AddItemAction>(
      () => _i63.AddItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i64.AddItemCategory>(() =>
      _i64.AddItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i65.AddItemPhoto>(
      () => _i65.AddItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i66.AddTask>(
      () => _i66.AddTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i67.AddTaskAction>(
      () => _i67.AddTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i68.AddTaskTemplate>(() =>
      _i68.AddTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i69.AddUser>(
      () => _i69.AddUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i70.AddUserAvatar>(
      () => _i70.AddUserAvatar(repository: gh<_i52.UserFilesRepository>()));
  gh.lazySingleton<_i71.AddWorkRequest>(
      () => _i71.AddWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i72.ApprovePassiveUser>(() =>
      _i72.ApprovePassiveUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i73.ApproveUser>(
      () => _i73.ApproveUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i74.ApproveUserAndMakeAdmin>(() =>
      _i74.ApproveUserAndMakeAdmin(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i75.AssetActionRepository>(() =>
      _i76.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i77.AssetCategoryRepository>(() =>
      _i78.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i79.AssetRepository>(() => _i80.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i7.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i81.AssignGroupAdmin>(() =>
      _i81.AssignGroupAdmin(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i82.AssignUserToCompany>(() =>
      _i82.AssignUserToCompany(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i83.AssignUserToGroup>(() =>
      _i83.AssignUserToGroup(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i84.AuthenticationRepository>(
      () => _i85.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i25.NetworkInfo>(),
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseMessaging: gh<_i6.FirebaseMessaging>(),
          ));
  gh.lazySingleton<_i86.AutoSignin>(() => _i86.AutoSignin(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i87.CancelTask>(
      () => _i87.CancelTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i88.CancelWorkRequest>(() =>
      _i88.CancelWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i89.CheckCodeAvailability>(
      () => _i89.CheckCodeAvailability(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i90.CheckEmailVerification>(() =>
      _i90.CheckEmailVerification(
          authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i91.CheckListsRepository>(() =>
      _i92.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i93.CompanyManagementRepository>(
      () => _i94.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i95.CompanyRepository>(() => _i96.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i97.CompleteTask>(
      () => _i97.CompleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i98.DashboardAssetActionRepository>(() =>
      _i99.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i100.DashboardItemActionRepository>(() =>
      _i101.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i102.DeleteAsset>(
      () => _i102.DeleteAsset(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i103.DeleteAssetAction>(() =>
      _i103.DeleteAssetAction(repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i104.DeleteAssetCategory>(() => _i104.DeleteAssetCategory(
      repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i105.DeleteChecklist>(
      () => _i105.DeleteChecklist(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i106.DeleteInstruction>(() =>
      _i106.DeleteInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i107.DeleteInstructionCategory>(() =>
      _i107.DeleteInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i108.DeleteItem>(
      () => _i108.DeleteItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i109.DeleteItemAction>(() =>
      _i109.DeleteItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i110.DeleteItemCategory>(() =>
      _i110.DeleteItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i111.DeleteItemPhoto>(
      () => _i111.DeleteItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i112.DeleteTask>(
      () => _i112.DeleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i113.DeleteTaskAction>(() =>
      _i113.DeleteTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i114.DeleteTaskTemplate>(() =>
      _i114.DeleteTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i115.DeleteWorkRequest>(() =>
      _i115.DeleteWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i116.FetchAllCompanies>(() => _i116.FetchAllCompanies(
      companyManagementRepository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i117.FetchAllCompanyUsers>(() => _i117.FetchAllCompanyUsers(
      companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i118.FetchNewUsers>(() =>
      _i118.FetchNewUsers(companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i119.FetchSuspendedUsers>(() => _i119.FetchSuspendedUsers(
      companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i120.GetArchiveLatestTasksStream>(() =>
      _i120.GetArchiveLatestTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i121.GetArchiveTasksStream>(
      () => _i121.GetArchiveTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i122.GetArchiveWorkRequestsStream>(() =>
      _i122.GetArchiveWorkRequestsStream(
          repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i123.GetAssetActionsStream>(() =>
      _i123.GetAssetActionsStream(
          repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i124.GetAssetsCategoriesStream>(() =>
      _i124.GetAssetsCategoriesStream(
          repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i125.GetAssetsStream>(
      () => _i125.GetAssetsStream(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i126.GetAssetsStreamForParent>(() =>
      _i126.GetAssetsStreamForParent(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i127.GetAwaitingWorkRequestsCount>(() =>
      _i127.GetAwaitingWorkRequestsCount(
          repository: gh<_i58.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i128.GetCancelledWorkRequestsCount>(() =>
      _i128.GetCancelledWorkRequestsCount(
          repository: gh<_i58.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i129.GetChecklistStream>(() =>
      _i129.GetChecklistStream(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i130.GetCompanyById>(() =>
      _i130.GetCompanyById(companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i131.GetConvertedWorkRequestsCount>(() =>
      _i131.GetConvertedWorkRequestsCount(
          repository: gh<_i58.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i132.GetDashboardAssetActionsStream>(() =>
      _i132.GetDashboardAssetActionsStream(
          repository: gh<_i98.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i133.GetDashboardItemsActionsStream>(() =>
      _i133.GetDashboardItemsActionsStream(
          repository: gh<_i100.DashboardItemActionRepository>()));
  gh.lazySingleton<_i134.GetDashboardLastFiveAssetActionsStream>(() =>
      _i134.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i98.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i135.GetDashboardLastFiveItemsActionsStream>(() =>
      _i135.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i100.DashboardItemActionRepository>()));
  gh.lazySingleton<_i136.GetInstructionsCategoriesStream>(() =>
      _i136.GetInstructionsCategoriesStream(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i137.GetInstructionsStream>(() =>
      _i137.GetInstructionsStream(
          repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i138.GetItemsActionsStream>(() =>
      _i138.GetItemsActionsStream(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i139.GetItemsCategoriesStream>(() =>
      _i139.GetItemsCategoriesStream(
          repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i140.GetItemsStream>(
      () => _i140.GetItemsStream(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i141.GetLastFiveAssetActionsStream>(() =>
      _i141.GetLastFiveAssetActionsStream(
          repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i142.GetLastFiveItemsActionsStream>(() =>
      _i142.GetLastFiveItemsActionsStream(
          repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i143.GetLatestTaskActions>(() => _i143.GetLatestTaskActions(
      repository: gh<_i36.TaskActionStatusRepository>()));
  gh.lazySingleton<_i144.GetLatestTaskActionsStream>(() =>
      _i144.GetLatestTaskActionsStream(
          repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i145.GetNotificationSettings>(() =>
      _i145.GetNotificationSettings(
          repository: gh<_i28.NotificationSettingsRepository>()));
  gh.lazySingleton<_i146.GetTaskActionsStream>(() =>
      _i146.GetTaskActionsStream(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i147.GetTasksStream>(
      () => _i147.GetTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i148.GetTasksTemplatesStream>(() =>
      _i148.GetTasksTemplatesStream(
          repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i149.GetUserById>(
      () => _i149.GetUserById(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i150.GetUserStreamById>(() => _i150.GetUserStreamById(
      userRepository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i151.GetWorkRequestsStream>(() =>
      _i151.GetWorkRequestsStream(
          repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i152.GroupLocalDataSource>(() =>
      _i152.GroupLocalDataSourceImpl(source: gh<_i33.SharedPreferences>()));
  gh.lazySingleton<_i153.GroupRepository>(() => _i154.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i8.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i152.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i155.LocationLocalDataSource>(() =>
      _i155.LocationLocalDataSourceImpl(source: gh<_i33.SharedPreferences>()));
  gh.lazySingleton<_i156.LocationRepository>(() => _i157.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i155.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i23.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i158.MakeUserAdministrator>(() =>
      _i158.MakeUserAdministrator(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i159.RejectUser>(
      () => _i159.RejectUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i160.ResetCompany>(
      () => _i160.ResetCompany(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i161.SendPasswordResetEmail>(() =>
      _i161.SendPasswordResetEmail(
          authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i162.SendVerificationEmail>(() =>
      _i162.SendVerificationEmail(
          authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i163.Signin>(() => _i163.Signin(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i164.Signout>(() => _i164.Signout(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i165.Signup>(() => _i165.Signup(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i166.SuspendUser>(
      () => _i166.SuspendUser(repository: gh<_i54.UserProfileRepository>()));
  gh.factory<_i167.TaskActionBloc>(() => _i167.TaskActionBloc(
      getTaskActionsStream: gh<_i146.GetTaskActionsStream>()));
  gh.lazySingleton<_i168.TryToGetCachedGroups>(() =>
      _i168.TryToGetCachedGroups(groupRepository: gh<_i153.GroupRepository>()));
  gh.lazySingleton<_i169.TryToGetCachedLocation>(() =>
      _i169.TryToGetCachedLocation(
          locationRepository: gh<_i156.LocationRepository>()));
  gh.lazySingleton<_i170.UnassignGroupAdmin>(() =>
      _i170.UnassignGroupAdmin(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i171.UnassignUserFromGroup>(() =>
      _i171.UnassignUserFromGroup(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i172.UnmakeUserAdministrator>(() =>
      _i172.UnmakeUserAdministrator(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i173.UnsuspendUser>(
      () => _i173.UnsuspendUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i174.UpdateAsset>(
      () => _i174.UpdateAsset(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i175.UpdateAssetAction>(() =>
      _i175.UpdateAssetAction(repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i176.UpdateAssetCategory>(() => _i176.UpdateAssetCategory(
      repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i177.UpdateChecklist>(
      () => _i177.UpdateChecklist(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i178.UpdateCompany>(() => _i178.UpdateCompany(
      companyRepository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i179.UpdateGroup>(
      () => _i179.UpdateGroup(groupRepository: gh<_i153.GroupRepository>()));
  gh.lazySingleton<_i180.UpdateLocation>(() =>
      _i180.UpdateLocation(locationRepository: gh<_i156.LocationRepository>()));
  gh.lazySingleton<_i181.UpdateUserData>(
      () => _i181.UpdateUserData(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i182.UpdateWorkRequest>(() =>
      _i182.UpdateWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.factory<_i183.UserManagementBloc>(() => _i183.UserManagementBloc(
        approveUser: gh<_i73.ApproveUser>(),
        approvePassiveUser: gh<_i72.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i158.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i172.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i74.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i159.RejectUser>(),
        suspendUser: gh<_i166.SuspendUser>(),
        unsuspendUser: gh<_i173.UnsuspendUser>(),
        updateUserData: gh<_i181.UpdateUserData>(),
        assignUserToGroup: gh<_i83.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i171.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i81.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i170.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i70.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i184.AddAsset>(
      () => _i184.AddAsset(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i185.AddAssetAction>(
      () => _i185.AddAssetAction(repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i186.AddAssetCategory>(() =>
      _i186.AddAssetCategory(repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i187.AddChecklist>(
      () => _i187.AddChecklist(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i188.AddCompany>(() => _i188.AddCompany(
      companyManagementRepository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i189.AddCompanyLogo>(() =>
      _i189.AddCompanyLogo(repository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i190.AddGroup>(
      () => _i190.AddGroup(groupRepository: gh<_i153.GroupRepository>()));
  gh.lazySingleton<_i191.AddLocation>(() =>
      _i191.AddLocation(locationRepository: gh<_i156.LocationRepository>()));
  gh.factory<_i192.AssetInternalNumberCubit>(
      () => _i192.AssetInternalNumberCubit(gh<_i89.CheckCodeAvailability>()));
  gh.lazySingleton<_i193.AuthenticationBloc>(() => _i193.AuthenticationBloc(
        signin: gh<_i163.Signin>(),
        signup: gh<_i165.Signup>(),
        signout: gh<_i164.Signout>(),
        autoSignin: gh<_i86.AutoSignin>(),
        sendVerificationEmail: gh<_i162.SendVerificationEmail>(),
        checkEmailVerification: gh<_i90.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i161.SendPasswordResetEmail>(),
        inputValidator: gh<_i9.InputValidator>(),
      ));
  gh.lazySingleton<_i194.CacheGroups>(
      () => _i194.CacheGroups(groupRepository: gh<_i153.GroupRepository>()));
  gh.lazySingleton<_i195.CacheLocation>(() =>
      _i195.CacheLocation(locationRepository: gh<_i156.LocationRepository>()));
  gh.lazySingleton<_i196.DeleteGroup>(
      () => _i196.DeleteGroup(groupRepository: gh<_i153.GroupRepository>()));
  gh.lazySingleton<_i197.DeleteLocation>(() =>
      _i197.DeleteLocation(locationRepository: gh<_i156.LocationRepository>()));
  gh.lazySingleton<_i198.FetchAllLocations>(() => _i198.FetchAllLocations(
      locationRepository: gh<_i156.LocationRepository>()));
  gh.lazySingleton<_i199.GetGroupsStream>(() =>
      _i199.GetGroupsStream(groupRepository: gh<_i153.GroupRepository>()));
  gh.factory<_i200.ItemActionBloc>(() => _i200.ItemActionBloc(
        authenticationBloc: gh<_i193.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i138.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i142.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i201.UserProfileBloc>(() => _i201.UserProfileBloc(
        authenticationBloc: gh<_i193.AuthenticationBloc>(),
        addUser: gh<_i69.AddUser>(),
        assignUserToCompany: gh<_i82.AssignUserToCompany>(),
        resetCompany: gh<_i160.ResetCompany>(),
        getUserById: gh<_i149.GetUserById>(),
        getUserStreamById: gh<_i150.GetUserStreamById>(),
        updateUserData: gh<_i181.UpdateUserData>(),
        addUserAvatar: gh<_i70.AddUserAvatar>(),
        inputValidator: gh<_i9.InputValidator>(),
      ));
  gh.factory<_i202.WorkRequestManagementBloc>(
      () => _i202.WorkRequestManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addWorkRequest: gh<_i71.AddWorkRequest>(),
            deleteWorkRequest: gh<_i115.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i182.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i88.CancelWorkRequest>(),
          ));
  gh.factory<_i203.AssetActionBloc>(() => _i203.AssetActionBloc(
        authenticationBloc: gh<_i193.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i123.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i141.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i204.AssetActionManagementBloc>(
      () => _i204.AssetActionManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addAssetAction: gh<_i185.AddAssetAction>(),
            updateAssetAction: gh<_i175.UpdateAssetAction>(),
            deleteAssetAction: gh<_i103.DeleteAssetAction>(),
          ));
  gh.singleton<_i205.AssetCategoryBloc>(_i205.AssetCategoryBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i124.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i206.AssetCategoryManagementBloc>(
      () => _i206.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addAssetCategory: gh<_i186.AddAssetCategory>(),
            updateAssetCategory: gh<_i176.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i104.DeleteAssetCategory>(),
          ));
  gh.factory<_i207.AssetManagementBloc>(() => _i207.AssetManagementBloc(
        userProfileBloc: gh<_i201.UserProfileBloc>(),
        addAsset: gh<_i184.AddAsset>(),
        deleteAsset: gh<_i102.DeleteAsset>(),
        updateAsset: gh<_i174.UpdateAsset>(),
      ));
  gh.factory<_i208.AssetPartsBloc>(() => _i208.AssetPartsBloc(
        authenticationBloc: gh<_i193.AuthenticationBloc>(),
        userProfileBloc: gh<_i201.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i126.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i209.ChecklistBloc>(_i209.ChecklistBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    getChecklistsStream: gh<_i129.GetChecklistStream>(),
  ));
  gh.factory<_i210.ChecklistManagementBloc>(() => _i210.ChecklistManagementBloc(
        userProfileBloc: gh<_i201.UserProfileBloc>(),
        addChecklist: gh<_i187.AddChecklist>(),
        updateChecklist: gh<_i177.UpdateChecklist>(),
        deleteChecklist: gh<_i105.DeleteChecklist>(),
      ));
  gh.singleton<_i211.CompanyManagementBloc>(_i211.CompanyManagementBloc(
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    inputValidator: gh<_i9.InputValidator>(),
    addCompany: gh<_i188.AddCompany>(),
    fetchAllCompanies: gh<_i116.FetchAllCompanies>(),
    addCompanyLogo: gh<_i189.AddCompanyLogo>(),
    updateCompany: gh<_i178.UpdateCompany>(),
  ));
  gh.singleton<_i212.CompanyProfileBloc>(_i212.CompanyProfileBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i117.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i130.GetCompanyById>(),
    inputValidator: gh<_i9.InputValidator>(),
  ));
  gh.singleton<_i213.DeviceTokenCubit>(_i213.DeviceTokenCubit(
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    registerDeviceToken: gh<_i30.RegisterDeviceToken>(),
    removeDeviceToken: gh<_i31.RemoveDeviceToken>(),
  ));
  gh.singleton<_i214.GroupBloc>(_i214.GroupBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    companyProfileBloc: gh<_i212.CompanyProfileBloc>(),
    addGroup: gh<_i190.AddGroup>(),
    updateGroup: gh<_i179.UpdateGroup>(),
    deleteGroup: gh<_i196.DeleteGroup>(),
    getGroupsStream: gh<_i199.GetGroupsStream>(),
    cacheGroups: gh<_i194.CacheGroups>(),
    tryToGetCachedGroups: gh<_i168.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i215.InstructionCategoryBloc>(_i215.InstructionCategoryBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i136.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i216.InstructionCategoryManagementBloc>(
      () => _i216.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addInstructionCategory: gh<_i61.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i43.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i107.DeleteInstructionCategory>(),
          ));
  gh.factory<_i217.InstructionManagementBloc>(
      () => _i217.InstructionManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addInstruction: gh<_i60.AddInstruction>(),
            deleteInstruction: gh<_i106.DeleteInstruction>(),
            updateInstruction: gh<_i42.UpdateInstruction>(),
          ));
  gh.factory<_i218.ItemActionManagementBloc>(
      () => _i218.ItemActionManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addItemAction: gh<_i63.AddItemAction>(),
            updateItemAction: gh<_i45.UpdateItemAction>(),
            deleteItemAction: gh<_i109.DeleteItemAction>(),
            moveItemAction: gh<_i24.MoveItemAction>(),
          ));
  gh.singleton<_i219.ItemCategoryBloc>(_i219.ItemCategoryBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i139.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i220.ItemCategoryManagementBloc>(
      () => _i220.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addItemCategory: gh<_i64.AddItemCategory>(),
            updateItemCategory: gh<_i46.UpdateItemCategory>(),
            deleteItemCategory: gh<_i110.DeleteItemCategory>(),
          ));
  gh.factory<_i221.ItemsManagementBloc>(() => _i221.ItemsManagementBloc(
        addItemPhoto: gh<_i65.AddItemPhoto>(),
        deleteItemPhoto: gh<_i111.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i47.UpdateItemPhoto>(),
        userProfileBloc: gh<_i201.UserProfileBloc>(),
        addItem: gh<_i62.AddItem>(),
        deleteItem: gh<_i108.DeleteItem>(),
        updateItem: gh<_i44.UpdateItem>(),
      ));
  gh.singleton<_i222.LocationBloc>(_i222.LocationBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    addLocation: gh<_i191.AddLocation>(),
    cacheLocation: gh<_i195.CacheLocation>(),
    deleteLocation: gh<_i197.DeleteLocation>(),
    fetchAllLocations: gh<_i198.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i169.TryToGetCachedLocation>(),
    updateLocation: gh<_i180.UpdateLocation>(),
  ));
  gh.singleton<_i223.NewUsersBloc>(_i223.NewUsersBloc(
    gh<_i212.CompanyProfileBloc>(),
    gh<_i118.FetchNewUsers>(),
  ));
  gh.lazySingleton<_i224.NotificationSettingsCubit>(
      () => _i224.NotificationSettingsCubit(
            gh<_i201.UserProfileBloc>(),
            gh<_i193.AuthenticationBloc>(),
            gh<_i145.GetNotificationSettings>(),
            gh<_i48.UpdateNotificationSettings>(),
          ));
  gh.singleton<_i225.SuspendedUsersBloc>(_i225.SuspendedUsersBloc(
    gh<_i212.CompanyProfileBloc>(),
    gh<_i119.FetchSuspendedUsers>(),
  ));
  gh.factory<_i226.TaskActionManagementBloc>(
      () => _i226.TaskActionManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addTaskAction: gh<_i67.AddTaskAction>(),
            deleteTaskAction: gh<_i113.DeleteTaskAction>(),
            updateTaskAction: gh<_i50.UpdateTaskAction>(),
          ));
  gh.factory<_i227.TaskManagementBloc>(() => _i227.TaskManagementBloc(
        userProfileBloc: gh<_i201.UserProfileBloc>(),
        addTask: gh<_i66.AddTask>(),
        deleteTask: gh<_i112.DeleteTask>(),
        updateTask: gh<_i49.UpdateTask>(),
        cancelTask: gh<_i87.CancelTask>(),
        completeTask: gh<_i97.CompleteTask>(),
      ));
  gh.lazySingleton<_i228.TaskTemplatesBloc>(() => _i228.TaskTemplatesBloc(
        authenticationBloc: gh<_i193.AuthenticationBloc>(),
        userProfileBloc: gh<_i201.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i148.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i229.TaskTemplatesManagementBloc>(
      () => _i229.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i201.UserProfileBloc>(),
            addTaskTemplate: gh<_i68.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i51.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i114.DeleteTaskTemplate>(),
          ));
  gh.singleton<_i230.FilterBloc>(_i230.FilterBloc(
    locationBloc: gh<_i222.LocationBloc>(),
    groupBloc: gh<_i214.GroupBloc>(),
    userProfileBloc: gh<_i201.UserProfileBloc>(),
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
  ));
  gh.singleton<_i231.InstructionBloc>(_i231.InstructionBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getInstructionsStream: gh<_i137.GetInstructionsStream>(),
  ));
  gh.singleton<_i232.ItemsBloc>(_i232.ItemsBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getChecklistsStream: gh<_i140.GetItemsStream>(),
  ));
  gh.singleton<_i233.TaskActionsStatusBloc>(_i233.TaskActionsStatusBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getLatestTaskActions: gh<_i143.GetLatestTaskActions>(),
  ));
  gh.singleton<_i234.TaskArchiveBloc>(_i234.TaskArchiveBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getArchiveTasksStream: gh<_i121.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i235.TaskArchiveLatestBloc>(_i235.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i120.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i236.TaskBloc>(_i236.TaskBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getTasksStream: gh<_i147.GetTasksStream>(),
  ));
  gh.singleton<_i237.WorkRequestArchiveBloc>(_i237.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i122.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i238.WorkRequestBloc>(_i238.WorkRequestBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getWorkRequestsStream: gh<_i151.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i239.WorkRequestsStatusBloc>(_i239.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i127.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i131.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i128.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i240.ActivityBloc>(_i240.ActivityBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    workRequestBloc: gh<_i238.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i237.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i236.TaskBloc>(),
    taskArchiveBloc: gh<_i234.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i233.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i241.AssetBloc>(_i241.AssetBloc(
    filterBloc: gh<_i230.FilterBloc>(),
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    getAssetsStream: gh<_i125.GetAssetsStream>(),
  ));
  gh.singleton<_i242.DashboardAssetActionBloc>(_i242.DashboardAssetActionBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i132.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i134.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i243.DashboardItemActionBloc>(_i243.DashboardItemActionBloc(
    authenticationBloc: gh<_i193.AuthenticationBloc>(),
    filterBloc: gh<_i230.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i133.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i135.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i244.TaskFilterBloc>(_i244.TaskFilterBloc(
    gh<_i193.AuthenticationBloc>(),
    gh<_i201.UserProfileBloc>(),
    gh<_i236.TaskBloc>(),
    gh<_i238.WorkRequestBloc>(),
  ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i245.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i245.FirebaseStorageService {}

class _$FirebaseMessagingService extends _i245.FirebaseMessagingService {}

class _$SharedPreferencesService extends _i245.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i246.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i246.DataConnectionCheckerModule {}
