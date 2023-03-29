// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_messaging/firebase_messaging.dart' as _i5;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i31;
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i79;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i81;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i83;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i102;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i78;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i80;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i82;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i101;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i198;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i199;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i107;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i129;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i138;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i140;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i147;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i189;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i200;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i108;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i130;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i190;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i92;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i106;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i131;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i132;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i188;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i262;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i265;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i206;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i88;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i87;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i89;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i93;
import 'package:under_control_v2/features/authentication/domain/usecases/delete_account.dart'
    as _i105;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i175;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i176;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i177;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i178;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i179;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i95;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i94;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i201;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i109;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i135;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i191;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i97;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i99;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i96;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i98;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i202;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i203;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i121;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i122;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i123;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i124;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i136;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i192;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i238;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i241;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/dashboard/data/repositories/task_action_status_repository_impl.dart'
    as _i37;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i62;
import 'package:under_control_v2/features/dashboard/domain/repositories/task_action_status_repository.dart'
    as _i36;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i61;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i133;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i134;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i137;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i149;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i261;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i254;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i260;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i251;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i164;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i166;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i165;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i204;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i208;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i210;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i213;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i182;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i193;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i104;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i103;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i65;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i68;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i112;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i115;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i146;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i66;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i113;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i139;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i141;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i144;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i148;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i67;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i114;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i145;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i49;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i266;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i234;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i235;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i253;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i236;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i63;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i110;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i143;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i64;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i111;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i142;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i45;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i44;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i252;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i230;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i167;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i169;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i168;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i205;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i209;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i211;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i212;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i183;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i194;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i237;
import 'package:under_control_v2/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i25;
import 'package:under_control_v2/features/notifications/data/repositories/uc_notification_repository_impl.dart'
    as _i43;
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart'
    as _i24;
import 'package:under_control_v2/features/notifications/domain/repositories/uc_notification_repository.dart'
    as _i42;
import 'package:under_control_v2/features/notifications/domain/usecases/delete_notification.dart'
    as _i116;
import 'package:under_control_v2/features/notifications/domain/usecases/get_notifications.dart'
    as _i153;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_read.dart'
    as _i171;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_unread.dart'
    as _i172;
import 'package:under_control_v2/features/notifications/domain/usecases/register_device_token.dart'
    as _i28;
import 'package:under_control_v2/features/notifications/domain/usecases/remove_device_token.dart'
    as _i29;
import 'package:under_control_v2/features/notifications/presentation/blocs/uc_notification/uc_notification_bloc.dart'
    as _i249;
import 'package:under_control_v2/features/notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart'
    as _i250;
import 'package:under_control_v2/features/notifications/presentation/cubits/cubit/device_token_cubit.dart'
    as _i228;
import 'package:under_control_v2/features/settings/data/repositories/notification_settings_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/settings/data/repositories/showcase_settings_repository_impl.dart'
    as _i33;
import 'package:under_control_v2/features/settings/domain/repositories/notification_settings_repository.dart'
    as _i26;
import 'package:under_control_v2/features/settings/domain/repositories/showcase_settings_repository.dart'
    as _i32;
import 'package:under_control_v2/features/settings/domain/usecases/get_notification_settings.dart'
    as _i152;
import 'package:under_control_v2/features/settings/domain/usecases/get_showcase_settings.dart'
    as _i154;
import 'package:under_control_v2/features/settings/domain/usecases/update_notification_settings.dart'
    as _i50;
import 'package:under_control_v2/features/settings/domain/usecases/update_showcase_settings.dart'
    as _i51;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i21;
import 'package:under_control_v2/features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart'
    as _i239;
import 'package:under_control_v2/features/settings/presentation/blocs/showcase_settings/showcase_settings_cubit.dart'
    as _i240;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i35;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i39;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i41;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i60;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i34;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i40;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i59;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i69;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i90;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i100;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i117;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i125;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i126;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream_for_asset.dart'
    as _i127;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_task_by_id.dart'
    as _i156;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i157;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream_for_asset.dart'
    as _i158;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i52;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i70;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i118;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i150;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_live_task_action_stream.dart'
    as _i151;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i155;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i53;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i71;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i119;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i159;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i54;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i74;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i91;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i120;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i128;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_request_by_id.dart'
    as _i162;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i163;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i196;
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_event/calendar_event_bloc.dart'
    as _i268;
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task/calendar_task_bloc.dart'
    as _i264;
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task_archive/calenddar_task_archive_bloc.dart'
    as _i263;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i30;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i257;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i181;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i242;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i255;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i256;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i267;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i244;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i245;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i246;
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_archive_for_asset/tasks_archive_for_asset_bloc.dart'
    as _i247;
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_for_asset/tasks_for_asset_bloc.dart'
    as _i248;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i259;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i258;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/tasks/presentation/cubits/task/task_cubit.dart'
    as _i243;
