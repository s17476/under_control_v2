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
    as _i78;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i80;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i82;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i101;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i77;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i79;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i81;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i100;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i190;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i191;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i105;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i126;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i135;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i137;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i144;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i181;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i192;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i106;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i127;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i182;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i91;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i104;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i128;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i129;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i180;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i248;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i249;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i198;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i87;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i86;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i88;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i92;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i167;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i168;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i169;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i170;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i171;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i94;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i93;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i193;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i107;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i132;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i183;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i96;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i98;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i95;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i97;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i194;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i195;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i119;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i120;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i121;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i122;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i133;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i184;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i25;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i9;
import 'package:under_control_v2/features/dashboard/data/repositories/task_action_status_repository_impl.dart'
    as _i37;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i61;
import 'package:under_control_v2/features/dashboard/domain/repositories/task_action_status_repository.dart'
    as _i36;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i60;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i130;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i131;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i134;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i146;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i247;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i240;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i246;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i237;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i156;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i8;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i158;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i157;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i196;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i200;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i202;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i205;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i174;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i185;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i103;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i21;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i102;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i64;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i67;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i110;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i113;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i143;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i65;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i111;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i136;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i138;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i141;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i145;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i24;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i66;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i112;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i142;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i46;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i49;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i250;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i239;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i13;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i62;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i108;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i140;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i63;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i109;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i139;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i45;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i44;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i238;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i159;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i23;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i161;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i160;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i197;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i201;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i203;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i204;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i175;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i186;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i228;
import 'package:under_control_v2/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/notifications/data/repositories/uc_notification_repository_impl.dart'
    as _i43;
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart'
    as _i26;
import 'package:under_control_v2/features/notifications/domain/repositories/uc_notification_repository.dart'
    as _i42;
import 'package:under_control_v2/features/notifications/domain/usecases/delete_notification.dart'
    as _i114;
import 'package:under_control_v2/features/notifications/domain/usecases/get_notifications.dart'
    as _i149;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_read.dart'
    as _i163;
import 'package:under_control_v2/features/notifications/domain/usecases/mark_as_unread.dart'
    as _i164;
import 'package:under_control_v2/features/notifications/domain/usecases/register_device_token.dart'
    as _i30;
import 'package:under_control_v2/features/notifications/domain/usecases/remove_device_token.dart'
    as _i31;
import 'package:under_control_v2/features/notifications/presentation/blocs/bloc/uc_notification_bloc.dart'
    as _i236;
import 'package:under_control_v2/features/notifications/presentation/cubits/cubit/device_token_cubit.dart'
    as _i219;
import 'package:under_control_v2/features/settings/data/repositories/notification_settings_repository_impl.dart'
    as _i29;
import 'package:under_control_v2/features/settings/domain/repositories/notification_settings_repository.dart'
    as _i28;
import 'package:under_control_v2/features/settings/domain/usecases/get_notification_settings.dart'
    as _i148;
import 'package:under_control_v2/features/settings/domain/usecases/update_notification_settings.dart'
    as _i50;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i22;
import 'package:under_control_v2/features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart'
    as _i230;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i35;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i39;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i41;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i59;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i34;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i40;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i58;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i68;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i89;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i99;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i115;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i123;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i124;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i151;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i51;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i69;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i116;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i147;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i150;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i52;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i70;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i117;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i152;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i53;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i73;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i90;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i118;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i125;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i155;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i188;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i32;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i243;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i173;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i241;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i242;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i251;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i234;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i235;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i245;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i244;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i55;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i57;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i54;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i56;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i71;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i72;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i74;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i75;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i76;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i83;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i84;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i85;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i153;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i154;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i162;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i165;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i166;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i172;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i176;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i177;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i178;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i179;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i187;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i189;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i207;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i253;
