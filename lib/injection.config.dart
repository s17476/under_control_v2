// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i240;

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
    as _i197;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i198;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i106;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i128;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i137;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i139;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i146;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i188;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i199;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i107;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i129;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i189;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i92;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i105;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i130;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i131;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i187;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i262;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i265;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i205;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i88;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i87;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i89;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i93;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i174;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i175;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i176;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i177;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i178;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i95;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i94;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i200;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i108;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i134;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i190;
import 'package:under_control_v2/features/checklists/presentation/blocs/Checklist/checklist_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i97;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i99;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i96;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i98;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i201;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i202;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i120;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i121;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i122;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i123;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i135;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i191;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i237;
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
    as _i132;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i133;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i136;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i148;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i261;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i254;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i260;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i251;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i163;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i165;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i164;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i203;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i207;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i209;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i212;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i181;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i192;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i228;
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
    as _i111;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i114;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i145;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i66;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i112;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i138;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i140;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i143;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i147;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i67;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i113;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i144;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i49;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i266;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i234;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i253;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i235;
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
    as _i109;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i142;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i64;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i110;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i141;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i45;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i44;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i252;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i230;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i166;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i168;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i167;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i204;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i208;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i210;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i211;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i182;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i193;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i236;
import 'package:under_control_v2/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i25;
import 'package:under_control_v2/features/notifications/data/repositories/uc_notification_repository_impl.dart'
    as _i43;
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart'
    as _i24;
import 'package:under_control_v2/features/notifications/domain/repositories/uc_notification_repository.dart'
    as _i42;
import 'package:under_control_v2/features/notifications/domain/usecases/delete_notification.dart'
    as _i115;
import 'package:under_control_v2/features/notifications/domain/usecases/get_notifications.dart'
    as _i152;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_read.dart'
    as _i170;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_unread.dart'
    as _i171;
import 'package:under_control_v2/features/notifications/domain/usecases/register_device_token.dart'
    as _i28;
import 'package:under_control_v2/features/notifications/domain/usecases/remove_device_token.dart'
    as _i29;
import 'package:under_control_v2/features/notifications/presentation/blocs/uc_notification/uc_notification_bloc.dart'
    as _i249;
import 'package:under_control_v2/features/notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart'
    as _i250;
import 'package:under_control_v2/features/notifications/presentation/cubits/cubit/device_token_cubit.dart'
    as _i227;
import 'package:under_control_v2/features/settings/data/repositories/notification_settings_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/settings/data/repositories/showcase_settings_repository_impl.dart'
    as _i33;
import 'package:under_control_v2/features/settings/domain/repositories/notification_settings_repository.dart'
    as _i26;
import 'package:under_control_v2/features/settings/domain/repositories/showcase_settings_repository.dart'
    as _i32;
import 'package:under_control_v2/features/settings/domain/usecases/get_notification_settings.dart'
    as _i151;
import 'package:under_control_v2/features/settings/domain/usecases/get_showcase_settings.dart'
    as _i153;
import 'package:under_control_v2/features/settings/domain/usecases/update_notification_settings.dart'
    as _i50;
import 'package:under_control_v2/features/settings/domain/usecases/update_showcase_settings.dart'
    as _i51;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i21;
import 'package:under_control_v2/features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart'
    as _i238;
import 'package:under_control_v2/features/settings/presentation/blocs/showcase_settings/showcase_settings_cubit.dart'
    as _i239;
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
    as _i116;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i124;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i125;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream_for_asset.dart'
    as _i126;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_task_by_id.dart'
    as _i155;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i156;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream_for_asset.dart'
    as _i157;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i52;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i70;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i117;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i149;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_live_task_action_stream.dart'
    as _i150;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i154;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i53;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i71;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i118;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i158;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i54;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i74;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i91;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i119;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i127;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_request_by_id.dart'
    as _i161;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i162;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i195;
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
    as _i180;
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
    as _i216;
import 'package:under_control_v2/features/tasks/presentation/cubits/task/task_cubit.dart'
    as _i243;