import 'package:under_control_v2/features/tasks/presentation/cubits/workRequest/work_request_cubit.dart'
    as _i216;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i56;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i58;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i55;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i57;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i72;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i73;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i75;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i76;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i77;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i84;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i85;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i86;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i160;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i161;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i170;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i173;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i174;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i180;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i184;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i185;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i186;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i187;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i195;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i215;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i270;
import 'features/core/injectable_modules/injectable_modules.dart' as _i269;

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
  final firebaseAuthenticationService = _$FirebaseAuthenticationService();
  final firebaseFirestoreService = _$FirebaseFirestoreService();
  final firebaseMessagingService = _$FirebaseMessagingService();
  final firebaseStorageService = _$FirebaseStorageService();
  final sharedPreferencesService = _$SharedPreferencesService();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseAuthenticationService.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseFirestoreService.firebaseFirestore);
  gh.lazySingleton<_i5.FirebaseMessaging>(
      () => firebaseMessagingService.firebaseMessaging);
  gh.lazySingleton<_i6.FirebaseStorage>(
      () => firebaseStorageService.firebaseStorage);
  gh.lazySingleton<_i7.GroupRemoteDataSource>(() =>
      _i7.GroupRemoteDataSourceImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i8.InputValidator>(() => _i8.InputValidator());
  gh.lazySingleton<_i9.InstructionCategoryRepository>(() =>
      _i10.InstructionCategoryRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i11.InstructionRepository>(
      () => _i12.InstructionRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i13.ItemActionRepository>(() =>
      _i14.ItemActionRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i15.ItemCategoryRepository>(() =>
      _i16.ItemCategoryRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i17.ItemFilesRepository>(() =>
      _i18.ItemFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i19.ItemRepository>(() => _i20.ItemRepositoryImpl(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.factory<_i21.LanguageCubit>(() => _i21.LanguageCubit());
  gh.lazySingleton<_i22.LocationRemoteDataSource>(() =>
      _i22.LocationRemoteDataSourceImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i23.MoveItemAction>(
      () => _i23.MoveItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i24.NotificationRepository>(
      () => _i25.NotificationRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseMessaging: gh<_i5.FirebaseMessaging>(),
          ));
  gh.lazySingleton<_i26.NotificationSettingsRepository>(() =>
      _i27.NotificationSettingsImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i28.RegisterDeviceToken>(() =>
      _i28.RegisterDeviceToken(repository: gh<_i24.NotificationRepository>()));
  gh.lazySingleton<_i29.RemoveDeviceToken>(() =>
      _i29.RemoveDeviceToken(repository: gh<_i24.NotificationRepository>()));
  gh.factory<_i30.ReservedSparePartsBloc>(() => _i30.ReservedSparePartsBloc());
  await gh.factoryAsync<_i31.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i32.ShowcaseSettingsRepository>(() =>
      _i33.ShowcaseSettingsImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i34.TaskActionRepository>(
      () => _i35.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i36.TaskActionStatusRepository>(() =>
      _i37.TaskActionStatusRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i38.TaskRepository>(() => _i39.TaskRepositoryImpl(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i40.TaskTemplatesRepository>(
      () => _i41.TaskTemplatesRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i42.UcNotificationRepository>(() =>
      _i43.UcNotificationRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i44.UpdateInstruction>(() =>
      _i44.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i45.UpdateInstructionCategory>(() =>
      _i45.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i46.UpdateItem>(
      () => _i46.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i47.UpdateItemAction>(
      () => _i47.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i48.UpdateItemCategory>(() =>
      _i48.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i49.UpdateItemPhoto>(
      () => _i49.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i50.UpdateNotificationSettings>(() =>
      _i50.UpdateNotificationSettings(
          repository: gh<_i26.NotificationSettingsRepository>()));
  gh.lazySingleton<_i51.UpdateShowcaseSettings>(() =>
      _i51.UpdateShowcaseSettings(
          repository: gh<_i32.ShowcaseSettingsRepository>()));
  gh.lazySingleton<_i52.UpdateTask>(
      () => _i52.UpdateTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i53.UpdateTaskAction>(
      () => _i53.UpdateTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i54.UpdateTaskTemplate>(() =>
      _i54.UpdateTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i55.UserFilesRepository>(() =>
      _i56.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i57.UserProfileRepository>(() =>
      _i58.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i59.WorkRequestsRepository>(
      () => _i60.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i61.WorkRequestsStatusRepository>(() =>
      _i62.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i63.AddInstruction>(
      () => _i63.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i64.AddInstructionCategory>(() =>
      _i64.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i65.AddItem>(
      () => _i65.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i66.AddItemAction>(
      () => _i66.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i67.AddItemCategory>(() =>
      _i67.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i68.AddItemPhoto>(
      () => _i68.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i69.AddTask>(
      () => _i69.AddTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i70.AddTaskAction>(
      () => _i70.AddTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i71.AddTaskTemplate>(() =>
      _i71.AddTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i72.AddUser>(
      () => _i72.AddUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i73.AddUserAvatar>(
      () => _i73.AddUserAvatar(repository: gh<_i55.UserFilesRepository>()));
  gh.lazySingleton<_i74.AddWorkRequest>(
      () => _i74.AddWorkRequest(repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i75.ApprovePassiveUser>(() =>
      _i75.ApprovePassiveUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i76.ApproveUser>(
      () => _i76.ApproveUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i77.ApproveUserAndMakeAdmin>(() =>
      _i77.ApproveUserAndMakeAdmin(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i78.AssetActionRepository>(() =>
      _i79.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i80.AssetCategoryRepository>(() =>
      _i81.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i82.AssetRepository>(() => _i83.AssetRepositoryImpl(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i84.AssignGroupAdmin>(() =>
      _i84.AssignGroupAdmin(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i85.AssignUserToCompany>(() =>
      _i85.AssignUserToCompany(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i86.AssignUserToGroup>(() =>
      _i86.AssignUserToGroup(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i87.AuthenticationRepository>(
      () => _i88.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i3.FirebaseAuth>(),
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseMessaging: gh<_i5.FirebaseMessaging>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i89.AutoSignin>(() => _i89.AutoSignin(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i90.CancelTask>(
      () => _i90.CancelTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i91.CancelWorkRequest>(() =>
      _i91.CancelWorkRequest(repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i92.CheckCodeAvailability>(
      () => _i92.CheckCodeAvailability(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i93.CheckEmailVerification>(() =>
      _i93.CheckEmailVerification(
          authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i94.CheckListsRepository>(() =>
      _i95.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i96.CompanyManagementRepository>(
      () => _i97.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i98.CompanyRepository>(() => _i99.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i100.CompleteTask>(
      () => _i100.CompleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i101.DashboardAssetActionRepository>(() =>
      _i102.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i103.DashboardItemActionRepository>(() =>
      _i104.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i105.DeleteAccount>(() => _i105.DeleteAccount(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i106.DeleteAsset>(
      () => _i106.DeleteAsset(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i107.DeleteAssetAction>(() =>
      _i107.DeleteAssetAction(repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i108.DeleteAssetCategory>(() => _i108.DeleteAssetCategory(
      repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i109.DeleteChecklist>(
      () => _i109.DeleteChecklist(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i110.DeleteInstruction>(() =>
      _i110.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i111.DeleteInstructionCategory>(() =>
      _i111.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i112.DeleteItem>(
      () => _i112.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i113.DeleteItemAction>(() =>
      _i113.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i114.DeleteItemCategory>(() =>
      _i114.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i115.DeleteItemPhoto>(
      () => _i115.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i116.DeleteNotification>(() => _i116.DeleteNotification(
      repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i117.DeleteTask>(
      () => _i117.DeleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i118.DeleteTaskAction>(() =>
      _i118.DeleteTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i119.DeleteTaskTemplate>(() =>
      _i119.DeleteTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i120.DeleteWorkRequest>(() =>
      _i120.DeleteWorkRequest(repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i121.FetchAllCompanies>(() => _i121.FetchAllCompanies(
      companyManagementRepository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i122.FetchAllCompanyUsers>(() => _i122.FetchAllCompanyUsers(
      companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i123.FetchNewUsers>(() =>
      _i123.FetchNewUsers(companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i124.FetchSuspendedUsers>(() => _i124.FetchSuspendedUsers(
      companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i125.GetArchiveLatestTasksStream>(() =>
      _i125.GetArchiveLatestTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i126.GetArchiveTasksStream>(
      () => _i126.GetArchiveTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i127.GetArchiveTasksStreamForAsset>(() =>
      _i127.GetArchiveTasksStreamForAsset(
          repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i128.GetArchiveWorkRequestsStream>(() =>
      _i128.GetArchiveWorkRequestsStream(
          repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i129.GetAssetActionsStream>(() =>
      _i129.GetAssetActionsStream(
          repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i130.GetAssetsCategoriesStream>(() =>
      _i130.GetAssetsCategoriesStream(
          repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i131.GetAssetsStream>(
      () => _i131.GetAssetsStream(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i132.GetAssetsStreamForParent>(() =>
      _i132.GetAssetsStreamForParent(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i133.GetAwaitingWorkRequestsCount>(() =>
      _i133.GetAwaitingWorkRequestsCount(
          repository: gh<_i61.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i134.GetCancelledWorkRequestsCount>(() =>
      _i134.GetCancelledWorkRequestsCount(
          repository: gh<_i61.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i135.GetChecklistStream>(() =>
      _i135.GetChecklistStream(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i136.GetCompanyById>(() =>
      _i136.GetCompanyById(companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i137.GetConvertedWorkRequestsCount>(() =>
      _i137.GetConvertedWorkRequestsCount(
          repository: gh<_i61.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i138.GetDashboardAssetActionsStream>(() =>
      _i138.GetDashboardAssetActionsStream(
          repository: gh<_i101.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i139.GetDashboardItemsActionsStream>(() =>
      _i139.GetDashboardItemsActionsStream(
          repository: gh<_i103.DashboardItemActionRepository>()));
  gh.lazySingleton<_i140.GetDashboardLastFiveAssetActionsStream>(() =>
      _i140.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i101.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i141.GetDashboardLastFiveItemsActionsStream>(() =>
      _i141.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i103.DashboardItemActionRepository>()));
  gh.lazySingleton<_i142.GetInstructionsCategoriesStream>(() =>
      _i142.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i143.GetInstructionsStream>(() =>
      _i143.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i144.GetItemsActionsStream>(() =>
      _i144.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i145.GetItemsCategoriesStream>(() =>
      _i145.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i146.GetItemsStream>(
      () => _i146.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i147.GetLastFiveAssetActionsStream>(() =>
      _i147.GetLastFiveAssetActionsStream(
          repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i148.GetLastFiveItemsActionsStream>(() =>
      _i148.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i149.GetLatestTaskActions>(() => _i149.GetLatestTaskActions(
      repository: gh<_i36.TaskActionStatusRepository>()));
  gh.lazySingleton<_i150.GetLatestTaskActionsStream>(() =>
      _i150.GetLatestTaskActionsStream(
          repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i151.GetLiveTaskActionsStream>(() =>
      _i151.GetLiveTaskActionsStream(
          repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i152.GetNotificationSettings>(() =>
      _i152.GetNotificationSettings(
          repository: gh<_i26.NotificationSettingsRepository>()));
  gh.lazySingleton<_i153.GetNotifications>(() =>
      _i153.GetNotifications(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i154.GetShowcaseSettings>(() => _i154.GetShowcaseSettings(
      repository: gh<_i32.ShowcaseSettingsRepository>()));
  gh.lazySingleton<_i155.GetTaskActionsStream>(() =>
      _i155.GetTaskActionsStream(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i156.GetTaskById>(
      () => _i156.GetTaskById(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i157.GetTasksStream>(
      () => _i157.GetTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i158.GetTasksStreamForAsset>(() =>
      _i158.GetTasksStreamForAsset(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i159.GetTasksTemplatesStream>(() =>
      _i159.GetTasksTemplatesStream(
          repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i160.GetUserById>(
      () => _i160.GetUserById(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i161.GetUserStreamById>(() => _i161.GetUserStreamById(
      userRepository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i162.GetWorkRequestById>(() =>
      _i162.GetWorkRequestById(repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i163.GetWorkRequestsStream>(() =>
      _i163.GetWorkRequestsStream(
          repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i164.GroupLocalDataSource>(() =>
      _i164.GroupLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i165.GroupRepository>(() => _i166.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i164.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i167.LocationLocalDataSource>(() =>
      _i167.LocationLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i168.LocationRepository>(() => _i169.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i167.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i170.MakeUserAdministrator>(() =>
      _i170.MakeUserAdministrator(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i171.MarkAsRead>(
      () => _i171.MarkAsRead(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i172.MarkAsUnread>(() =>
      _i172.MarkAsUnread(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i173.RejectUser>(
      () => _i173.RejectUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i174.ResetCompany>(
      () => _i174.ResetCompany(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i175.SendPasswordResetEmail>(() =>
      _i175.SendPasswordResetEmail(
          authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i176.SendVerificationEmail>(() =>
      _i176.SendVerificationEmail(
          authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i177.Signin>(() => _i177.Signin(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i178.Signout>(() => _i178.Signout(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i179.Signup>(() => _i179.Signup(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i180.SuspendUser>(
      () => _i180.SuspendUser(repository: gh<_i57.UserProfileRepository>()));
  gh.factory<_i181.TaskActionBloc>(() => _i181.TaskActionBloc(
      getTaskActionsStream: gh<_i155.GetTaskActionsStream>()));
  gh.lazySingleton<_i182.TryToGetCachedGroups>(() =>
      _i182.TryToGetCachedGroups(groupRepository: gh<_i165.GroupRepository>()));
  gh.lazySingleton<_i183.TryToGetCachedLocation>(() =>
      _i183.TryToGetCachedLocation(
          locationRepository: gh<_i168.LocationRepository>()));
  gh.lazySingleton<_i184.UnassignGroupAdmin>(() =>
      _i184.UnassignGroupAdmin(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i185.UnassignUserFromGroup>(() =>
      _i185.UnassignUserFromGroup(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i186.UnmakeUserAdministrator>(() =>
      _i186.UnmakeUserAdministrator(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i187.UnsuspendUser>(
      () => _i187.UnsuspendUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i188.UpdateAsset>(
      () => _i188.UpdateAsset(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i189.UpdateAssetAction>(() =>
      _i189.UpdateAssetAction(repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i190.UpdateAssetCategory>(() => _i190.UpdateAssetCategory(
      repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i191.UpdateChecklist>(
      () => _i191.UpdateChecklist(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i192.UpdateCompany>(() => _i192.UpdateCompany(
      companyRepository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i193.UpdateGroup>(
      () => _i193.UpdateGroup(groupRepository: gh<_i165.GroupRepository>()));
  gh.lazySingleton<_i194.UpdateLocation>(() =>
      _i194.UpdateLocation(locationRepository: gh<_i168.LocationRepository>()));
  gh.lazySingleton<_i195.UpdateUserData>(
      () => _i195.UpdateUserData(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i196.UpdateWorkRequest>(() =>
      _i196.UpdateWorkRequest(repository: gh<_i59.WorkRequestsRepository>()));
  gh.factory<_i197.UserManagementBloc>(() => _i197.UserManagementBloc(
        approveUser: gh<_i76.ApproveUser>(),
        approvePassiveUser: gh<_i75.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i170.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i186.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i77.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i173.RejectUser>(),
        suspendUser: gh<_i180.SuspendUser>(),
        unsuspendUser: gh<_i187.UnsuspendUser>(),
        updateUserData: gh<_i195.UpdateUserData>(),
        assignUserToGroup: gh<_i86.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i185.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i84.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i184.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i73.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i198.AddAsset>(
      () => _i198.AddAsset(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i199.AddAssetAction>(
      () => _i199.AddAssetAction(repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i200.AddAssetCategory>(() =>
      _i200.AddAssetCategory(repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i201.AddChecklist>(
      () => _i201.AddChecklist(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i202.AddCompany>(() => _i202.AddCompany(
      companyManagementRepository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i203.AddCompanyLogo>(() =>
      _i203.AddCompanyLogo(repository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i204.AddGroup>(
      () => _i204.AddGroup(groupRepository: gh<_i165.GroupRepository>()));
  gh.lazySingleton<_i205.AddLocation>(() =>
      _i205.AddLocation(locationRepository: gh<_i168.LocationRepository>()));
  gh.factory<_i206.AssetInternalNumberCubit>(
      () => _i206.AssetInternalNumberCubit(gh<_i92.CheckCodeAvailability>()));
  gh.lazySingleton<_i207.AuthenticationBloc>(() => _i207.AuthenticationBloc(
        signin: gh<_i177.Signin>(),
        signup: gh<_i179.Signup>(),
        signout: gh<_i178.Signout>(),
        deleteAccount: gh<_i105.DeleteAccount>(),
        autoSignin: gh<_i89.AutoSignin>(),
        sendVerificationEmail: gh<_i176.SendVerificationEmail>(),
        checkEmailVerification: gh<_i93.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i175.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i208.CacheGroups>(
      () => _i208.CacheGroups(groupRepository: gh<_i165.GroupRepository>()));
  gh.lazySingleton<_i209.CacheLocation>(() =>
      _i209.CacheLocation(locationRepository: gh<_i168.LocationRepository>()));
  gh.lazySingleton<_i210.DeleteGroup>(
      () => _i210.DeleteGroup(groupRepository: gh<_i165.GroupRepository>()));
  gh.lazySingleton<_i211.DeleteLocation>(() =>
      _i211.DeleteLocation(locationRepository: gh<_i168.LocationRepository>()));
  gh.lazySingleton<_i212.FetchAllLocations>(() => _i212.FetchAllLocations(
      locationRepository: gh<_i168.LocationRepository>()));
  gh.lazySingleton<_i213.GetGroupsStream>(() =>
      _i213.GetGroupsStream(groupRepository: gh<_i165.GroupRepository>()));
  gh.factory<_i214.ItemActionBloc>(() => _i214.ItemActionBloc(
        authenticationBloc: gh<_i207.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i144.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i148.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i215.UserProfileBloc>(() => _i215.UserProfileBloc(
        authenticationBloc: gh<_i207.AuthenticationBloc>(),
        addUser: gh<_i72.AddUser>(),
        assignUserToCompany: gh<_i85.AssignUserToCompany>(),
        resetCompany: gh<_i174.ResetCompany>(),
        getUserById: gh<_i160.GetUserById>(),
        getUserStreamById: gh<_i161.GetUserStreamById>(),
        updateUserData: gh<_i195.UpdateUserData>(),
        addUserAvatar: gh<_i73.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.factory<_i216.WorkRequestCubit>(() => _i216.WorkRequestCubit(
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        getWorkRequestByIdUsecase: gh<_i162.GetWorkRequestById>(),
      ));
  gh.factory<_i217.WorkRequestManagementBloc>(
      () => _i217.WorkRequestManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addWorkRequest: gh<_i74.AddWorkRequest>(),
            deleteWorkRequest: gh<_i120.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i196.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i91.CancelWorkRequest>(),
          ));
  gh.factory<_i218.AssetActionBloc>(() => _i218.AssetActionBloc(
        authenticationBloc: gh<_i207.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i129.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i147.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i219.AssetActionManagementBloc>(
      () => _i219.AssetActionManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addAssetAction: gh<_i199.AddAssetAction>(),
            updateAssetAction: gh<_i189.UpdateAssetAction>(),
            deleteAssetAction: gh<_i107.DeleteAssetAction>(),
          ));
  gh.singleton<_i220.AssetCategoryBloc>(_i220.AssetCategoryBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i130.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i221.AssetCategoryManagementBloc>(
      () => _i221.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addAssetCategory: gh<_i200.AddAssetCategory>(),
            updateAssetCategory: gh<_i190.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i108.DeleteAssetCategory>(),
          ));
  gh.factory<_i222.AssetManagementBloc>(() => _i222.AssetManagementBloc(
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        addAsset: gh<_i198.AddAsset>(),
        deleteAsset: gh<_i106.DeleteAsset>(),
        updateAsset: gh<_i188.UpdateAsset>(),
      ));
  gh.factory<_i223.AssetPartsBloc>(() => _i223.AssetPartsBloc(
        authenticationBloc: gh<_i207.AuthenticationBloc>(),
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i132.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i224.ChecklistBloc>(_i224.ChecklistBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    getChecklistsStream: gh<_i135.GetChecklistStream>(),
  ));
  gh.factory<_i225.ChecklistManagementBloc>(() => _i225.ChecklistManagementBloc(
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        addChecklist: gh<_i201.AddChecklist>(),
        updateChecklist: gh<_i191.UpdateChecklist>(),
        deleteChecklist: gh<_i109.DeleteChecklist>(),
      ));
  gh.singleton<_i226.CompanyManagementBloc>(_i226.CompanyManagementBloc(
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    inputValidator: gh<_i8.InputValidator>(),
    addCompany: gh<_i202.AddCompany>(),
    fetchAllCompanies: gh<_i121.FetchAllCompanies>(),
    addCompanyLogo: gh<_i203.AddCompanyLogo>(),
    updateCompany: gh<_i192.UpdateCompany>(),
  ));
  gh.singleton<_i227.CompanyProfileBloc>(_i227.CompanyProfileBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i122.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i136.GetCompanyById>(),
    inputValidator: gh<_i8.InputValidator>(),
  ));
  gh.singleton<_i228.DeviceTokenCubit>(_i228.DeviceTokenCubit(
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    registerDeviceToken: gh<_i28.RegisterDeviceToken>(),
    removeDeviceToken: gh<_i29.RemoveDeviceToken>(),
  ));
  gh.singleton<_i229.GroupBloc>(_i229.GroupBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    companyProfileBloc: gh<_i227.CompanyProfileBloc>(),
    addGroup: gh<_i204.AddGroup>(),
    updateGroup: gh<_i193.UpdateGroup>(),
    deleteGroup: gh<_i210.DeleteGroup>(),
    getGroupsStream: gh<_i213.GetGroupsStream>(),
    cacheGroups: gh<_i208.CacheGroups>(),
    tryToGetCachedGroups: gh<_i182.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i230.InstructionCategoryBloc>(_i230.InstructionCategoryBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i142.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i231.InstructionCategoryManagementBloc>(
      () => _i231.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addInstructionCategory: gh<_i64.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i45.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i111.DeleteInstructionCategory>(),
          ));
  gh.factory<_i232.InstructionManagementBloc>(
      () => _i232.InstructionManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addInstruction: gh<_i63.AddInstruction>(),
            deleteInstruction: gh<_i110.DeleteInstruction>(),
            updateInstruction: gh<_i44.UpdateInstruction>(),
          ));
  gh.factory<_i233.ItemActionManagementBloc>(
      () => _i233.ItemActionManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addItemAction: gh<_i66.AddItemAction>(),
            updateItemAction: gh<_i47.UpdateItemAction>(),
            deleteItemAction: gh<_i113.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.singleton<_i234.ItemCategoryBloc>(_i234.ItemCategoryBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i145.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i235.ItemCategoryManagementBloc>(
      () => _i235.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addItemCategory: gh<_i67.AddItemCategory>(),
            updateItemCategory: gh<_i48.UpdateItemCategory>(),
            deleteItemCategory: gh<_i114.DeleteItemCategory>(),
          ));
  gh.factory<_i236.ItemsManagementBloc>(() => _i236.ItemsManagementBloc(
        addItemPhoto: gh<_i68.AddItemPhoto>(),
        deleteItemPhoto: gh<_i115.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i49.UpdateItemPhoto>(),
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        addItem: gh<_i65.AddItem>(),
        deleteItem: gh<_i112.DeleteItem>(),
        updateItem: gh<_i46.UpdateItem>(),
      ));
  gh.singleton<_i237.LocationBloc>(_i237.LocationBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    addLocation: gh<_i205.AddLocation>(),
    cacheLocation: gh<_i209.CacheLocation>(),
    deleteLocation: gh<_i211.DeleteLocation>(),
    fetchAllLocations: gh<_i212.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i183.TryToGetCachedLocation>(),
    updateLocation: gh<_i194.UpdateLocation>(),
  ));
  gh.singleton<_i238.NewUsersBloc>(_i238.NewUsersBloc(
    gh<_i227.CompanyProfileBloc>(),
    gh<_i123.FetchNewUsers>(),
  ));
  gh.lazySingleton<_i239.NotificationSettingsCubit>(
      () => _i239.NotificationSettingsCubit(
            gh<_i215.UserProfileBloc>(),
            gh<_i207.AuthenticationBloc>(),
            gh<_i152.GetNotificationSettings>(),
            gh<_i50.UpdateNotificationSettings>(),
          ));
  gh.lazySingleton<_i240.ShowcaseSettingsCubit>(
      () => _i240.ShowcaseSettingsCubit(
            gh<_i215.UserProfileBloc>(),
            gh<_i207.AuthenticationBloc>(),
            gh<_i154.GetShowcaseSettings>(),
            gh<_i51.UpdateShowcaseSettings>(),
          ));
  gh.singleton<_i241.SuspendedUsersBloc>(_i241.SuspendedUsersBloc(
    gh<_i227.CompanyProfileBloc>(),
    gh<_i124.FetchSuspendedUsers>(),
  ));
  gh.factory<_i242.TaskActionManagementBloc>(
      () => _i242.TaskActionManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addTaskAction: gh<_i70.AddTaskAction>(),
            deleteTaskAction: gh<_i118.DeleteTaskAction>(),
            updateTaskAction: gh<_i53.UpdateTaskAction>(),
          ));
  gh.factory<_i243.TaskCubit>(() => _i243.TaskCubit(
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        getTaskByIdUsecase: gh<_i156.GetTaskById>(),
      ));
  gh.factory<_i244.TaskManagementBloc>(() => _i244.TaskManagementBloc(
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        addTask: gh<_i69.AddTask>(),
        deleteTask: gh<_i117.DeleteTask>(),
        updateTask: gh<_i52.UpdateTask>(),
        cancelTask: gh<_i90.CancelTask>(),
        completeTask: gh<_i100.CompleteTask>(),
      ));
  gh.lazySingleton<_i245.TaskTemplatesBloc>(() => _i245.TaskTemplatesBloc(
        authenticationBloc: gh<_i207.AuthenticationBloc>(),
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i159.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i246.TaskTemplatesManagementBloc>(
      () => _i246.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            addTaskTemplate: gh<_i71.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i54.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i119.DeleteTaskTemplate>(),
          ));
  gh.factory<_i247.TasksArchiveForAssetBloc>(
      () => _i247.TasksArchiveForAssetBloc(
            userProfileBloc: gh<_i215.UserProfileBloc>(),
            getTasksStreamForAsset: gh<_i127.GetArchiveTasksStreamForAsset>(),
          ));
  gh.factory<_i248.TasksForAssetBloc>(() => _i248.TasksForAssetBloc(
        userProfileBloc: gh<_i215.UserProfileBloc>(),
        getTasksStreamForAsset: gh<_i158.GetTasksStreamForAsset>(),
      ));
  gh.singleton<_i249.UcNotificationBloc>(_i249.UcNotificationBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    getNotifications: gh<_i153.GetNotifications>(),
  ));
  gh.factory<_i250.UcNotificationManagementBloc>(
      () => _i250.UcNotificationManagementBloc(
            markAsRead: gh<_i171.MarkAsRead>(),
            markAsUnread: gh<_i172.MarkAsUnread>(),
            deleteNotification: gh<_i116.DeleteNotification>(),
            userProfileBloc: gh<_i215.UserProfileBloc>(),
          ));
  gh.singleton<_i251.FilterBloc>(_i251.FilterBloc(
    locationBloc: gh<_i237.LocationBloc>(),
    groupBloc: gh<_i229.GroupBloc>(),
    userProfileBloc: gh<_i215.UserProfileBloc>(),
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
  ));
  gh.singleton<_i252.InstructionBloc>(_i252.InstructionBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getInstructionsStream: gh<_i143.GetInstructionsStream>(),
  ));
  gh.singleton<_i253.ItemsBloc>(_i253.ItemsBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getChecklistsStream: gh<_i146.GetItemsStream>(),
  ));
  gh.singleton<_i254.TaskActionsStatusBloc>(_i254.TaskActionsStatusBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getLatestTaskActions: gh<_i149.GetLatestTaskActions>(),
  ));
  gh.singleton<_i255.TaskArchiveBloc>(_i255.TaskArchiveBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveTasksStream: gh<_i126.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i256.TaskArchiveLatestBloc>(_i256.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i125.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i257.TaskBloc>(_i257.TaskBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getTasksStream: gh<_i157.GetTasksStream>(),
  ));
  gh.singleton<_i258.WorkRequestArchiveBloc>(_i258.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i128.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i259.WorkRequestBloc>(_i259.WorkRequestBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getWorkRequestsStream: gh<_i163.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i260.WorkRequestsStatusBloc>(_i260.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i133.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i137.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i134.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i261.ActivityBloc>(_i261.ActivityBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    workRequestBloc: gh<_i259.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i258.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i257.TaskBloc>(),
    taskArchiveBloc: gh<_i255.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i254.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i262.AssetBloc>(_i262.AssetBloc(
    filterBloc: gh<_i251.FilterBloc>(),
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    getAssetsStream: gh<_i131.GetAssetsStream>(),
  ));
  gh.singleton<_i263.CalendarTaskArchiveBloc>(_i263.CalendarTaskArchiveBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveTasksStream: gh<_i126.GetArchiveTasksStream>(),
  ));
  gh.lazySingleton<_i264.CalendarTaskBloc>(() => _i264.CalendarTaskBloc(
        authenticationBloc: gh<_i207.AuthenticationBloc>(),
        filterBloc: gh<_i251.FilterBloc>(),
        getTasksStream: gh<_i157.GetTasksStream>(),
      ));
  gh.singleton<_i265.DashboardAssetActionBloc>(_i265.DashboardAssetActionBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i138.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i140.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i266.DashboardItemActionBloc>(_i266.DashboardItemActionBloc(
    authenticationBloc: gh<_i207.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i139.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i141.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i267.TaskFilterBloc>(_i267.TaskFilterBloc(
    gh<_i207.AuthenticationBloc>(),
    gh<_i215.UserProfileBloc>(),
    gh<_i257.TaskBloc>(),
    gh<_i259.WorkRequestBloc>(),
  ));
  gh.lazySingleton<_i268.CalendarEventBloc>(() => _i268.CalendarEventBloc(
        gh<_i264.CalendarTaskBloc>(),
        gh<_i263.CalendarTaskArchiveBloc>(),
        gh<_i251.FilterBloc>(),
      ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i269.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i269.FirebaseStorageService {}

class _$FirebaseMessagingService extends _i269.FirebaseMessagingService {}

class _$SharedPreferencesService extends _i269.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i270.FirebaseAuthenticationService {}
