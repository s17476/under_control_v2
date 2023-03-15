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
    as _i193;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i194;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i103;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i125;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i134;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i136;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i143;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i184;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i195;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i104;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i126;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i185;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i89;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i102;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i127;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i128;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i183;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i256;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i259;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i201;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i85;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i84;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i86;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i90;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i170;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i171;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i172;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i173;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i174;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i92;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i91;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i196;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i105;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i131;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i186;
import 'package:under_control_v2/features/checklists/presentation/blocs/Checklist/checklist_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i94;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i96;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i93;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i95;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i197;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i198;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i117;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i118;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i119;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i120;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i132;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i187;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i235;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/dashboard/data/repositories/task_action_status_repository_impl.dart'
    as _i35;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i59;
import 'package:under_control_v2/features/dashboard/domain/repositories/task_action_status_repository.dart'
    as _i34;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i58;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i129;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i130;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i133;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i145;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i255;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i248;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i254;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i245;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i159;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i161;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i160;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i199;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i203;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i205;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i208;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i177;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i188;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i101;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i100;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i62;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i65;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i108;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i111;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i142;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i63;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i109;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i135;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i137;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i140;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i144;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i45;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i64;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i110;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i141;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i44;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i260;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i228;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i230;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i247;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i60;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i106;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i139;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i61;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i107;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i138;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i43;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i42;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i246;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i162;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i164;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i163;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i200;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i204;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i206;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i207;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i178;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i189;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i25;
import 'package:under_control_v2/features/notifications/data/repositories/uc_notification_repository_impl.dart'
    as _i41;
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart'
    as _i24;
import 'package:under_control_v2/features/notifications/domain/repositories/uc_notification_repository.dart'
    as _i40;
import 'package:under_control_v2/features/notifications/domain/usecases/delete_notification.dart'
    as _i112;
import 'package:under_control_v2/features/notifications/domain/usecases/get_notifications.dart'
    as _i149;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_read.dart'
    as _i166;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_unread.dart'
    as _i167;
import 'package:under_control_v2/features/notifications/domain/usecases/register_device_token.dart'
    as _i28;
import 'package:under_control_v2/features/notifications/domain/usecases/remove_device_token.dart'
    as _i29;
import 'package:under_control_v2/features/notifications/presentation/blocs/uc_notification/uc_notification_bloc.dart'
    as _i243;
import 'package:under_control_v2/features/notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart'
    as _i244;
import 'package:under_control_v2/features/notifications/presentation/cubits/cubit/device_token_cubit.dart'
    as _i223;
import 'package:under_control_v2/features/settings/data/repositories/notification_settings_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/settings/domain/repositories/notification_settings_repository.dart'
    as _i26;
import 'package:under_control_v2/features/settings/domain/usecases/get_notification_settings.dart'
    as _i148;
import 'package:under_control_v2/features/settings/domain/usecases/update_notification_settings.dart'
    as _i48;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i21;
import 'package:under_control_v2/features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart'
    as _i234;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i33;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i37;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i39;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i57;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i32;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i36;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i56;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i66;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i87;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i97;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i113;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i121;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i122;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream_for_asset.dart'
    as _i123;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_task_by_id.dart'
    as _i151;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i152;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream_for_asset.dart'
    as _i153;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i49;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i67;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i114;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i146;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_live_task_action_stream.dart'
    as _i147;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i150;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i50;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i68;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i115;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i154;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i51;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i71;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i88;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i116;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i124;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_request_by_id.dart'
    as _i157;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i158;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i191;
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_event/calendar_event_bloc.dart'
    as _i262;
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task/calendar_task_bloc.dart'
    as _i258;
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task_archive/calenddar_task_archive_bloc.dart'
    as _i257;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i30;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i251;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i176;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i236;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i249;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i250;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i261;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i238;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i239;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i240;
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_archive_for_asset/tasks_archive_for_asset_bloc.dart'
    as _i241;
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_for_asset/tasks_for_asset_bloc.dart'
    as _i242;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i253;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i252;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/tasks/presentation/cubits/task/task_cubit.dart'
    as _i237;