import 'features/core/injectable_modules/injectable_modules.dart' as _i252;

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
  gh.lazySingleton<_i42.UcNotificationRepository>(() =>
      _i43.UcNotificationRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i44.UpdateInstruction>(() =>
      _i44.UpdateInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i45.UpdateInstructionCategory>(() =>
      _i45.UpdateInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i46.UpdateItem>(
      () => _i46.UpdateItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i47.UpdateItemAction>(
      () => _i47.UpdateItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i48.UpdateItemCategory>(() =>
      _i48.UpdateItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i49.UpdateItemPhoto>(
      () => _i49.UpdateItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i50.UpdateNotificationSettings>(() =>
      _i50.UpdateNotificationSettings(
          repository: gh<_i28.NotificationSettingsRepository>()));
  gh.lazySingleton<_i51.UpdateTask>(
      () => _i51.UpdateTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i52.UpdateTaskAction>(
      () => _i52.UpdateTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i53.UpdateTaskTemplate>(() =>
      _i53.UpdateTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i54.UserFilesRepository>(() =>
      _i55.UserFilesRepositoryImpl(firebaseStorage: gh<_i7.FirebaseStorage>()));
  gh.lazySingleton<_i56.UserProfileRepository>(() =>
      _i57.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i58.WorkRequestsRepository>(
      () => _i59.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i60.WorkRequestsStatusRepository>(() =>
      _i61.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i62.AddInstruction>(
      () => _i62.AddInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i63.AddInstructionCategory>(() =>
      _i63.AddInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i64.AddItem>(
      () => _i64.AddItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i65.AddItemAction>(
      () => _i65.AddItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i66.AddItemCategory>(() =>
      _i66.AddItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i67.AddItemPhoto>(
      () => _i67.AddItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i68.AddTask>(
      () => _i68.AddTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i69.AddTaskAction>(
      () => _i69.AddTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i70.AddTaskTemplate>(() =>
      _i70.AddTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i71.AddUser>(
      () => _i71.AddUser(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i72.AddUserAvatar>(
      () => _i72.AddUserAvatar(repository: gh<_i54.UserFilesRepository>()));
  gh.lazySingleton<_i73.AddWorkRequest>(
      () => _i73.AddWorkRequest(repository: gh<_i58.WorkRequestsRepository>()));
  gh.lazySingleton<_i74.ApprovePassiveUser>(() =>
      _i74.ApprovePassiveUser(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i75.ApproveUser>(
      () => _i75.ApproveUser(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i76.ApproveUserAndMakeAdmin>(() =>
      _i76.ApproveUserAndMakeAdmin(
          repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i77.AssetActionRepository>(() =>
      _i78.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i79.AssetCategoryRepository>(() =>
      _i80.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i81.AssetRepository>(() => _i82.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i7.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i83.AssignGroupAdmin>(() =>
      _i83.AssignGroupAdmin(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i84.AssignUserToCompany>(() =>
      _i84.AssignUserToCompany(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i85.AssignUserToGroup>(() =>
      _i85.AssignUserToGroup(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i86.AuthenticationRepository>(
      () => _i87.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i25.NetworkInfo>(),
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseMessaging: gh<_i6.FirebaseMessaging>(),
          ));
  gh.lazySingleton<_i88.AutoSignin>(() => _i88.AutoSignin(
      authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i89.CancelTask>(
      () => _i89.CancelTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i90.CancelWorkRequest>(() =>
      _i90.CancelWorkRequest(repository: gh<_i58.WorkRequestsRepository>()));
  gh.lazySingleton<_i91.CheckCodeAvailability>(
      () => _i91.CheckCodeAvailability(repository: gh<_i81.AssetRepository>()));
  gh.lazySingleton<_i92.CheckEmailVerification>(() =>
      _i92.CheckEmailVerification(
          authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i93.CheckListsRepository>(() =>
      _i94.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i95.CompanyManagementRepository>(
      () => _i96.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i97.CompanyRepository>(() => _i98.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i99.CompleteTask>(
      () => _i99.CompleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i100.DashboardAssetActionRepository>(() =>
      _i101.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i102.DashboardItemActionRepository>(() =>
      _i103.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i104.DeleteAsset>(
      () => _i104.DeleteAsset(repository: gh<_i81.AssetRepository>()));
  gh.lazySingleton<_i105.DeleteAssetAction>(() =>
      _i105.DeleteAssetAction(repository: gh<_i77.AssetActionRepository>()));
  gh.lazySingleton<_i106.DeleteAssetCategory>(() => _i106.DeleteAssetCategory(
      repository: gh<_i79.AssetCategoryRepository>()));
  gh.lazySingleton<_i107.DeleteChecklist>(
      () => _i107.DeleteChecklist(repository: gh<_i93.CheckListsRepository>()));
  gh.lazySingleton<_i108.DeleteInstruction>(() =>
      _i108.DeleteInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i109.DeleteInstructionCategory>(() =>
      _i109.DeleteInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i110.DeleteItem>(
      () => _i110.DeleteItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i111.DeleteItemAction>(() =>
      _i111.DeleteItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i112.DeleteItemCategory>(() =>
      _i112.DeleteItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i113.DeleteItemPhoto>(
      () => _i113.DeleteItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i114.DeleteNotification>(() => _i114.DeleteNotification(
      repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i115.DeleteTask>(
      () => _i115.DeleteTask(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i116.DeleteTaskAction>(() =>
      _i116.DeleteTaskAction(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i117.DeleteTaskTemplate>(() =>
      _i117.DeleteTaskTemplate(repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i118.DeleteWorkRequest>(() =>
      _i118.DeleteWorkRequest(repository: gh<_i58.WorkRequestsRepository>()));
  gh.lazySingleton<_i119.FetchAllCompanies>(() => _i119.FetchAllCompanies(
      companyManagementRepository: gh<_i95.CompanyManagementRepository>()));
  gh.lazySingleton<_i120.FetchAllCompanyUsers>(() => _i120.FetchAllCompanyUsers(
      companyRepository: gh<_i97.CompanyRepository>()));
  gh.lazySingleton<_i121.FetchNewUsers>(() =>
      _i121.FetchNewUsers(companyRepository: gh<_i97.CompanyRepository>()));
  gh.lazySingleton<_i122.FetchSuspendedUsers>(() => _i122.FetchSuspendedUsers(
      companyRepository: gh<_i97.CompanyRepository>()));
  gh.lazySingleton<_i123.GetArchiveLatestTasksStream>(() =>
      _i123.GetArchiveLatestTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i124.GetArchiveTasksStream>(
      () => _i124.GetArchiveTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i125.GetArchiveWorkRequestsStream>(() =>
      _i125.GetArchiveWorkRequestsStream(
          repository: gh<_i58.WorkRequestsRepository>()));
  gh.lazySingleton<_i126.GetAssetActionsStream>(() =>
      _i126.GetAssetActionsStream(
          repository: gh<_i77.AssetActionRepository>()));
  gh.lazySingleton<_i127.GetAssetsCategoriesStream>(() =>
      _i127.GetAssetsCategoriesStream(
          repository: gh<_i79.AssetCategoryRepository>()));
  gh.lazySingleton<_i128.GetAssetsStream>(
      () => _i128.GetAssetsStream(repository: gh<_i81.AssetRepository>()));
  gh.lazySingleton<_i129.GetAssetsStreamForParent>(() =>
      _i129.GetAssetsStreamForParent(repository: gh<_i81.AssetRepository>()));
  gh.lazySingleton<_i130.GetAwaitingWorkRequestsCount>(() =>
      _i130.GetAwaitingWorkRequestsCount(
          repository: gh<_i60.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i131.GetCancelledWorkRequestsCount>(() =>
      _i131.GetCancelledWorkRequestsCount(
          repository: gh<_i60.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i132.GetChecklistStream>(() =>
      _i132.GetChecklistStream(repository: gh<_i93.CheckListsRepository>()));
  gh.lazySingleton<_i133.GetCompanyById>(() =>
      _i133.GetCompanyById(companyRepository: gh<_i97.CompanyRepository>()));
  gh.lazySingleton<_i134.GetConvertedWorkRequestsCount>(() =>
      _i134.GetConvertedWorkRequestsCount(
          repository: gh<_i60.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i135.GetDashboardAssetActionsStream>(() =>
      _i135.GetDashboardAssetActionsStream(
          repository: gh<_i100.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i136.GetDashboardItemsActionsStream>(() =>
      _i136.GetDashboardItemsActionsStream(
          repository: gh<_i102.DashboardItemActionRepository>()));
  gh.lazySingleton<_i137.GetDashboardLastFiveAssetActionsStream>(() =>
      _i137.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i100.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i138.GetDashboardLastFiveItemsActionsStream>(() =>
      _i138.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i102.DashboardItemActionRepository>()));
  gh.lazySingleton<_i139.GetInstructionsCategoriesStream>(() =>
      _i139.GetInstructionsCategoriesStream(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i140.GetInstructionsStream>(() =>
      _i140.GetInstructionsStream(
          repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i141.GetItemsActionsStream>(() =>
      _i141.GetItemsActionsStream(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i142.GetItemsCategoriesStream>(() =>
      _i142.GetItemsCategoriesStream(
          repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i143.GetItemsStream>(
      () => _i143.GetItemsStream(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i144.GetLastFiveAssetActionsStream>(() =>
      _i144.GetLastFiveAssetActionsStream(
          repository: gh<_i77.AssetActionRepository>()));
  gh.lazySingleton<_i145.GetLastFiveItemsActionsStream>(() =>
      _i145.GetLastFiveItemsActionsStream(
          repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i146.GetLatestTaskActions>(() => _i146.GetLatestTaskActions(
      repository: gh<_i36.TaskActionStatusRepository>()));
  gh.lazySingleton<_i147.GetLatestTaskActionsStream>(() =>
      _i147.GetLatestTaskActionsStream(
          repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i148.GetNotificationSettings>(() =>
      _i148.GetNotificationSettings(
          repository: gh<_i28.NotificationSettingsRepository>()));
  gh.lazySingleton<_i149.GetNotifications>(() =>
      _i149.GetNotifications(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i150.GetTaskActionsStream>(() =>
      _i150.GetTaskActionsStream(repository: gh<_i34.TaskActionRepository>()));
  gh.lazySingleton<_i151.GetTasksStream>(
      () => _i151.GetTasksStream(repository: gh<_i38.TaskRepository>()));
  gh.lazySingleton<_i152.GetTasksTemplatesStream>(() =>
      _i152.GetTasksTemplatesStream(
          repository: gh<_i40.TaskTemplatesRepository>()));
  gh.lazySingleton<_i153.GetUserById>(
      () => _i153.GetUserById(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i154.GetUserStreamById>(() => _i154.GetUserStreamById(
      userRepository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i155.GetWorkRequestsStream>(() =>
      _i155.GetWorkRequestsStream(
          repository: gh<_i58.WorkRequestsRepository>()));
  gh.lazySingleton<_i156.GroupLocalDataSource>(() =>
      _i156.GroupLocalDataSourceImpl(source: gh<_i33.SharedPreferences>()));
  gh.lazySingleton<_i157.GroupRepository>(() => _i158.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i8.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i156.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i159.LocationLocalDataSource>(() =>
      _i159.LocationLocalDataSourceImpl(source: gh<_i33.SharedPreferences>()));
  gh.lazySingleton<_i160.LocationRepository>(() => _i161.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i159.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i23.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i162.MakeUserAdministrator>(() =>
      _i162.MakeUserAdministrator(
          repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i163.MarkAsRead>(
      () => _i163.MarkAsRead(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i164.MarkAsUnread>(() =>
      _i164.MarkAsUnread(repository: gh<_i42.UcNotificationRepository>()));
  gh.lazySingleton<_i165.RejectUser>(
      () => _i165.RejectUser(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i166.ResetCompany>(
      () => _i166.ResetCompany(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i167.SendPasswordResetEmail>(() =>
      _i167.SendPasswordResetEmail(
          authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i168.SendVerificationEmail>(() =>
      _i168.SendVerificationEmail(
          authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i169.Signin>(() => _i169.Signin(
      authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i170.Signout>(() => _i170.Signout(
      authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i171.Signup>(() => _i171.Signup(
      authenticationRepository: gh<_i86.AuthenticationRepository>()));
  gh.lazySingleton<_i172.SuspendUser>(
      () => _i172.SuspendUser(repository: gh<_i56.UserProfileRepository>()));
  gh.factory<_i173.TaskActionBloc>(() => _i173.TaskActionBloc(
      getTaskActionsStream: gh<_i150.GetTaskActionsStream>()));
  gh.lazySingleton<_i174.TryToGetCachedGroups>(() =>
      _i174.TryToGetCachedGroups(groupRepository: gh<_i157.GroupRepository>()));
  gh.lazySingleton<_i175.TryToGetCachedLocation>(() =>
      _i175.TryToGetCachedLocation(
          locationRepository: gh<_i160.LocationRepository>()));
  gh.lazySingleton<_i176.UnassignGroupAdmin>(() =>
      _i176.UnassignGroupAdmin(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i177.UnassignUserFromGroup>(() =>
      _i177.UnassignUserFromGroup(
          repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i178.UnmakeUserAdministrator>(() =>
      _i178.UnmakeUserAdministrator(
          repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i179.UnsuspendUser>(
      () => _i179.UnsuspendUser(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i180.UpdateAsset>(
      () => _i180.UpdateAsset(repository: gh<_i81.AssetRepository>()));
  gh.lazySingleton<_i181.UpdateAssetAction>(() =>
      _i181.UpdateAssetAction(repository: gh<_i77.AssetActionRepository>()));
  gh.lazySingleton<_i182.UpdateAssetCategory>(() => _i182.UpdateAssetCategory(
      repository: gh<_i79.AssetCategoryRepository>()));
  gh.lazySingleton<_i183.UpdateChecklist>(
      () => _i183.UpdateChecklist(repository: gh<_i93.CheckListsRepository>()));
  gh.lazySingleton<_i184.UpdateCompany>(() => _i184.UpdateCompany(
      companyRepository: gh<_i95.CompanyManagementRepository>()));
  gh.lazySingleton<_i185.UpdateGroup>(
      () => _i185.UpdateGroup(groupRepository: gh<_i157.GroupRepository>()));
  gh.lazySingleton<_i186.UpdateLocation>(() =>
      _i186.UpdateLocation(locationRepository: gh<_i160.LocationRepository>()));
  gh.lazySingleton<_i187.UpdateUserData>(
      () => _i187.UpdateUserData(repository: gh<_i56.UserProfileRepository>()));
  gh.lazySingleton<_i188.UpdateWorkRequest>(() =>
      _i188.UpdateWorkRequest(repository: gh<_i58.WorkRequestsRepository>()));
  gh.factory<_i189.UserManagementBloc>(() => _i189.UserManagementBloc(
        approveUser: gh<_i75.ApproveUser>(),
        approvePassiveUser: gh<_i74.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i162.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i178.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i76.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i165.RejectUser>(),
        suspendUser: gh<_i172.SuspendUser>(),
        unsuspendUser: gh<_i179.UnsuspendUser>(),
        updateUserData: gh<_i187.UpdateUserData>(),
        assignUserToGroup: gh<_i85.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i177.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i83.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i176.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i72.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i190.AddAsset>(
      () => _i190.AddAsset(repository: gh<_i81.AssetRepository>()));
  gh.lazySingleton<_i191.AddAssetAction>(
      () => _i191.AddAssetAction(repository: gh<_i77.AssetActionRepository>()));
  gh.lazySingleton<_i192.AddAssetCategory>(() =>
      _i192.AddAssetCategory(repository: gh<_i79.AssetCategoryRepository>()));
  gh.lazySingleton<_i193.AddChecklist>(
      () => _i193.AddChecklist(repository: gh<_i93.CheckListsRepository>()));
  gh.lazySingleton<_i194.AddCompany>(() => _i194.AddCompany(
      companyManagementRepository: gh<_i95.CompanyManagementRepository>()));
  gh.lazySingleton<_i195.AddCompanyLogo>(() =>
      _i195.AddCompanyLogo(repository: gh<_i95.CompanyManagementRepository>()));
  gh.lazySingleton<_i196.AddGroup>(
      () => _i196.AddGroup(groupRepository: gh<_i157.GroupRepository>()));
  gh.lazySingleton<_i197.AddLocation>(() =>
      _i197.AddLocation(locationRepository: gh<_i160.LocationRepository>()));
  gh.factory<_i198.AssetInternalNumberCubit>(
      () => _i198.AssetInternalNumberCubit(gh<_i91.CheckCodeAvailability>()));
  gh.lazySingleton<_i199.AuthenticationBloc>(() => _i199.AuthenticationBloc(
        signin: gh<_i169.Signin>(),
        signup: gh<_i171.Signup>(),
        signout: gh<_i170.Signout>(),
        autoSignin: gh<_i88.AutoSignin>(),
        sendVerificationEmail: gh<_i168.SendVerificationEmail>(),
        checkEmailVerification: gh<_i92.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i167.SendPasswordResetEmail>(),
        inputValidator: gh<_i9.InputValidator>(),
      ));
  gh.lazySingleton<_i200.CacheGroups>(
      () => _i200.CacheGroups(groupRepository: gh<_i157.GroupRepository>()));
  gh.lazySingleton<_i201.CacheLocation>(() =>
      _i201.CacheLocation(locationRepository: gh<_i160.LocationRepository>()));
  gh.lazySingleton<_i202.DeleteGroup>(
      () => _i202.DeleteGroup(groupRepository: gh<_i157.GroupRepository>()));
  gh.lazySingleton<_i203.DeleteLocation>(() =>
      _i203.DeleteLocation(locationRepository: gh<_i160.LocationRepository>()));
  gh.lazySingleton<_i204.FetchAllLocations>(() => _i204.FetchAllLocations(
      locationRepository: gh<_i160.LocationRepository>()));
  gh.lazySingleton<_i205.GetGroupsStream>(() =>
      _i205.GetGroupsStream(groupRepository: gh<_i157.GroupRepository>()));
  gh.factory<_i206.ItemActionBloc>(() => _i206.ItemActionBloc(
        authenticationBloc: gh<_i199.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i141.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i145.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i207.UserProfileBloc>(() => _i207.UserProfileBloc(
        authenticationBloc: gh<_i199.AuthenticationBloc>(),
        addUser: gh<_i71.AddUser>(),
        assignUserToCompany: gh<_i84.AssignUserToCompany>(),
        resetCompany: gh<_i166.ResetCompany>(),
        getUserById: gh<_i153.GetUserById>(),
        getUserStreamById: gh<_i154.GetUserStreamById>(),
        updateUserData: gh<_i187.UpdateUserData>(),
        addUserAvatar: gh<_i72.AddUserAvatar>(),
        inputValidator: gh<_i9.InputValidator>(),
      ));
  gh.factory<_i208.WorkRequestManagementBloc>(
      () => _i208.WorkRequestManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addWorkRequest: gh<_i73.AddWorkRequest>(),
            deleteWorkRequest: gh<_i118.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i188.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i90.CancelWorkRequest>(),
          ));
  gh.factory<_i209.AssetActionBloc>(() => _i209.AssetActionBloc(
        authenticationBloc: gh<_i199.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i126.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i144.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i210.AssetActionManagementBloc>(
      () => _i210.AssetActionManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addAssetAction: gh<_i191.AddAssetAction>(),
            updateAssetAction: gh<_i181.UpdateAssetAction>(),
            deleteAssetAction: gh<_i105.DeleteAssetAction>(),
          ));
  gh.singleton<_i211.AssetCategoryBloc>(_i211.AssetCategoryBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i127.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i212.AssetCategoryManagementBloc>(
      () => _i212.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addAssetCategory: gh<_i192.AddAssetCategory>(),
            updateAssetCategory: gh<_i182.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i106.DeleteAssetCategory>(),
          ));
  gh.factory<_i213.AssetManagementBloc>(() => _i213.AssetManagementBloc(
        userProfileBloc: gh<_i207.UserProfileBloc>(),
        addAsset: gh<_i190.AddAsset>(),
        deleteAsset: gh<_i104.DeleteAsset>(),
        updateAsset: gh<_i180.UpdateAsset>(),
      ));
  gh.factory<_i214.AssetPartsBloc>(() => _i214.AssetPartsBloc(
        authenticationBloc: gh<_i199.AuthenticationBloc>(),
        userProfileBloc: gh<_i207.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i129.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i215.ChecklistBloc>(_i215.ChecklistBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    getChecklistsStream: gh<_i132.GetChecklistStream>(),
  ));
  gh.factory<_i216.ChecklistManagementBloc>(() => _i216.ChecklistManagementBloc(
        userProfileBloc: gh<_i207.UserProfileBloc>(),
        addChecklist: gh<_i193.AddChecklist>(),
        updateChecklist: gh<_i183.UpdateChecklist>(),
        deleteChecklist: gh<_i107.DeleteChecklist>(),
      ));
  gh.singleton<_i217.CompanyManagementBloc>(_i217.CompanyManagementBloc(
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    inputValidator: gh<_i9.InputValidator>(),
    addCompany: gh<_i194.AddCompany>(),
    fetchAllCompanies: gh<_i119.FetchAllCompanies>(),
    addCompanyLogo: gh<_i195.AddCompanyLogo>(),
    updateCompany: gh<_i184.UpdateCompany>(),
  ));
  gh.singleton<_i218.CompanyProfileBloc>(_i218.CompanyProfileBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i120.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i133.GetCompanyById>(),
    inputValidator: gh<_i9.InputValidator>(),
  ));
  gh.singleton<_i219.DeviceTokenCubit>(_i219.DeviceTokenCubit(
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    registerDeviceToken: gh<_i30.RegisterDeviceToken>(),
    removeDeviceToken: gh<_i31.RemoveDeviceToken>(),
  ));
  gh.singleton<_i220.GroupBloc>(_i220.GroupBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    companyProfileBloc: gh<_i218.CompanyProfileBloc>(),
    addGroup: gh<_i196.AddGroup>(),
    updateGroup: gh<_i185.UpdateGroup>(),
    deleteGroup: gh<_i202.DeleteGroup>(),
    getGroupsStream: gh<_i205.GetGroupsStream>(),
    cacheGroups: gh<_i200.CacheGroups>(),
    tryToGetCachedGroups: gh<_i174.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i221.InstructionCategoryBloc>(_i221.InstructionCategoryBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i139.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i222.InstructionCategoryManagementBloc>(
      () => _i222.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addInstructionCategory: gh<_i63.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i45.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i109.DeleteInstructionCategory>(),
          ));
  gh.factory<_i223.InstructionManagementBloc>(
      () => _i223.InstructionManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addInstruction: gh<_i62.AddInstruction>(),
            deleteInstruction: gh<_i108.DeleteInstruction>(),
            updateInstruction: gh<_i44.UpdateInstruction>(),
          ));
  gh.factory<_i224.ItemActionManagementBloc>(
      () => _i224.ItemActionManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addItemAction: gh<_i65.AddItemAction>(),
            updateItemAction: gh<_i47.UpdateItemAction>(),
            deleteItemAction: gh<_i111.DeleteItemAction>(),
            moveItemAction: gh<_i24.MoveItemAction>(),
          ));
  gh.singleton<_i225.ItemCategoryBloc>(_i225.ItemCategoryBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i142.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i226.ItemCategoryManagementBloc>(
      () => _i226.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addItemCategory: gh<_i66.AddItemCategory>(),
            updateItemCategory: gh<_i48.UpdateItemCategory>(),
            deleteItemCategory: gh<_i112.DeleteItemCategory>(),
          ));
  gh.factory<_i227.ItemsManagementBloc>(() => _i227.ItemsManagementBloc(
        addItemPhoto: gh<_i67.AddItemPhoto>(),
        deleteItemPhoto: gh<_i113.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i49.UpdateItemPhoto>(),
        userProfileBloc: gh<_i207.UserProfileBloc>(),
        addItem: gh<_i64.AddItem>(),
        deleteItem: gh<_i110.DeleteItem>(),
        updateItem: gh<_i46.UpdateItem>(),
      ));
  gh.singleton<_i228.LocationBloc>(_i228.LocationBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    addLocation: gh<_i197.AddLocation>(),
    cacheLocation: gh<_i201.CacheLocation>(),
    deleteLocation: gh<_i203.DeleteLocation>(),
    fetchAllLocations: gh<_i204.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i175.TryToGetCachedLocation>(),
    updateLocation: gh<_i186.UpdateLocation>(),
  ));
  gh.singleton<_i229.NewUsersBloc>(_i229.NewUsersBloc(
    gh<_i218.CompanyProfileBloc>(),
    gh<_i121.FetchNewUsers>(),
  ));
  gh.lazySingleton<_i230.NotificationSettingsCubit>(
      () => _i230.NotificationSettingsCubit(
            gh<_i207.UserProfileBloc>(),
            gh<_i199.AuthenticationBloc>(),
            gh<_i148.GetNotificationSettings>(),
            gh<_i50.UpdateNotificationSettings>(),
          ));
  gh.singleton<_i231.SuspendedUsersBloc>(_i231.SuspendedUsersBloc(
    gh<_i218.CompanyProfileBloc>(),
    gh<_i122.FetchSuspendedUsers>(),
  ));
  gh.factory<_i232.TaskActionManagementBloc>(
      () => _i232.TaskActionManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addTaskAction: gh<_i69.AddTaskAction>(),
            deleteTaskAction: gh<_i116.DeleteTaskAction>(),
            updateTaskAction: gh<_i52.UpdateTaskAction>(),
          ));
  gh.factory<_i233.TaskManagementBloc>(() => _i233.TaskManagementBloc(
        userProfileBloc: gh<_i207.UserProfileBloc>(),
        addTask: gh<_i68.AddTask>(),
        deleteTask: gh<_i115.DeleteTask>(),
        updateTask: gh<_i51.UpdateTask>(),
        cancelTask: gh<_i89.CancelTask>(),
        completeTask: gh<_i99.CompleteTask>(),
      ));
  gh.lazySingleton<_i234.TaskTemplatesBloc>(() => _i234.TaskTemplatesBloc(
        authenticationBloc: gh<_i199.AuthenticationBloc>(),
        userProfileBloc: gh<_i207.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i152.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i235.TaskTemplatesManagementBloc>(
      () => _i235.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i207.UserProfileBloc>(),
            addTaskTemplate: gh<_i70.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i53.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i117.DeleteTaskTemplate>(),
          ));
  gh.singleton<_i236.UcNotificationBloc>(_i236.UcNotificationBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    getNotifications: gh<_i149.GetNotifications>(),
    markAsRead: gh<_i163.MarkAsRead>(),
    markAsUnread: gh<_i164.MarkAsUnread>(),
    deleteNotification: gh<_i114.DeleteNotification>(),
  ));
  gh.singleton<_i237.FilterBloc>(_i237.FilterBloc(
    locationBloc: gh<_i228.LocationBloc>(),
    groupBloc: gh<_i220.GroupBloc>(),
    userProfileBloc: gh<_i207.UserProfileBloc>(),
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
  ));
  gh.singleton<_i238.InstructionBloc>(_i238.InstructionBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getInstructionsStream: gh<_i140.GetInstructionsStream>(),
  ));
  gh.singleton<_i239.ItemsBloc>(_i239.ItemsBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getChecklistsStream: gh<_i143.GetItemsStream>(),
  ));
  gh.singleton<_i240.TaskActionsStatusBloc>(_i240.TaskActionsStatusBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getLatestTaskActions: gh<_i146.GetLatestTaskActions>(),
  ));
  gh.singleton<_i241.TaskArchiveBloc>(_i241.TaskArchiveBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getArchiveTasksStream: gh<_i124.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i242.TaskArchiveLatestBloc>(_i242.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i123.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i243.TaskBloc>(_i243.TaskBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getTasksStream: gh<_i151.GetTasksStream>(),
  ));
  gh.singleton<_i244.WorkRequestArchiveBloc>(_i244.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i125.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i245.WorkRequestBloc>(_i245.WorkRequestBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getWorkRequestsStream: gh<_i155.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i246.WorkRequestsStatusBloc>(_i246.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i130.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i134.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i131.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i247.ActivityBloc>(_i247.ActivityBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    workRequestBloc: gh<_i245.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i244.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i243.TaskBloc>(),
    taskArchiveBloc: gh<_i241.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i240.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i248.AssetBloc>(_i248.AssetBloc(
    filterBloc: gh<_i237.FilterBloc>(),
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    getAssetsStream: gh<_i128.GetAssetsStream>(),
  ));
  gh.singleton<_i249.DashboardAssetActionBloc>(_i249.DashboardAssetActionBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i135.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i137.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i250.DashboardItemActionBloc>(_i250.DashboardItemActionBloc(
    authenticationBloc: gh<_i199.AuthenticationBloc>(),
    filterBloc: gh<_i237.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i136.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i138.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i251.TaskFilterBloc>(_i251.TaskFilterBloc(
    gh<_i199.AuthenticationBloc>(),
    gh<_i207.UserProfileBloc>(),
    gh<_i243.TaskBloc>(),
    gh<_i245.WorkRequestBloc>(),
  ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i252.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i252.FirebaseStorageService {}

class _$FirebaseMessagingService extends _i252.FirebaseMessagingService {}

class _$SharedPreferencesService extends _i252.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i253.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i253.DataConnectionCheckerModule {}