import 'package:under_control_v2/features/tasks/presentation/cubits/workRequest/work_request_cubit.dart'
    as _i215;
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
    as _i159;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i160;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i169;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i172;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i173;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i179;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i183;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i184;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i185;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i186;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i194;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i214;

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
  gh.lazySingleton<_i105.DeleteAsset>(
      () => _i105.DeleteAsset(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i106.DeleteAssetAction>(() =>
      _i106.DeleteAssetAction(repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i107.DeleteAssetCategory>(() => _i107.DeleteAssetCategory(
      repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i108.DeleteChecklist>(
      () => _i108.DeleteChecklist(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i109.DeleteInstruction>(() =>
      _i109.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i110.DeleteInstructionCategory>(() =>
      _i110.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i111.DeleteItem>(
      () => _i111.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i112.DeleteItemAction>(() =>
      _i112.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i113.DeleteItemCategory>(() =>
      _i113.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i114.DeleteItemPhoto>(
      () => _i114.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i115.DeleteNotification>(() => _i115.DeleteNotification(
      repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i116.DeleteTask>(
      () => _i116.DeleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i117.DeleteTaskAction>(() =>
      _i117.DeleteTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i118.DeleteTaskTemplate>(() =>
      _i118.DeleteTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i119.DeleteWorkRequest>(() =>
      _i119.DeleteWorkRequest(repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i120.FetchAllCompanies>(() => _i120.FetchAllCompanies(
      companyManagementRepository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i121.FetchAllCompanyUsers>(() => _i121.FetchAllCompanyUsers(
      companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i122.FetchNewUsers>(() =>
      _i122.FetchNewUsers(companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i123.FetchSuspendedUsers>(() => _i123.FetchSuspendedUsers(
      companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i124.GetArchiveLatestTasksStream>(() =>
      _i124.GetArchiveLatestTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i125.GetArchiveTasksStream>(
      () => _i125.GetArchiveTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i126.GetArchiveTasksStreamForAsset>(() =>
      _i126.GetArchiveTasksStreamForAsset(
          repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i127.GetArchiveWorkRequestsStream>(() =>
      _i127.GetArchiveWorkRequestsStream(
          repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i128.GetAssetActionsStream>(() =>
      _i128.GetAssetActionsStream(
          repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i129.GetAssetsCategoriesStream>(() =>
      _i129.GetAssetsCategoriesStream(
          repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i130.GetAssetsStream>(
      () => _i130.GetAssetsStream(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i131.GetAssetsStreamForParent>(() =>
      _i131.GetAssetsStreamForParent(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i132.GetAwaitingWorkRequestsCount>(() =>
      _i132.GetAwaitingWorkRequestsCount(
          repository: gh<_i61.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i133.GetCancelledWorkRequestsCount>(() =>
      _i133.GetCancelledWorkRequestsCount(
          repository: gh<_i61.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i134.GetChecklistStream>(() =>
      _i134.GetChecklistStream(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i135.GetCompanyById>(() =>
      _i135.GetCompanyById(companyRepository: gh<_i98.CompanyRepository>()));
  gh.lazySingleton<_i136.GetConvertedWorkRequestsCount>(() =>
      _i136.GetConvertedWorkRequestsCount(
          repository: gh<_i61.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i137.GetDashboardAssetActionsStream>(() =>
      _i137.GetDashboardAssetActionsStream(
          repository: gh<_i101.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i138.GetDashboardItemsActionsStream>(() =>
      _i138.GetDashboardItemsActionsStream(
          repository: gh<_i103.DashboardItemActionRepository>()));
  gh.lazySingleton<_i139.GetDashboardLastFiveAssetActionsStream>(() =>
      _i139.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i101.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i140.GetDashboardLastFiveItemsActionsStream>(() =>
      _i140.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i103.DashboardItemActionRepository>()));
  gh.lazySingleton<_i141.GetInstructionsCategoriesStream>(() =>
      _i141.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i142.GetInstructionsStream>(() =>
      _i142.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i143.GetItemsActionsStream>(() =>
      _i143.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i144.GetItemsCategoriesStream>(() =>
      _i144.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i145.GetItemsStream>(
      () => _i145.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i146.GetLastFiveAssetActionsStream>(() =>
      _i146.GetLastFiveAssetActionsStream(
          repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i147.GetLastFiveItemsActionsStream>(() =>
      _i147.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i148.GetLatestTaskActions>(() => _i148.GetLatestTaskActions(
      repository: gh<_i36.TaskActionStatusRepository>()));
  gh.lazySingleton<_i149.GetLatestTaskActionsStream>(() =>
      _i149.GetLatestTaskActionsStream(
          repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i150.GetLiveTaskActionsStream>(() =>
      _i150.GetLiveTaskActionsStream(
          repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i151.GetNotificationSettings>(() =>
      _i151.GetNotificationSettings(
          repository: gh<_i26.NotificationSettingsRepository>()));
  gh.lazySingleton<_i152.GetNotifications>(() =>
      _i152.GetNotifications(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i153.GetShowcaseSettings>(() => _i153.GetShowcaseSettings(
      repository: gh<_i32.ShowcaseSettingsRepository>()));
  gh.lazySingleton<_i154.GetTaskActionsStream>(() =>
      _i154.GetTaskActionsStream(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i155.GetTaskById>(
      () => _i155.GetTaskById(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i156.GetTasksStream>(
      () => _i156.GetTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i157.GetTasksStreamForAsset>(() =>
      _i157.GetTasksStreamForAsset(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i158.GetTasksTemplatesStream>(() =>
      _i158.GetTasksTemplatesStream(
          repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i159.GetUserById>(
      () => _i159.GetUserById(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i160.GetUserStreamById>(() => _i160.GetUserStreamById(
      userRepository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i161.GetWorkRequestById>(() =>
      _i161.GetWorkRequestById(repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i162.GetWorkRequestsStream>(() =>
      _i162.GetWorkRequestsStream(
          repository: gh<_i59.WorkRequestsRepository>()));
  gh.lazySingleton<_i163.GroupLocalDataSource>(() =>
      _i163.GroupLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i164.GroupRepository>(() => _i165.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i163.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i166.LocationLocalDataSource>(() =>
      _i166.LocationLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i167.LocationRepository>(() => _i168.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i166.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i169.MakeUserAdministrator>(() =>
      _i169.MakeUserAdministrator(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i170.MarkAsRead>(
      () => _i170.MarkAsRead(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i171.MarkAsUnread>(() =>
      _i171.MarkAsUnread(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i172.RejectUser>(
      () => _i172.RejectUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i173.ResetCompany>(
      () => _i173.ResetCompany(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i174.SendPasswordResetEmail>(() =>
      _i174.SendPasswordResetEmail(
          authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i175.SendVerificationEmail>(() =>
      _i175.SendVerificationEmail(
          authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i176.Signin>(() => _i176.Signin(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i177.Signout>(() => _i177.Signout(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i178.Signup>(() => _i178.Signup(
      authenticationRepository: gh<_i87.AuthenticationRepository>()));
  gh.lazySingleton<_i179.SuspendUser>(
      () => _i179.SuspendUser(repository: gh<_i57.UserProfileRepository>()));
  gh.factory<_i180.TaskActionBloc>(() => _i180.TaskActionBloc(
      getTaskActionsStream: gh<_i154.GetTaskActionsStream>()));
  gh.lazySingleton<_i181.TryToGetCachedGroups>(() =>
      _i181.TryToGetCachedGroups(groupRepository: gh<_i164.GroupRepository>()));
  gh.lazySingleton<_i182.TryToGetCachedLocation>(() =>
      _i182.TryToGetCachedLocation(
          locationRepository: gh<_i167.LocationRepository>()));
  gh.lazySingleton<_i183.UnassignGroupAdmin>(() =>
      _i183.UnassignGroupAdmin(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i184.UnassignUserFromGroup>(() =>
      _i184.UnassignUserFromGroup(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i185.UnmakeUserAdministrator>(() =>
      _i185.UnmakeUserAdministrator(
          repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i186.UnsuspendUser>(
      () => _i186.UnsuspendUser(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i187.UpdateAsset>(
      () => _i187.UpdateAsset(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i188.UpdateAssetAction>(() =>
      _i188.UpdateAssetAction(repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i189.UpdateAssetCategory>(() => _i189.UpdateAssetCategory(
      repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i190.UpdateChecklist>(
      () => _i190.UpdateChecklist(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i191.UpdateCompany>(() => _i191.UpdateCompany(
      companyRepository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i192.UpdateGroup>(
      () => _i192.UpdateGroup(groupRepository: gh<_i164.GroupRepository>()));
  gh.lazySingleton<_i193.UpdateLocation>(() =>
      _i193.UpdateLocation(locationRepository: gh<_i167.LocationRepository>()));
  gh.lazySingleton<_i194.UpdateUserData>(
      () => _i194.UpdateUserData(repository: gh<_i57.UserProfileRepository>()));
  gh.lazySingleton<_i195.UpdateWorkRequest>(() =>
      _i195.UpdateWorkRequest(repository: gh<_i59.WorkRequestsRepository>()));
  gh.factory<_i196.UserManagementBloc>(() => _i196.UserManagementBloc(
        approveUser: gh<_i76.ApproveUser>(),
        approvePassiveUser: gh<_i75.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i169.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i185.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i77.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i172.RejectUser>(),
        suspendUser: gh<_i179.SuspendUser>(),
        unsuspendUser: gh<_i186.UnsuspendUser>(),
        updateUserData: gh<_i194.UpdateUserData>(),
        assignUserToGroup: gh<_i86.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i184.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i84.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i183.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i73.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i197.AddAsset>(
      () => _i197.AddAsset(repository: gh<_i82.AssetRepository>()));
  gh.lazySingleton<_i198.AddAssetAction>(
      () => _i198.AddAssetAction(repository: gh<_i78.AssetActionRepository>()));
  gh.lazySingleton<_i199.AddAssetCategory>(() =>
      _i199.AddAssetCategory(repository: gh<_i80.AssetCategoryRepository>()));
  gh.lazySingleton<_i200.AddChecklist>(
      () => _i200.AddChecklist(repository: gh<_i94.CheckListsRepository>()));
  gh.lazySingleton<_i201.AddCompany>(() => _i201.AddCompany(
      companyManagementRepository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i202.AddCompanyLogo>(() =>
      _i202.AddCompanyLogo(repository: gh<_i96.CompanyManagementRepository>()));
  gh.lazySingleton<_i203.AddGroup>(
      () => _i203.AddGroup(groupRepository: gh<_i164.GroupRepository>()));
  gh.lazySingleton<_i204.AddLocation>(() =>
      _i204.AddLocation(locationRepository: gh<_i167.LocationRepository>()));
  gh.factory<_i205.AssetInternalNumberCubit>(
      () => _i205.AssetInternalNumberCubit(gh<_i92.CheckCodeAvailability>()));
  gh.lazySingleton<_i206.AuthenticationBloc>(() => _i206.AuthenticationBloc(
        signin: gh<_i176.Signin>(),
        signup: gh<_i178.Signup>(),
        signout: gh<_i177.Signout>(),
        autoSignin: gh<_i89.AutoSignin>(),
        sendVerificationEmail: gh<_i175.SendVerificationEmail>(),
        checkEmailVerification: gh<_i93.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i174.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i207.CacheGroups>(
      () => _i207.CacheGroups(groupRepository: gh<_i164.GroupRepository>()));
  gh.lazySingleton<_i208.CacheLocation>(() =>
      _i208.CacheLocation(locationRepository: gh<_i167.LocationRepository>()));
  gh.lazySingleton<_i209.DeleteGroup>(
      () => _i209.DeleteGroup(groupRepository: gh<_i164.GroupRepository>()));
  gh.lazySingleton<_i210.DeleteLocation>(() =>
      _i210.DeleteLocation(locationRepository: gh<_i167.LocationRepository>()));
  gh.lazySingleton<_i211.FetchAllLocations>(() => _i211.FetchAllLocations(
      locationRepository: gh<_i167.LocationRepository>()));
  gh.lazySingleton<_i212.GetGroupsStream>(() =>
      _i212.GetGroupsStream(groupRepository: gh<_i164.GroupRepository>()));
  gh.factory<_i213.ItemActionBloc>(() => _i213.ItemActionBloc(
        authenticationBloc: gh<_i206.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i143.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i147.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i214.UserProfileBloc>(() => _i214.UserProfileBloc(
        authenticationBloc: gh<_i206.AuthenticationBloc>(),
        addUser: gh<_i72.AddUser>(),
        assignUserToCompany: gh<_i85.AssignUserToCompany>(),
        resetCompany: gh<_i173.ResetCompany>(),
        getUserById: gh<_i159.GetUserById>(),
        getUserStreamById: gh<_i160.GetUserStreamById>(),
        updateUserData: gh<_i194.UpdateUserData>(),
        addUserAvatar: gh<_i73.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.factory<_i215.WorkRequestCubit>(() => _i215.WorkRequestCubit(
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        getWorkRequestByIdUsecase: gh<_i161.GetWorkRequestById>(),
      ));
  gh.factory<_i216.WorkRequestManagementBloc>(
      () => _i216.WorkRequestManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addWorkRequest: gh<_i74.AddWorkRequest>(),
            deleteWorkRequest: gh<_i119.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i195.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i91.CancelWorkRequest>(),
          ));
  gh.factory<_i217.AssetActionBloc>(() => _i217.AssetActionBloc(
        authenticationBloc: gh<_i206.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i128.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i146.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i218.AssetActionManagementBloc>(
      () => _i218.AssetActionManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addAssetAction: gh<_i198.AddAssetAction>(),
            updateAssetAction: gh<_i188.UpdateAssetAction>(),
            deleteAssetAction: gh<_i106.DeleteAssetAction>(),
          ));
  gh.singleton<_i219.AssetCategoryBloc>(_i219.AssetCategoryBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i129.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i220.AssetCategoryManagementBloc>(
      () => _i220.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addAssetCategory: gh<_i199.AddAssetCategory>(),
            updateAssetCategory: gh<_i189.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i107.DeleteAssetCategory>(),
          ));
  gh.factory<_i221.AssetManagementBloc>(() => _i221.AssetManagementBloc(
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        addAsset: gh<_i197.AddAsset>(),
        deleteAsset: gh<_i105.DeleteAsset>(),
        updateAsset: gh<_i187.UpdateAsset>(),
      ));
  gh.factory<_i222.AssetPartsBloc>(() => _i222.AssetPartsBloc(
        authenticationBloc: gh<_i206.AuthenticationBloc>(),
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i131.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i223.ChecklistBloc>(_i223.ChecklistBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    getChecklistsStream: gh<_i134.GetChecklistStream>(),
  ));
  gh.factory<_i224.ChecklistManagementBloc>(() => _i224.ChecklistManagementBloc(
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        addChecklist: gh<_i200.AddChecklist>(),
        updateChecklist: gh<_i190.UpdateChecklist>(),
        deleteChecklist: gh<_i108.DeleteChecklist>(),
      ));
  gh.singleton<_i225.CompanyManagementBloc>(_i225.CompanyManagementBloc(
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    inputValidator: gh<_i8.InputValidator>(),
    addCompany: gh<_i201.AddCompany>(),
    fetchAllCompanies: gh<_i120.FetchAllCompanies>(),
    addCompanyLogo: gh<_i202.AddCompanyLogo>(),
    updateCompany: gh<_i191.UpdateCompany>(),
  ));
  gh.singleton<_i226.CompanyProfileBloc>(_i226.CompanyProfileBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i121.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i135.GetCompanyById>(),
    inputValidator: gh<_i8.InputValidator>(),
  ));
  gh.singleton<_i227.DeviceTokenCubit>(_i227.DeviceTokenCubit(
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    registerDeviceToken: gh<_i28.RegisterDeviceToken>(),
    removeDeviceToken: gh<_i29.RemoveDeviceToken>(),
  ));
  gh.singleton<_i228.GroupBloc>(_i228.GroupBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    companyProfileBloc: gh<_i226.CompanyProfileBloc>(),
    addGroup: gh<_i203.AddGroup>(),
    updateGroup: gh<_i192.UpdateGroup>(),
    deleteGroup: gh<_i209.DeleteGroup>(),
    getGroupsStream: gh<_i212.GetGroupsStream>(),
    cacheGroups: gh<_i207.CacheGroups>(),
    tryToGetCachedGroups: gh<_i181.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i229.InstructionCategoryBloc>(_i229.InstructionCategoryBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i141.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i230.InstructionCategoryManagementBloc>(
      () => _i230.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addInstructionCategory: gh<_i64.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i45.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i110.DeleteInstructionCategory>(),
          ));
  gh.factory<_i231.InstructionManagementBloc>(
      () => _i231.InstructionManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addInstruction: gh<_i63.AddInstruction>(),
            deleteInstruction: gh<_i109.DeleteInstruction>(),
            updateInstruction: gh<_i44.UpdateInstruction>(),
          ));
  gh.factory<_i232.ItemActionManagementBloc>(
      () => _i232.ItemActionManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addItemAction: gh<_i66.AddItemAction>(),
            updateItemAction: gh<_i47.UpdateItemAction>(),
            deleteItemAction: gh<_i112.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.singleton<_i233.ItemCategoryBloc>(_i233.ItemCategoryBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i144.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i234.ItemCategoryManagementBloc>(
      () => _i234.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addItemCategory: gh<_i67.AddItemCategory>(),
            updateItemCategory: gh<_i48.UpdateItemCategory>(),
            deleteItemCategory: gh<_i113.DeleteItemCategory>(),
          ));
  gh.factory<_i235.ItemsManagementBloc>(() => _i235.ItemsManagementBloc(
        addItemPhoto: gh<_i68.AddItemPhoto>(),
        deleteItemPhoto: gh<_i114.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i49.UpdateItemPhoto>(),
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        addItem: gh<_i65.AddItem>(),
        deleteItem: gh<_i111.DeleteItem>(),
        updateItem: gh<_i46.UpdateItem>(),
      ));
  gh.singleton<_i236.LocationBloc>(_i236.LocationBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    addLocation: gh<_i204.AddLocation>(),
    cacheLocation: gh<_i208.CacheLocation>(),
    deleteLocation: gh<_i210.DeleteLocation>(),
    fetchAllLocations: gh<_i211.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i182.TryToGetCachedLocation>(),
    updateLocation: gh<_i193.UpdateLocation>(),
  ));
  gh.singleton<_i237.NewUsersBloc>(_i237.NewUsersBloc(
    gh<_i226.CompanyProfileBloc>(),
    gh<_i122.FetchNewUsers>(),
  ));
  gh.lazySingleton<_i238.NotificationSettingsCubit>(
      () => _i238.NotificationSettingsCubit(
            gh<_i214.UserProfileBloc>(),
            gh<_i206.AuthenticationBloc>(),
            gh<_i151.GetNotificationSettings>(),
            gh<_i50.UpdateNotificationSettings>(),
          ));
  gh.lazySingleton<_i239.ShowcaseSettingsCubit>(
      () => _i239.ShowcaseSettingsCubit(
            gh<_i214.UserProfileBloc>(),
            gh<_i206.AuthenticationBloc>(),
            gh<_i153.GetShowcaseSettings>(),
            gh<_i51.UpdateShowcaseSettings>(),
            gh<_i240.StreamSubscription<dynamic>>(),
          ));
  gh.singleton<_i241.SuspendedUsersBloc>(_i241.SuspendedUsersBloc(
    gh<_i226.CompanyProfileBloc>(),
    gh<_i123.FetchSuspendedUsers>(),
  ));
  gh.factory<_i242.TaskActionManagementBloc>(
      () => _i242.TaskActionManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addTaskAction: gh<_i70.AddTaskAction>(),
            deleteTaskAction: gh<_i117.DeleteTaskAction>(),
            updateTaskAction: gh<_i53.UpdateTaskAction>(),
          ));
  gh.factory<_i243.TaskCubit>(() => _i243.TaskCubit(
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        getTaskByIdUsecase: gh<_i155.GetTaskById>(),
      ));
  gh.factory<_i244.TaskManagementBloc>(() => _i244.TaskManagementBloc(
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        addTask: gh<_i69.AddTask>(),
        deleteTask: gh<_i116.DeleteTask>(),
        updateTask: gh<_i52.UpdateTask>(),
        cancelTask: gh<_i90.CancelTask>(),
        completeTask: gh<_i100.CompleteTask>(),
      ));
  gh.lazySingleton<_i245.TaskTemplatesBloc>(() => _i245.TaskTemplatesBloc(
        authenticationBloc: gh<_i206.AuthenticationBloc>(),
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i158.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i246.TaskTemplatesManagementBloc>(
      () => _i246.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            addTaskTemplate: gh<_i71.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i54.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i118.DeleteTaskTemplate>(),
          ));
  gh.factory<_i247.TasksArchiveForAssetBloc>(
      () => _i247.TasksArchiveForAssetBloc(
            userProfileBloc: gh<_i214.UserProfileBloc>(),
            getTasksStreamForAsset: gh<_i126.GetArchiveTasksStreamForAsset>(),
          ));
  gh.factory<_i248.TasksForAssetBloc>(() => _i248.TasksForAssetBloc(
        userProfileBloc: gh<_i214.UserProfileBloc>(),
        getTasksStreamForAsset: gh<_i157.GetTasksStreamForAsset>(),
      ));
  gh.singleton<_i249.UcNotificationBloc>(_i249.UcNotificationBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    getNotifications: gh<_i152.GetNotifications>(),
  ));
  gh.factory<_i250.UcNotificationManagementBloc>(
      () => _i250.UcNotificationManagementBloc(
            markAsRead: gh<_i170.MarkAsRead>(),
            markAsUnread: gh<_i171.MarkAsUnread>(),
            deleteNotification: gh<_i115.DeleteNotification>(),
            userProfileBloc: gh<_i214.UserProfileBloc>(),
          ));
  gh.singleton<_i251.FilterBloc>(_i251.FilterBloc(
    locationBloc: gh<_i236.LocationBloc>(),
    groupBloc: gh<_i228.GroupBloc>(),
    userProfileBloc: gh<_i214.UserProfileBloc>(),
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
  ));
  gh.singleton<_i252.InstructionBloc>(_i252.InstructionBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getInstructionsStream: gh<_i142.GetInstructionsStream>(),
  ));
  gh.singleton<_i253.ItemsBloc>(_i253.ItemsBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getChecklistsStream: gh<_i145.GetItemsStream>(),
  ));
  gh.singleton<_i254.TaskActionsStatusBloc>(_i254.TaskActionsStatusBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getLatestTaskActions: gh<_i148.GetLatestTaskActions>(),
  ));
  gh.singleton<_i255.TaskArchiveBloc>(_i255.TaskArchiveBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveTasksStream: gh<_i125.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i256.TaskArchiveLatestBloc>(_i256.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i124.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i257.TaskBloc>(_i257.TaskBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getTasksStream: gh<_i156.GetTasksStream>(),
  ));
  gh.singleton<_i258.WorkRequestArchiveBloc>(_i258.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i127.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i259.WorkRequestBloc>(_i259.WorkRequestBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getWorkRequestsStream: gh<_i162.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i260.WorkRequestsStatusBloc>(_i260.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i132.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i136.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i133.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i261.ActivityBloc>(_i261.ActivityBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    workRequestBloc: gh<_i259.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i258.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i257.TaskBloc>(),
    taskArchiveBloc: gh<_i255.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i254.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i262.AssetBloc>(_i262.AssetBloc(
    filterBloc: gh<_i251.FilterBloc>(),
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    getAssetsStream: gh<_i130.GetAssetsStream>(),
  ));
  gh.singleton<_i263.CalendarTaskArchiveBloc>(_i263.CalendarTaskArchiveBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getArchiveTasksStream: gh<_i125.GetArchiveTasksStream>(),
  ));
  gh.lazySingleton<_i264.CalendarTaskBloc>(() => _i264.CalendarTaskBloc(
        authenticationBloc: gh<_i206.AuthenticationBloc>(),
        filterBloc: gh<_i251.FilterBloc>(),
        getTasksStream: gh<_i156.GetTasksStream>(),
      ));
  gh.singleton<_i265.DashboardAssetActionBloc>(_i265.DashboardAssetActionBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i137.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i139.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i266.DashboardItemActionBloc>(_i266.DashboardItemActionBloc(
    authenticationBloc: gh<_i206.AuthenticationBloc>(),
    filterBloc: gh<_i251.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i138.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i140.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i267.TaskFilterBloc>(_i267.TaskFilterBloc(
    gh<_i206.AuthenticationBloc>(),
    gh<_i214.UserProfileBloc>(),
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