import 'package:under_control_v2/features/tasks/presentation/cubits/workRequest/work_request_cubit.dart'
    as _i211;
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
    as _i155;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i156;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i165;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i168;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i169;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i175;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i179;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i180;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i181;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i182;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i190;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i192;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i210;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i264;
import 'features/core/injectable_modules/injectable_modules.dart' as _i263;

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
  gh.lazySingleton<_i32.TaskActionRepository>(
      () => _i33.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i34.TaskActionStatusRepository>(() =>
      _i35.TaskActionStatusRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i36.TaskRepository>(() => _i37.TaskRepositoryImpl(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i38.TaskTemplatesRepository>(
      () => _i39.TaskTemplatesRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i40.UcNotificationRepository>(() =>
      _i41.UcNotificationRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i42.UpdateInstruction>(() =>
      _i42.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i43.UpdateInstructionCategory>(() =>
      _i43.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i44.UpdateItem>(
      () => _i44.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i45.UpdateItemAction>(
      () => _i45.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i46.UpdateItemCategory>(() =>
      _i46.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i47.UpdateItemPhoto>(
      () => _i47.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i48.UpdateNotificationSettings>(() =>
      _i48.UpdateNotificationSettings(
          repository: gh<_i26.NotificationSettingsRepository>()));
  gh.lazySingleton<_i49.UpdateTask>(
      () => _i49.UpdateTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i50.UpdateTaskAction>(
      () => _i50.UpdateTaskAction(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i51.UpdateTaskTemplate>(() =>
      _i51.UpdateTaskTemplate(repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i52.UserFilesRepository>(() =>
      _i53.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i54.UserProfileRepository>(() =>
      _i55.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i56.WorkRequestsRepository>(
      () => _i57.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i58.WorkRequestsStatusRepository>(() =>
      _i59.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i60.AddInstruction>(
      () => _i60.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i61.AddInstructionCategory>(() =>
      _i61.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i62.AddItem>(
      () => _i62.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i63.AddItemAction>(
      () => _i63.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i64.AddItemCategory>(() =>
      _i64.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i65.AddItemPhoto>(
      () => _i65.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i66.AddTask>(
      () => _i66.AddTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i67.AddTaskAction>(
      () => _i67.AddTaskAction(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i68.AddTaskTemplate>(() =>
      _i68.AddTaskTemplate(repository: gh<_i38.TaskTemplatesRepository>()));
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
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i77.AssetCategoryRepository>(() =>
      _i78.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i79.AssetRepository>(() => _i80.AssetRepositoryImpl(
        firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i81.AssignGroupAdmin>(() =>
      _i81.AssignGroupAdmin(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i82.AssignUserToCompany>(() =>
      _i82.AssignUserToCompany(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i83.AssignUserToGroup>(() =>
      _i83.AssignUserToGroup(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i84.AuthenticationRepository>(
      () => _i85.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i3.FirebaseAuth>(),
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseMessaging: gh<_i5.FirebaseMessaging>(),
          ));
  gh.lazySingleton<_i86.AutoSignin>(() => _i86.AutoSignin(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i87.CancelTask>(
      () => _i87.CancelTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i88.CancelWorkRequest>(() =>
      _i88.CancelWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i89.CheckCodeAvailability>(
      () => _i89.CheckCodeAvailability(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i90.CheckEmailVerification>(() =>
      _i90.CheckEmailVerification(
          authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i91.CheckListsRepository>(() =>
      _i92.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i93.CompanyManagementRepository>(
      () => _i94.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i4.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i95.CompanyRepository>(() => _i96.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i97.CompleteTask>(
      () => _i97.CompleteTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i98.DashboardAssetActionRepository>(() =>
      _i99.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i100.DashboardItemActionRepository>(() =>
      _i101.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i102.DeleteAsset>(
      () => _i102.DeleteAsset(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i103.DeleteAssetAction>(() =>
      _i103.DeleteAssetAction(repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i104.DeleteAssetCategory>(() => _i104.DeleteAssetCategory(
      repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i105.DeleteChecklist>(
      () => _i105.DeleteChecklist(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i106.DeleteInstruction>(() =>
      _i106.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i107.DeleteInstructionCategory>(() =>
      _i107.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i108.DeleteItem>(
      () => _i108.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i109.DeleteItemAction>(() =>
      _i109.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i110.DeleteItemCategory>(() =>
      _i110.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i111.DeleteItemPhoto>(
      () => _i111.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i112.DeleteNotification>(() => _i112.DeleteNotification(
      repository: gh<_i40.UcNotificationRepository>()));
  gh.lazySingleton<_i113.DeleteTask>(
      () => _i113.DeleteTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i114.DeleteTaskAction>(() =>
      _i114.DeleteTaskAction(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i115.DeleteTaskTemplate>(() =>
      _i115.DeleteTaskTemplate(repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i116.DeleteWorkRequest>(() =>
      _i116.DeleteWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i117.FetchAllCompanies>(() => _i117.FetchAllCompanies(
      companyManagementRepository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i118.FetchAllCompanyUsers>(() => _i118.FetchAllCompanyUsers(
      companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i119.FetchNewUsers>(() =>
      _i119.FetchNewUsers(companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i120.FetchSuspendedUsers>(() => _i120.FetchSuspendedUsers(
      companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i121.GetArchiveLatestTasksStream>(() =>
      _i121.GetArchiveLatestTasksStream(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i122.GetArchiveTasksStream>(
      () => _i122.GetArchiveTasksStream(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i123.GetArchiveTasksStreamForAsset>(() =>
      _i123.GetArchiveTasksStreamForAsset(
          repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i124.GetArchiveWorkRequestsStream>(() =>
      _i124.GetArchiveWorkRequestsStream(
          repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i125.GetAssetActionsStream>(() =>
      _i125.GetAssetActionsStream(
          repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i126.GetAssetsCategoriesStream>(() =>
      _i126.GetAssetsCategoriesStream(
          repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i127.GetAssetsStream>(
      () => _i127.GetAssetsStream(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i128.GetAssetsStreamForParent>(() =>
      _i128.GetAssetsStreamForParent(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i129.GetAwaitingWorkRequestsCount>(() =>
      _i129.GetAwaitingWorkRequestsCount(
          repository: gh<_i58.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i130.GetCancelledWorkRequestsCount>(() =>
      _i130.GetCancelledWorkRequestsCount(
          repository: gh<_i58.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i131.GetChecklistStream>(() =>
      _i131.GetChecklistStream(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i132.GetCompanyById>(() =>
      _i132.GetCompanyById(companyRepository: gh<_i95.CompanyRepository>()));
  gh.lazySingleton<_i133.GetConvertedWorkRequestsCount>(() =>
      _i133.GetConvertedWorkRequestsCount(
          repository: gh<_i58.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i134.GetDashboardAssetActionsStream>(() =>
      _i134.GetDashboardAssetActionsStream(
          repository: gh<_i98.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i135.GetDashboardItemsActionsStream>(() =>
      _i135.GetDashboardItemsActionsStream(
          repository: gh<_i100.DashboardItemActionRepository>()));
  gh.lazySingleton<_i136.GetDashboardLastFiveAssetActionsStream>(() =>
      _i136.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i98.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i137.GetDashboardLastFiveItemsActionsStream>(() =>
      _i137.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i100.DashboardItemActionRepository>()));
  gh.lazySingleton<_i138.GetInstructionsCategoriesStream>(() =>
      _i138.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i139.GetInstructionsStream>(() =>
      _i139.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i140.GetItemsActionsStream>(() =>
      _i140.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i141.GetItemsCategoriesStream>(() =>
      _i141.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i142.GetItemsStream>(
      () => _i142.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i143.GetLastFiveAssetActionsStream>(() =>
      _i143.GetLastFiveAssetActionsStream(
          repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i144.GetLastFiveItemsActionsStream>(() =>
      _i144.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i145.GetLatestTaskActions>(() => _i145.GetLatestTaskActions(
      repository: gh<_i34.TaskActionStatusRepository>()));
  gh.lazySingleton<_i146.GetLatestTaskActionsStream>(() =>
      _i146.GetLatestTaskActionsStream(
          repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i147.GetLiveTaskActionsStream>(() =>
      _i147.GetLiveTaskActionsStream(
          repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i148.GetNotificationSettings>(() =>
      _i148.GetNotificationSettings(
          repository: gh<_i26.NotificationSettingsRepository>()));
  gh.lazySingleton<_i149.GetNotifications>(() =>
      _i149.GetNotifications(repository: gh<_i40.UcNotificationRepository>()));
  gh.lazySingleton<_i150.GetTaskActionsStream>(() =>
      _i150.GetTaskActionsStream(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i151.GetTaskById>(
      () => _i151.GetTaskById(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i152.GetTasksStream>(
      () => _i152.GetTasksStream(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i153.GetTasksStreamForAsset>(() =>
      _i153.GetTasksStreamForAsset(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i154.GetTasksTemplatesStream>(() =>
      _i154.GetTasksTemplatesStream(
          repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i155.GetUserById>(
      () => _i155.GetUserById(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i156.GetUserStreamById>(() => _i156.GetUserStreamById(
      userRepository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i157.GetWorkRequestById>(() =>
      _i157.GetWorkRequestById(repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i158.GetWorkRequestsStream>(() =>
      _i158.GetWorkRequestsStream(
          repository: gh<_i56.WorkRequestsRepository>()));
  gh.lazySingleton<_i159.GroupLocalDataSource>(() =>
      _i159.GroupLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i160.GroupRepository>(() => _i161.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i159.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i162.LocationLocalDataSource>(() =>
      _i162.LocationLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i163.LocationRepository>(() => _i164.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i162.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i165.MakeUserAdministrator>(() =>
      _i165.MakeUserAdministrator(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i166.MarkAsRead>(
      () => _i166.MarkAsRead(repository: gh<_i40.UcNotificationRepository>()));
  gh.lazySingleton<_i167.MarkAsUnread>(() =>
      _i167.MarkAsUnread(repository: gh<_i40.UcNotificationRepository>()));
  gh.lazySingleton<_i168.RejectUser>(
      () => _i168.RejectUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i169.ResetCompany>(
      () => _i169.ResetCompany(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i170.SendPasswordResetEmail>(() =>
      _i170.SendPasswordResetEmail(
          authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i171.SendVerificationEmail>(() =>
      _i171.SendVerificationEmail(
          authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i172.Signin>(() => _i172.Signin(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i173.Signout>(() => _i173.Signout(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i174.Signup>(() => _i174.Signup(
      authenticationRepository: gh<_i84.AuthenticationRepository>()));
  gh.lazySingleton<_i175.SuspendUser>(
      () => _i175.SuspendUser(repository: gh<_i54.UserProfileRepository>()));
  gh.factory<_i176.TaskActionBloc>(() => _i176.TaskActionBloc(
      getTaskActionsStream: gh<_i150.GetTaskActionsStream>()));
  gh.lazySingleton<_i177.TryToGetCachedGroups>(() =>
      _i177.TryToGetCachedGroups(groupRepository: gh<_i160.GroupRepository>()));
  gh.lazySingleton<_i178.TryToGetCachedLocation>(() =>
      _i178.TryToGetCachedLocation(
          locationRepository: gh<_i163.LocationRepository>()));
  gh.lazySingleton<_i179.UnassignGroupAdmin>(() =>
      _i179.UnassignGroupAdmin(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i180.UnassignUserFromGroup>(() =>
      _i180.UnassignUserFromGroup(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i181.UnmakeUserAdministrator>(() =>
      _i181.UnmakeUserAdministrator(
          repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i182.UnsuspendUser>(
      () => _i182.UnsuspendUser(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i183.UpdateAsset>(
      () => _i183.UpdateAsset(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i184.UpdateAssetAction>(() =>
      _i184.UpdateAssetAction(repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i185.UpdateAssetCategory>(() => _i185.UpdateAssetCategory(
      repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i186.UpdateChecklist>(
      () => _i186.UpdateChecklist(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i187.UpdateCompany>(() => _i187.UpdateCompany(
      companyRepository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i188.UpdateGroup>(
      () => _i188.UpdateGroup(groupRepository: gh<_i160.GroupRepository>()));
  gh.lazySingleton<_i189.UpdateLocation>(() =>
      _i189.UpdateLocation(locationRepository: gh<_i163.LocationRepository>()));
  gh.lazySingleton<_i190.UpdateUserData>(
      () => _i190.UpdateUserData(repository: gh<_i54.UserProfileRepository>()));
  gh.lazySingleton<_i191.UpdateWorkRequest>(() =>
      _i191.UpdateWorkRequest(repository: gh<_i56.WorkRequestsRepository>()));
  gh.factory<_i192.UserManagementBloc>(() => _i192.UserManagementBloc(
        approveUser: gh<_i73.ApproveUser>(),
        approvePassiveUser: gh<_i72.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i165.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i181.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i74.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i168.RejectUser>(),
        suspendUser: gh<_i175.SuspendUser>(),
        unsuspendUser: gh<_i182.UnsuspendUser>(),
        updateUserData: gh<_i190.UpdateUserData>(),
        assignUserToGroup: gh<_i83.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i180.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i81.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i179.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i70.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i193.AddAsset>(
      () => _i193.AddAsset(repository: gh<_i79.AssetRepository>()));
  gh.lazySingleton<_i194.AddAssetAction>(
      () => _i194.AddAssetAction(repository: gh<_i75.AssetActionRepository>()));
  gh.lazySingleton<_i195.AddAssetCategory>(() =>
      _i195.AddAssetCategory(repository: gh<_i77.AssetCategoryRepository>()));
  gh.lazySingleton<_i196.AddChecklist>(
      () => _i196.AddChecklist(repository: gh<_i91.CheckListsRepository>()));
  gh.lazySingleton<_i197.AddCompany>(() => _i197.AddCompany(
      companyManagementRepository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i198.AddCompanyLogo>(() =>
      _i198.AddCompanyLogo(repository: gh<_i93.CompanyManagementRepository>()));
  gh.lazySingleton<_i199.AddGroup>(
      () => _i199.AddGroup(groupRepository: gh<_i160.GroupRepository>()));
  gh.lazySingleton<_i200.AddLocation>(() =>
      _i200.AddLocation(locationRepository: gh<_i163.LocationRepository>()));
  gh.factory<_i201.AssetInternalNumberCubit>(
      () => _i201.AssetInternalNumberCubit(gh<_i89.CheckCodeAvailability>()));
  gh.lazySingleton<_i202.AuthenticationBloc>(() => _i202.AuthenticationBloc(
        signin: gh<_i172.Signin>(),
        signup: gh<_i174.Signup>(),
        signout: gh<_i173.Signout>(),
        autoSignin: gh<_i86.AutoSignin>(),
        sendVerificationEmail: gh<_i171.SendVerificationEmail>(),
        checkEmailVerification: gh<_i90.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i170.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i203.CacheGroups>(
      () => _i203.CacheGroups(groupRepository: gh<_i160.GroupRepository>()));
  gh.lazySingleton<_i204.CacheLocation>(() =>
      _i204.CacheLocation(locationRepository: gh<_i163.LocationRepository>()));
  gh.lazySingleton<_i205.DeleteGroup>(
      () => _i205.DeleteGroup(groupRepository: gh<_i160.GroupRepository>()));
  gh.lazySingleton<_i206.DeleteLocation>(() =>
      _i206.DeleteLocation(locationRepository: gh<_i163.LocationRepository>()));
  gh.lazySingleton<_i207.FetchAllLocations>(() => _i207.FetchAllLocations(
      locationRepository: gh<_i163.LocationRepository>()));
  gh.lazySingleton<_i208.GetGroupsStream>(() =>
      _i208.GetGroupsStream(groupRepository: gh<_i160.GroupRepository>()));
  gh.factory<_i209.ItemActionBloc>(() => _i209.ItemActionBloc(
        authenticationBloc: gh<_i202.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i140.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i144.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i210.UserProfileBloc>(() => _i210.UserProfileBloc(
        authenticationBloc: gh<_i202.AuthenticationBloc>(),
        addUser: gh<_i69.AddUser>(),
        assignUserToCompany: gh<_i82.AssignUserToCompany>(),
        resetCompany: gh<_i169.ResetCompany>(),
        getUserById: gh<_i155.GetUserById>(),
        getUserStreamById: gh<_i156.GetUserStreamById>(),
        updateUserData: gh<_i190.UpdateUserData>(),
        addUserAvatar: gh<_i70.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.factory<_i211.WorkRequestCubit>(() => _i211.WorkRequestCubit(
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        getWorkRequestByIdUsecase: gh<_i157.GetWorkRequestById>(),
      ));
  gh.factory<_i212.WorkRequestManagementBloc>(
      () => _i212.WorkRequestManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addWorkRequest: gh<_i71.AddWorkRequest>(),
            deleteWorkRequest: gh<_i116.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i191.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i88.CancelWorkRequest>(),
          ));
  gh.factory<_i213.AssetActionBloc>(() => _i213.AssetActionBloc(
        authenticationBloc: gh<_i202.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i125.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i143.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i214.AssetActionManagementBloc>(
      () => _i214.AssetActionManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addAssetAction: gh<_i194.AddAssetAction>(),
            updateAssetAction: gh<_i184.UpdateAssetAction>(),
            deleteAssetAction: gh<_i103.DeleteAssetAction>(),
          ));
  gh.singleton<_i215.AssetCategoryBloc>(_i215.AssetCategoryBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i126.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i216.AssetCategoryManagementBloc>(
      () => _i216.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addAssetCategory: gh<_i195.AddAssetCategory>(),
            updateAssetCategory: gh<_i185.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i104.DeleteAssetCategory>(),
          ));
  gh.factory<_i217.AssetManagementBloc>(() => _i217.AssetManagementBloc(
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        addAsset: gh<_i193.AddAsset>(),
        deleteAsset: gh<_i102.DeleteAsset>(),
        updateAsset: gh<_i183.UpdateAsset>(),
      ));
  gh.factory<_i218.AssetPartsBloc>(() => _i218.AssetPartsBloc(
        authenticationBloc: gh<_i202.AuthenticationBloc>(),
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i128.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i219.ChecklistBloc>(_i219.ChecklistBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    getChecklistsStream: gh<_i131.GetChecklistStream>(),
  ));
  gh.factory<_i220.ChecklistManagementBloc>(() => _i220.ChecklistManagementBloc(
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        addChecklist: gh<_i196.AddChecklist>(),
        updateChecklist: gh<_i186.UpdateChecklist>(),
        deleteChecklist: gh<_i105.DeleteChecklist>(),
      ));
  gh.singleton<_i221.CompanyManagementBloc>(_i221.CompanyManagementBloc(
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    inputValidator: gh<_i8.InputValidator>(),
    addCompany: gh<_i197.AddCompany>(),
    fetchAllCompanies: gh<_i117.FetchAllCompanies>(),
    addCompanyLogo: gh<_i198.AddCompanyLogo>(),
    updateCompany: gh<_i187.UpdateCompany>(),
  ));
  gh.singleton<_i222.CompanyProfileBloc>(_i222.CompanyProfileBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i118.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i132.GetCompanyById>(),
    inputValidator: gh<_i8.InputValidator>(),
  ));
  gh.singleton<_i223.DeviceTokenCubit>(_i223.DeviceTokenCubit(
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    registerDeviceToken: gh<_i28.RegisterDeviceToken>(),
    removeDeviceToken: gh<_i29.RemoveDeviceToken>(),
  ));
  gh.singleton<_i224.GroupBloc>(_i224.GroupBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    companyProfileBloc: gh<_i222.CompanyProfileBloc>(),
    addGroup: gh<_i199.AddGroup>(),
    updateGroup: gh<_i188.UpdateGroup>(),
    deleteGroup: gh<_i205.DeleteGroup>(),
    getGroupsStream: gh<_i208.GetGroupsStream>(),
    cacheGroups: gh<_i203.CacheGroups>(),
    tryToGetCachedGroups: gh<_i177.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i225.InstructionCategoryBloc>(_i225.InstructionCategoryBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i138.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i226.InstructionCategoryManagementBloc>(
      () => _i226.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addInstructionCategory: gh<_i61.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i43.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i107.DeleteInstructionCategory>(),
          ));
  gh.factory<_i227.InstructionManagementBloc>(
      () => _i227.InstructionManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addInstruction: gh<_i60.AddInstruction>(),
            deleteInstruction: gh<_i106.DeleteInstruction>(),
            updateInstruction: gh<_i42.UpdateInstruction>(),
          ));
  gh.factory<_i228.ItemActionManagementBloc>(
      () => _i228.ItemActionManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addItemAction: gh<_i63.AddItemAction>(),
            updateItemAction: gh<_i45.UpdateItemAction>(),
            deleteItemAction: gh<_i109.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.singleton<_i229.ItemCategoryBloc>(_i229.ItemCategoryBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i141.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i230.ItemCategoryManagementBloc>(
      () => _i230.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addItemCategory: gh<_i64.AddItemCategory>(),
            updateItemCategory: gh<_i46.UpdateItemCategory>(),
            deleteItemCategory: gh<_i110.DeleteItemCategory>(),
          ));
  gh.factory<_i231.ItemsManagementBloc>(() => _i231.ItemsManagementBloc(
        addItemPhoto: gh<_i65.AddItemPhoto>(),
        deleteItemPhoto: gh<_i111.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i47.UpdateItemPhoto>(),
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        addItem: gh<_i62.AddItem>(),
        deleteItem: gh<_i108.DeleteItem>(),
        updateItem: gh<_i44.UpdateItem>(),
      ));
  gh.singleton<_i232.LocationBloc>(_i232.LocationBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    addLocation: gh<_i200.AddLocation>(),
    cacheLocation: gh<_i204.CacheLocation>(),
    deleteLocation: gh<_i206.DeleteLocation>(),
    fetchAllLocations: gh<_i207.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i178.TryToGetCachedLocation>(),
    updateLocation: gh<_i189.UpdateLocation>(),
  ));
  gh.singleton<_i233.NewUsersBloc>(_i233.NewUsersBloc(
    gh<_i222.CompanyProfileBloc>(),
    gh<_i119.FetchNewUsers>(),
  ));
  gh.lazySingleton<_i234.NotificationSettingsCubit>(
      () => _i234.NotificationSettingsCubit(
            gh<_i210.UserProfileBloc>(),
            gh<_i202.AuthenticationBloc>(),
            gh<_i148.GetNotificationSettings>(),
            gh<_i48.UpdateNotificationSettings>(),
          ));
  gh.singleton<_i235.SuspendedUsersBloc>(_i235.SuspendedUsersBloc(
    gh<_i222.CompanyProfileBloc>(),
    gh<_i120.FetchSuspendedUsers>(),
  ));
  gh.factory<_i236.TaskActionManagementBloc>(
      () => _i236.TaskActionManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addTaskAction: gh<_i67.AddTaskAction>(),
            deleteTaskAction: gh<_i114.DeleteTaskAction>(),
            updateTaskAction: gh<_i50.UpdateTaskAction>(),
          ));
  gh.factory<_i237.TaskCubit>(() => _i237.TaskCubit(
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        getTaskByIdUsecase: gh<_i151.GetTaskById>(),
      ));
  gh.factory<_i238.TaskManagementBloc>(() => _i238.TaskManagementBloc(
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        addTask: gh<_i66.AddTask>(),
        deleteTask: gh<_i113.DeleteTask>(),
        updateTask: gh<_i49.UpdateTask>(),
        cancelTask: gh<_i87.CancelTask>(),
        completeTask: gh<_i97.CompleteTask>(),
      ));
  gh.lazySingleton<_i239.TaskTemplatesBloc>(() => _i239.TaskTemplatesBloc(
        authenticationBloc: gh<_i202.AuthenticationBloc>(),
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i154.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i240.TaskTemplatesManagementBloc>(
      () => _i240.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            addTaskTemplate: gh<_i68.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i51.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i115.DeleteTaskTemplate>(),
          ));
  gh.factory<_i241.TasksArchiveForAssetBloc>(
      () => _i241.TasksArchiveForAssetBloc(
            userProfileBloc: gh<_i210.UserProfileBloc>(),
            getTasksStreamForAsset: gh<_i123.GetArchiveTasksStreamForAsset>(),
          ));
  gh.factory<_i242.TasksForAssetBloc>(() => _i242.TasksForAssetBloc(
        userProfileBloc: gh<_i210.UserProfileBloc>(),
        getTasksStreamForAsset: gh<_i153.GetTasksStreamForAsset>(),
      ));
  gh.singleton<_i243.UcNotificationBloc>(_i243.UcNotificationBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    getNotifications: gh<_i149.GetNotifications>(),
  ));
  gh.factory<_i244.UcNotificationManagementBloc>(
      () => _i244.UcNotificationManagementBloc(
            markAsRead: gh<_i166.MarkAsRead>(),
            markAsUnread: gh<_i167.MarkAsUnread>(),
            deleteNotification: gh<_i112.DeleteNotification>(),
            userProfileBloc: gh<_i210.UserProfileBloc>(),
          ));
  gh.singleton<_i245.FilterBloc>(_i245.FilterBloc(
    locationBloc: gh<_i232.LocationBloc>(),
    groupBloc: gh<_i224.GroupBloc>(),
    userProfileBloc: gh<_i210.UserProfileBloc>(),
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
  ));
  gh.singleton<_i246.InstructionBloc>(_i246.InstructionBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getInstructionsStream: gh<_i139.GetInstructionsStream>(),
  ));
  gh.singleton<_i247.ItemsBloc>(_i247.ItemsBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getChecklistsStream: gh<_i142.GetItemsStream>(),
  ));
  gh.singleton<_i248.TaskActionsStatusBloc>(_i248.TaskActionsStatusBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getLatestTaskActions: gh<_i145.GetLatestTaskActions>(),
  ));
  gh.singleton<_i249.TaskArchiveBloc>(_i249.TaskArchiveBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getArchiveTasksStream: gh<_i122.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i250.TaskArchiveLatestBloc>(_i250.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i121.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i251.TaskBloc>(_i251.TaskBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getTasksStream: gh<_i152.GetTasksStream>(),
  ));
  gh.singleton<_i252.WorkRequestArchiveBloc>(_i252.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i124.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i253.WorkRequestBloc>(_i253.WorkRequestBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getWorkRequestsStream: gh<_i158.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i254.WorkRequestsStatusBloc>(_i254.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i129.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i133.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i130.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i255.ActivityBloc>(_i255.ActivityBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    workRequestBloc: gh<_i253.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i252.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i251.TaskBloc>(),
    taskArchiveBloc: gh<_i249.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i248.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i256.AssetBloc>(_i256.AssetBloc(
    filterBloc: gh<_i245.FilterBloc>(),
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    getAssetsStream: gh<_i127.GetAssetsStream>(),
  ));
  gh.singleton<_i257.CalendarTaskArchiveBloc>(_i257.CalendarTaskArchiveBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getArchiveTasksStream: gh<_i122.GetArchiveTasksStream>(),
  ));
  gh.lazySingleton<_i258.CalendarTaskBloc>(() => _i258.CalendarTaskBloc(
        authenticationBloc: gh<_i202.AuthenticationBloc>(),
        filterBloc: gh<_i245.FilterBloc>(),
        getTasksStream: gh<_i152.GetTasksStream>(),
      ));
  gh.singleton<_i259.DashboardAssetActionBloc>(_i259.DashboardAssetActionBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i134.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i136.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i260.DashboardItemActionBloc>(_i260.DashboardItemActionBloc(
    authenticationBloc: gh<_i202.AuthenticationBloc>(),
    filterBloc: gh<_i245.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i135.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i137.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i261.TaskFilterBloc>(_i261.TaskFilterBloc(
    gh<_i202.AuthenticationBloc>(),
    gh<_i210.UserProfileBloc>(),
    gh<_i251.TaskBloc>(),
    gh<_i253.WorkRequestBloc>(),
  ));
  gh.lazySingleton<_i262.CalendarEventBloc>(() => _i262.CalendarEventBloc(
        gh<_i258.CalendarTaskBloc>(),
        gh<_i257.CalendarTaskArchiveBloc>(),
        gh<_i245.FilterBloc>(),
      ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i263.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i263.FirebaseStorageService {}

class _$FirebaseMessagingService extends _i263.FirebaseMessagingService {}

class _$SharedPreferencesService extends _i263.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i264.FirebaseAuthenticationService {}
