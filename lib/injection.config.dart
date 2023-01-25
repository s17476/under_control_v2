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
import 'package:shared_preferences/shared_preferences.dart' as _i31;
import 'package:under_control_v2/features/assets/data/repositories/asset_action_repository_impl.dart'
    as _i73;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i75;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i77;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i96;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i72;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i74;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i76;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i95;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i180;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i181;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i100;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i120;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i129;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i131;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i138;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i171;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i182;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i101;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i121;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i172;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i86;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i99;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i122;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i123;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i170;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i236;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i237;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i188;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i82;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i81;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i83;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i87;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i157;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i158;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i159;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i160;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i161;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i189;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i89;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i88;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i183;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i102;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i126;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i173;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i91;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i93;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i90;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i92;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i184;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i185;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i113;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i114;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i115;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i116;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i127;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i174;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i25;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i9;
import 'package:under_control_v2/features/dashboard/data/repositories/task_action_status_repository_impl.dart'
    as _i35;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i56;
import 'package:under_control_v2/features/dashboard/domain/repositories/task_action_status_repository.dart'
    as _i34;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i55;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i124;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i125;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i128;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i140;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i235;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i228;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i234;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i148;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i8;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i150;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i149;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i186;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i190;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i192;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i195;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i164;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i175;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i98;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i21;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i97;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i59;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i62;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i105;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i108;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i137;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i60;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i106;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i130;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i132;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i135;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i139;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i24;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i43;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i61;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i107;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i136;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i44;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i42;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i45;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i238;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i13;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i57;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i103;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i134;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i58;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i104;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i133;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i41;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i40;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i151;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i23;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i153;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i152;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i187;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i191;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i193;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i194;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i165;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i176;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i27;
import 'package:under_control_v2/features/notifications/domain/repositories/notification_repository.dart'
    as _i26;
import 'package:under_control_v2/features/notifications/domain/usecases/register_device_token.dart'
    as _i28;
import 'package:under_control_v2/features/notifications/domain/usecases/remove_device_token.dart'
    as _i29;
import 'package:under_control_v2/features/notifications/presentation/cubits/cubit/device_token_cubit.dart'
    as _i209;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i22;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i33;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i37;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i39;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i54;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i32;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i36;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i53;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i63;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i84;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i94;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i109;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i117;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i118;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i143;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i46;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i64;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i110;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i141;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i142;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i47;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i65;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i111;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i144;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i48;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i68;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i85;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i112;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i119;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i147;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i178;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i30;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i163;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i230;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i239;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i50;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i52;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i49;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i51;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i66;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i67;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i69;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i70;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i71;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i78;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i79;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i80;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i145;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i146;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i154;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i155;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i156;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i162;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i166;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i167;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i168;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i169;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i177;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i179;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i197;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i241;
import 'features/core/injectable_modules/injectable_modules.dart' as _i240;

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
  gh.lazySingleton<_i28.RegisterDeviceToken>(() =>
      _i28.RegisterDeviceToken(repository: gh<_i26.NotificationRepository>()));
  gh.lazySingleton<_i29.RemoveDeviceToken>(() =>
      _i29.RemoveDeviceToken(repository: gh<_i26.NotificationRepository>()));
  gh.factory<_i30.ReservedSparePartsBloc>(() => _i30.ReservedSparePartsBloc());
  await gh.factoryAsync<_i31.SharedPreferences>(
    () => sharedPreferencesService.shaerdPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i32.TaskActionRepository>(
      () => _i33.TaskActionRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i34.TaskActionStatusRepository>(() =>
      _i35.TaskActionStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i36.TaskRepository>(() => _i37.TaskRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i7.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i38.TaskTemplatesRepository>(
      () => _i39.TaskTemplatesRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i40.UpdateInstruction>(() =>
      _i40.UpdateInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i41.UpdateInstructionCategory>(() =>
      _i41.UpdateInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i42.UpdateItem>(
      () => _i42.UpdateItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i43.UpdateItemAction>(
      () => _i43.UpdateItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i44.UpdateItemCategory>(() =>
      _i44.UpdateItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i45.UpdateItemPhoto>(
      () => _i45.UpdateItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i46.UpdateTask>(
      () => _i46.UpdateTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i47.UpdateTaskAction>(
      () => _i47.UpdateTaskAction(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i48.UpdateTaskTemplate>(() =>
      _i48.UpdateTaskTemplate(repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i49.UserFilesRepository>(() =>
      _i50.UserFilesRepositoryImpl(firebaseStorage: gh<_i7.FirebaseStorage>()));
  gh.lazySingleton<_i51.UserProfileRepository>(() =>
      _i52.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i53.WorkRequestsRepository>(
      () => _i54.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i55.WorkRequestsStatusRepository>(() =>
      _i56.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i57.AddInstruction>(
      () => _i57.AddInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i58.AddInstructionCategory>(() =>
      _i58.AddInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i59.AddItem>(
      () => _i59.AddItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i60.AddItemAction>(
      () => _i60.AddItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i61.AddItemCategory>(() =>
      _i61.AddItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i62.AddItemPhoto>(
      () => _i62.AddItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i63.AddTask>(
      () => _i63.AddTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i64.AddTaskAction>(
      () => _i64.AddTaskAction(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i65.AddTaskTemplate>(() =>
      _i65.AddTaskTemplate(repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i66.AddUser>(
      () => _i66.AddUser(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i67.AddUserAvatar>(
      () => _i67.AddUserAvatar(repository: gh<_i49.UserFilesRepository>()));
  gh.lazySingleton<_i68.AddWorkRequest>(
      () => _i68.AddWorkRequest(repository: gh<_i53.WorkRequestsRepository>()));
  gh.lazySingleton<_i69.ApprovePassiveUser>(() =>
      _i69.ApprovePassiveUser(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i70.ApproveUser>(
      () => _i70.ApproveUser(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i71.ApproveUserAndMakeAdmin>(() =>
      _i71.ApproveUserAndMakeAdmin(
          repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i72.AssetActionRepository>(() =>
      _i73.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i74.AssetCategoryRepository>(() =>
      _i75.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i76.AssetRepository>(() => _i77.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i7.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i78.AssignGroupAdmin>(() =>
      _i78.AssignGroupAdmin(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i79.AssignUserToCompany>(() =>
      _i79.AssignUserToCompany(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i80.AssignUserToGroup>(() =>
      _i80.AssignUserToGroup(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i81.AuthenticationRepository>(
      () => _i82.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i25.NetworkInfo>(),
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseMessaging: gh<_i6.FirebaseMessaging>(),
          ));
  gh.lazySingleton<_i83.AutoSignin>(() => _i83.AutoSignin(
      authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i84.CancelTask>(
      () => _i84.CancelTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i85.CancelWorkRequest>(() =>
      _i85.CancelWorkRequest(repository: gh<_i53.WorkRequestsRepository>()));
  gh.lazySingleton<_i86.CheckCodeAvailability>(
      () => _i86.CheckCodeAvailability(repository: gh<_i76.AssetRepository>()));
  gh.lazySingleton<_i87.CheckEmailVerification>(() =>
      _i87.CheckEmailVerification(
          authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i88.CheckListsRepository>(() =>
      _i89.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i90.CompanyManagementRepository>(
      () => _i91.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i7.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i92.CompanyRepository>(() => _i93.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i94.CompleteTask>(
      () => _i94.CompleteTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i95.DashboardAssetActionRepository>(() =>
      _i96.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i97.DashboardItemActionRepository>(() =>
      _i98.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i99.DeleteAsset>(
      () => _i99.DeleteAsset(repository: gh<_i76.AssetRepository>()));
  gh.lazySingleton<_i100.DeleteAssetAction>(() =>
      _i100.DeleteAssetAction(repository: gh<_i72.AssetActionRepository>()));
  gh.lazySingleton<_i101.DeleteAssetCategory>(() => _i101.DeleteAssetCategory(
      repository: gh<_i74.AssetCategoryRepository>()));
  gh.lazySingleton<_i102.DeleteChecklist>(
      () => _i102.DeleteChecklist(repository: gh<_i88.CheckListsRepository>()));
  gh.lazySingleton<_i103.DeleteInstruction>(() =>
      _i103.DeleteInstruction(repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i104.DeleteInstructionCategory>(() =>
      _i104.DeleteInstructionCategory(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i105.DeleteItem>(
      () => _i105.DeleteItem(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i106.DeleteItemAction>(() =>
      _i106.DeleteItemAction(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i107.DeleteItemCategory>(() =>
      _i107.DeleteItemCategory(repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i108.DeleteItemPhoto>(
      () => _i108.DeleteItemPhoto(repository: gh<_i18.ItemFilesRepository>()));
  gh.lazySingleton<_i109.DeleteTask>(
      () => _i109.DeleteTask(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i110.DeleteTaskAction>(() =>
      _i110.DeleteTaskAction(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i111.DeleteTaskTemplate>(() =>
      _i111.DeleteTaskTemplate(repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i112.DeleteWorkRequest>(() =>
      _i112.DeleteWorkRequest(repository: gh<_i53.WorkRequestsRepository>()));
  gh.lazySingleton<_i113.FetchAllCompanies>(() => _i113.FetchAllCompanies(
      companyManagementRepository: gh<_i90.CompanyManagementRepository>()));
  gh.lazySingleton<_i114.FetchAllCompanyUsers>(() => _i114.FetchAllCompanyUsers(
      companyRepository: gh<_i92.CompanyRepository>()));
  gh.lazySingleton<_i115.FetchNewUsers>(() =>
      _i115.FetchNewUsers(companyRepository: gh<_i92.CompanyRepository>()));
  gh.lazySingleton<_i116.FetchSuspendedUsers>(() => _i116.FetchSuspendedUsers(
      companyRepository: gh<_i92.CompanyRepository>()));
  gh.lazySingleton<_i117.GetArchiveLatestTasksStream>(() =>
      _i117.GetArchiveLatestTasksStream(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i118.GetArchiveTasksStream>(
      () => _i118.GetArchiveTasksStream(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i119.GetArchiveWorkRequestsStream>(() =>
      _i119.GetArchiveWorkRequestsStream(
          repository: gh<_i53.WorkRequestsRepository>()));
  gh.lazySingleton<_i120.GetAssetActionsStream>(() =>
      _i120.GetAssetActionsStream(
          repository: gh<_i72.AssetActionRepository>()));
  gh.lazySingleton<_i121.GetAssetsCategoriesStream>(() =>
      _i121.GetAssetsCategoriesStream(
          repository: gh<_i74.AssetCategoryRepository>()));
  gh.lazySingleton<_i122.GetAssetsStream>(
      () => _i122.GetAssetsStream(repository: gh<_i76.AssetRepository>()));
  gh.lazySingleton<_i123.GetAssetsStreamForParent>(() =>
      _i123.GetAssetsStreamForParent(repository: gh<_i76.AssetRepository>()));
  gh.lazySingleton<_i124.GetAwaitingWorkRequestsCount>(() =>
      _i124.GetAwaitingWorkRequestsCount(
          repository: gh<_i55.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i125.GetCancelledWorkRequestsCount>(() =>
      _i125.GetCancelledWorkRequestsCount(
          repository: gh<_i55.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i126.GetChecklistStream>(() =>
      _i126.GetChecklistStream(repository: gh<_i88.CheckListsRepository>()));
  gh.lazySingleton<_i127.GetCompanyById>(() =>
      _i127.GetCompanyById(companyRepository: gh<_i92.CompanyRepository>()));
  gh.lazySingleton<_i128.GetConvertedWorkRequestsCount>(() =>
      _i128.GetConvertedWorkRequestsCount(
          repository: gh<_i55.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i129.GetDashboardAssetActionsStream>(() =>
      _i129.GetDashboardAssetActionsStream(
          repository: gh<_i95.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i130.GetDashboardItemsActionsStream>(() =>
      _i130.GetDashboardItemsActionsStream(
          repository: gh<_i97.DashboardItemActionRepository>()));
  gh.lazySingleton<_i131.GetDashboardLastFiveAssetActionsStream>(() =>
      _i131.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i95.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i132.GetDashboardLastFiveItemsActionsStream>(() =>
      _i132.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i97.DashboardItemActionRepository>()));
  gh.lazySingleton<_i133.GetInstructionsCategoriesStream>(() =>
      _i133.GetInstructionsCategoriesStream(
          repository: gh<_i10.InstructionCategoryRepository>()));
  gh.lazySingleton<_i134.GetInstructionsStream>(() =>
      _i134.GetInstructionsStream(
          repository: gh<_i12.InstructionRepository>()));
  gh.lazySingleton<_i135.GetItemsActionsStream>(() =>
      _i135.GetItemsActionsStream(repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i136.GetItemsCategoriesStream>(() =>
      _i136.GetItemsCategoriesStream(
          repository: gh<_i16.ItemCategoryRepository>()));
  gh.lazySingleton<_i137.GetItemsStream>(
      () => _i137.GetItemsStream(repository: gh<_i20.ItemRepository>()));
  gh.lazySingleton<_i138.GetLastFiveAssetActionsStream>(() =>
      _i138.GetLastFiveAssetActionsStream(
          repository: gh<_i72.AssetActionRepository>()));
  gh.lazySingleton<_i139.GetLastFiveItemsActionsStream>(() =>
      _i139.GetLastFiveItemsActionsStream(
          repository: gh<_i14.ItemActionRepository>()));
  gh.lazySingleton<_i140.GetLatestTaskActions>(() => _i140.GetLatestTaskActions(
      repository: gh<_i34.TaskActionStatusRepository>()));
  gh.lazySingleton<_i141.GetLatestTaskActionsStream>(() =>
      _i141.GetLatestTaskActionsStream(
          repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i142.GetTaskActionsStream>(() =>
      _i142.GetTaskActionsStream(repository: gh<_i32.TaskActionRepository>()));
  gh.lazySingleton<_i143.GetTasksStream>(
      () => _i143.GetTasksStream(repository: gh<_i36.TaskRepository>()));
  gh.lazySingleton<_i144.GetTasksTemplatesStream>(() =>
      _i144.GetTasksTemplatesStream(
          repository: gh<_i38.TaskTemplatesRepository>()));
  gh.lazySingleton<_i145.GetUserById>(
      () => _i145.GetUserById(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i146.GetUserStreamById>(() => _i146.GetUserStreamById(
      userRepository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i147.GetWorkRequestsStream>(() =>
      _i147.GetWorkRequestsStream(
          repository: gh<_i53.WorkRequestsRepository>()));
  gh.lazySingleton<_i148.GroupLocalDataSource>(() =>
      _i148.GroupLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i149.GroupRepository>(() => _i150.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i8.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i148.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i151.LocationLocalDataSource>(() =>
      _i151.LocationLocalDataSourceImpl(source: gh<_i31.SharedPreferences>()));
  gh.lazySingleton<_i152.LocationRepository>(() => _i153.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i151.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i23.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i154.MakeUserAdministrator>(() =>
      _i154.MakeUserAdministrator(
          repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i155.RejectUser>(
      () => _i155.RejectUser(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i156.ResetCompany>(
      () => _i156.ResetCompany(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i157.SendPasswordResetEmail>(() =>
      _i157.SendPasswordResetEmail(
          authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i158.SendVerificationEmail>(() =>
      _i158.SendVerificationEmail(
          authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i159.Signin>(() => _i159.Signin(
      authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i160.Signout>(() => _i160.Signout(
      authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i161.Signup>(() => _i161.Signup(
      authenticationRepository: gh<_i81.AuthenticationRepository>()));
  gh.lazySingleton<_i162.SuspendUser>(
      () => _i162.SuspendUser(repository: gh<_i51.UserProfileRepository>()));
  gh.factory<_i163.TaskActionBloc>(() => _i163.TaskActionBloc(
      getTaskActionsStream: gh<_i142.GetTaskActionsStream>()));
  gh.lazySingleton<_i164.TryToGetCachedGroups>(() =>
      _i164.TryToGetCachedGroups(groupRepository: gh<_i149.GroupRepository>()));
  gh.lazySingleton<_i165.TryToGetCachedLocation>(() =>
      _i165.TryToGetCachedLocation(
          locationRepository: gh<_i152.LocationRepository>()));
  gh.lazySingleton<_i166.UnassignGroupAdmin>(() =>
      _i166.UnassignGroupAdmin(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i167.UnassignUserFromGroup>(() =>
      _i167.UnassignUserFromGroup(
          repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i168.UnmakeUserAdministrator>(() =>
      _i168.UnmakeUserAdministrator(
          repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i169.UnsuspendUser>(
      () => _i169.UnsuspendUser(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i170.UpdateAsset>(
      () => _i170.UpdateAsset(repository: gh<_i76.AssetRepository>()));
  gh.lazySingleton<_i171.UpdateAssetAction>(() =>
      _i171.UpdateAssetAction(repository: gh<_i72.AssetActionRepository>()));
  gh.lazySingleton<_i172.UpdateAssetCategory>(() => _i172.UpdateAssetCategory(
      repository: gh<_i74.AssetCategoryRepository>()));
  gh.lazySingleton<_i173.UpdateChecklist>(
      () => _i173.UpdateChecklist(repository: gh<_i88.CheckListsRepository>()));
  gh.lazySingleton<_i174.UpdateCompany>(() => _i174.UpdateCompany(
      companyRepository: gh<_i90.CompanyManagementRepository>()));
  gh.lazySingleton<_i175.UpdateGroup>(
      () => _i175.UpdateGroup(groupRepository: gh<_i149.GroupRepository>()));
  gh.lazySingleton<_i176.UpdateLocation>(() =>
      _i176.UpdateLocation(locationRepository: gh<_i152.LocationRepository>()));
  gh.lazySingleton<_i177.UpdateUserData>(
      () => _i177.UpdateUserData(repository: gh<_i51.UserProfileRepository>()));
  gh.lazySingleton<_i178.UpdateWorkRequest>(() =>
      _i178.UpdateWorkRequest(repository: gh<_i53.WorkRequestsRepository>()));
  gh.factory<_i179.UserManagementBloc>(() => _i179.UserManagementBloc(
        approveUser: gh<_i70.ApproveUser>(),
        approvePassiveUser: gh<_i69.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i154.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i168.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i71.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i155.RejectUser>(),
        suspendUser: gh<_i162.SuspendUser>(),
        unsuspendUser: gh<_i169.UnsuspendUser>(),
        updateUserData: gh<_i177.UpdateUserData>(),
        assignUserToGroup: gh<_i80.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i167.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i78.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i166.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i67.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i180.AddAsset>(
      () => _i180.AddAsset(repository: gh<_i76.AssetRepository>()));
  gh.lazySingleton<_i181.AddAssetAction>(
      () => _i181.AddAssetAction(repository: gh<_i72.AssetActionRepository>()));
  gh.lazySingleton<_i182.AddAssetCategory>(() =>
      _i182.AddAssetCategory(repository: gh<_i74.AssetCategoryRepository>()));
  gh.lazySingleton<_i183.AddChecklist>(
      () => _i183.AddChecklist(repository: gh<_i88.CheckListsRepository>()));
  gh.lazySingleton<_i184.AddCompany>(() => _i184.AddCompany(
      companyManagementRepository: gh<_i90.CompanyManagementRepository>()));
  gh.lazySingleton<_i185.AddCompanyLogo>(() =>
      _i185.AddCompanyLogo(repository: gh<_i90.CompanyManagementRepository>()));
  gh.lazySingleton<_i186.AddGroup>(
      () => _i186.AddGroup(groupRepository: gh<_i149.GroupRepository>()));
  gh.lazySingleton<_i187.AddLocation>(() =>
      _i187.AddLocation(locationRepository: gh<_i152.LocationRepository>()));
  gh.factory<_i188.AssetInternalNumberCubit>(
      () => _i188.AssetInternalNumberCubit(gh<_i86.CheckCodeAvailability>()));
  gh.lazySingleton<_i189.AuthenticationBloc>(() => _i189.AuthenticationBloc(
        signin: gh<_i159.Signin>(),
        signup: gh<_i161.Signup>(),
        signout: gh<_i160.Signout>(),
        autoSignin: gh<_i83.AutoSignin>(),
        sendVerificationEmail: gh<_i158.SendVerificationEmail>(),
        checkEmailVerification: gh<_i87.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i157.SendPasswordResetEmail>(),
        inputValidator: gh<_i9.InputValidator>(),
      ));
  gh.lazySingleton<_i190.CacheGroups>(
      () => _i190.CacheGroups(groupRepository: gh<_i149.GroupRepository>()));
  gh.lazySingleton<_i191.CacheLocation>(() =>
      _i191.CacheLocation(locationRepository: gh<_i152.LocationRepository>()));
  gh.lazySingleton<_i192.DeleteGroup>(
      () => _i192.DeleteGroup(groupRepository: gh<_i149.GroupRepository>()));
  gh.lazySingleton<_i193.DeleteLocation>(() =>
      _i193.DeleteLocation(locationRepository: gh<_i152.LocationRepository>()));
  gh.lazySingleton<_i194.FetchAllLocations>(() => _i194.FetchAllLocations(
      locationRepository: gh<_i152.LocationRepository>()));
  gh.lazySingleton<_i195.GetGroupsStream>(() =>
      _i195.GetGroupsStream(groupRepository: gh<_i149.GroupRepository>()));
  gh.factory<_i196.ItemActionBloc>(() => _i196.ItemActionBloc(
        authenticationBloc: gh<_i189.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i135.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i139.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i197.UserProfileBloc>(() => _i197.UserProfileBloc(
        authenticationBloc: gh<_i189.AuthenticationBloc>(),
        addUser: gh<_i66.AddUser>(),
        assignUserToCompany: gh<_i79.AssignUserToCompany>(),
        resetCompany: gh<_i156.ResetCompany>(),
        getUserById: gh<_i145.GetUserById>(),
        getUserStreamById: gh<_i146.GetUserStreamById>(),
        updateUserData: gh<_i177.UpdateUserData>(),
        addUserAvatar: gh<_i67.AddUserAvatar>(),
        inputValidator: gh<_i9.InputValidator>(),
      ));
  gh.factory<_i198.WorkRequestManagementBloc>(
      () => _i198.WorkRequestManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addWorkRequest: gh<_i68.AddWorkRequest>(),
            deleteWorkRequest: gh<_i112.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i178.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i85.CancelWorkRequest>(),
          ));
  gh.factory<_i199.AssetActionBloc>(() => _i199.AssetActionBloc(
        authenticationBloc: gh<_i189.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i120.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i138.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i200.AssetActionManagementBloc>(
      () => _i200.AssetActionManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addAssetAction: gh<_i181.AddAssetAction>(),
            updateAssetAction: gh<_i171.UpdateAssetAction>(),
            deleteAssetAction: gh<_i100.DeleteAssetAction>(),
          ));
  gh.singleton<_i201.AssetCategoryBloc>(_i201.AssetCategoryBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i121.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i202.AssetCategoryManagementBloc>(
      () => _i202.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addAssetCategory: gh<_i182.AddAssetCategory>(),
            updateAssetCategory: gh<_i172.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i101.DeleteAssetCategory>(),
          ));
  gh.factory<_i203.AssetManagementBloc>(() => _i203.AssetManagementBloc(
        userProfileBloc: gh<_i197.UserProfileBloc>(),
        addAsset: gh<_i180.AddAsset>(),
        deleteAsset: gh<_i99.DeleteAsset>(),
        updateAsset: gh<_i170.UpdateAsset>(),
      ));
  gh.factory<_i204.AssetPartsBloc>(() => _i204.AssetPartsBloc(
        authenticationBloc: gh<_i189.AuthenticationBloc>(),
        userProfileBloc: gh<_i197.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i123.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i205.ChecklistBloc>(_i205.ChecklistBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    getChecklistsStream: gh<_i126.GetChecklistStream>(),
  ));
  gh.factory<_i206.ChecklistManagementBloc>(() => _i206.ChecklistManagementBloc(
        userProfileBloc: gh<_i197.UserProfileBloc>(),
        addChecklist: gh<_i183.AddChecklist>(),
        updateChecklist: gh<_i173.UpdateChecklist>(),
        deleteChecklist: gh<_i102.DeleteChecklist>(),
      ));
  gh.singleton<_i207.CompanyManagementBloc>(_i207.CompanyManagementBloc(
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    inputValidator: gh<_i9.InputValidator>(),
    addCompany: gh<_i184.AddCompany>(),
    fetchAllCompanies: gh<_i113.FetchAllCompanies>(),
    addCompanyLogo: gh<_i185.AddCompanyLogo>(),
    updateCompany: gh<_i174.UpdateCompany>(),
  ));
  gh.singleton<_i208.CompanyProfileBloc>(_i208.CompanyProfileBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i114.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i127.GetCompanyById>(),
    inputValidator: gh<_i9.InputValidator>(),
  ));
  gh.singleton<_i209.DeviceTokenCubit>(_i209.DeviceTokenCubit(
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    registerDeviceToken: gh<_i28.RegisterDeviceToken>(),
    removeDeviceToken: gh<_i29.RemoveDeviceToken>(),
  ));
  gh.singleton<_i210.GroupBloc>(_i210.GroupBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    companyProfileBloc: gh<_i208.CompanyProfileBloc>(),
    addGroup: gh<_i186.AddGroup>(),
    updateGroup: gh<_i175.UpdateGroup>(),
    deleteGroup: gh<_i192.DeleteGroup>(),
    getGroupsStream: gh<_i195.GetGroupsStream>(),
    cacheGroups: gh<_i190.CacheGroups>(),
    tryToGetCachedGroups: gh<_i164.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i211.InstructionCategoryBloc>(_i211.InstructionCategoryBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i133.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i212.InstructionCategoryManagementBloc>(
      () => _i212.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addInstructionCategory: gh<_i58.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i41.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i104.DeleteInstructionCategory>(),
          ));
  gh.factory<_i213.InstructionManagementBloc>(
      () => _i213.InstructionManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addInstruction: gh<_i57.AddInstruction>(),
            deleteInstruction: gh<_i103.DeleteInstruction>(),
            updateInstruction: gh<_i40.UpdateInstruction>(),
          ));
  gh.factory<_i214.ItemActionManagementBloc>(
      () => _i214.ItemActionManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addItemAction: gh<_i60.AddItemAction>(),
            updateItemAction: gh<_i43.UpdateItemAction>(),
            deleteItemAction: gh<_i106.DeleteItemAction>(),
            moveItemAction: gh<_i24.MoveItemAction>(),
          ));
  gh.singleton<_i215.ItemCategoryBloc>(_i215.ItemCategoryBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i136.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i216.ItemCategoryManagementBloc>(
      () => _i216.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addItemCategory: gh<_i61.AddItemCategory>(),
            updateItemCategory: gh<_i44.UpdateItemCategory>(),
            deleteItemCategory: gh<_i107.DeleteItemCategory>(),
          ));
  gh.factory<_i217.ItemsManagementBloc>(() => _i217.ItemsManagementBloc(
        addItemPhoto: gh<_i62.AddItemPhoto>(),
        deleteItemPhoto: gh<_i108.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i45.UpdateItemPhoto>(),
        userProfileBloc: gh<_i197.UserProfileBloc>(),
        addItem: gh<_i59.AddItem>(),
        deleteItem: gh<_i105.DeleteItem>(),
        updateItem: gh<_i42.UpdateItem>(),
      ));
  gh.singleton<_i218.LocationBloc>(_i218.LocationBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    addLocation: gh<_i187.AddLocation>(),
    cacheLocation: gh<_i191.CacheLocation>(),
    deleteLocation: gh<_i193.DeleteLocation>(),
    fetchAllLocations: gh<_i194.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i165.TryToGetCachedLocation>(),
    updateLocation: gh<_i176.UpdateLocation>(),
  ));
  gh.singleton<_i219.NewUsersBloc>(_i219.NewUsersBloc(
    gh<_i208.CompanyProfileBloc>(),
    gh<_i115.FetchNewUsers>(),
  ));
  gh.singleton<_i220.SuspendedUsersBloc>(_i220.SuspendedUsersBloc(
    gh<_i208.CompanyProfileBloc>(),
    gh<_i116.FetchSuspendedUsers>(),
  ));
  gh.factory<_i221.TaskActionManagementBloc>(
      () => _i221.TaskActionManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addTaskAction: gh<_i64.AddTaskAction>(),
            deleteTaskAction: gh<_i110.DeleteTaskAction>(),
            updateTaskAction: gh<_i47.UpdateTaskAction>(),
          ));
  gh.factory<_i222.TaskManagementBloc>(() => _i222.TaskManagementBloc(
        userProfileBloc: gh<_i197.UserProfileBloc>(),
        addTask: gh<_i63.AddTask>(),
        deleteTask: gh<_i109.DeleteTask>(),
        updateTask: gh<_i46.UpdateTask>(),
        cancelTask: gh<_i84.CancelTask>(),
        completeTask: gh<_i94.CompleteTask>(),
      ));
  gh.lazySingleton<_i223.TaskTemplatesBloc>(() => _i223.TaskTemplatesBloc(
        authenticationBloc: gh<_i189.AuthenticationBloc>(),
        userProfileBloc: gh<_i197.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i144.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i224.TaskTemplatesManagementBloc>(
      () => _i224.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i197.UserProfileBloc>(),
            addTaskTemplate: gh<_i65.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i48.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i111.DeleteTaskTemplate>(),
          ));
  gh.singleton<_i225.FilterBloc>(_i225.FilterBloc(
    locationBloc: gh<_i218.LocationBloc>(),
    groupBloc: gh<_i210.GroupBloc>(),
    userProfileBloc: gh<_i197.UserProfileBloc>(),
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
  ));
  gh.singleton<_i226.InstructionBloc>(_i226.InstructionBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getInstructionsStream: gh<_i134.GetInstructionsStream>(),
  ));
  gh.singleton<_i227.ItemsBloc>(_i227.ItemsBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getChecklistsStream: gh<_i137.GetItemsStream>(),
  ));
  gh.singleton<_i228.TaskActionsStatusBloc>(_i228.TaskActionsStatusBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getLatestTaskActions: gh<_i140.GetLatestTaskActions>(),
  ));
  gh.singleton<_i229.TaskArchiveBloc>(_i229.TaskArchiveBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getArchiveTasksStream: gh<_i118.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i230.TaskArchiveLatestBloc>(_i230.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i117.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i231.TaskBloc>(_i231.TaskBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getTasksStream: gh<_i143.GetTasksStream>(),
  ));
  gh.singleton<_i232.WorkRequestArchiveBloc>(_i232.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i119.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i233.WorkRequestBloc>(_i233.WorkRequestBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getWorkRequestsStream: gh<_i147.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i234.WorkRequestsStatusBloc>(_i234.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i124.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i128.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i125.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i235.ActivityBloc>(_i235.ActivityBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    workRequestBloc: gh<_i233.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i232.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i231.TaskBloc>(),
    taskArchiveBloc: gh<_i229.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i228.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i236.AssetBloc>(_i236.AssetBloc(
    filterBloc: gh<_i225.FilterBloc>(),
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    getAssetsStream: gh<_i122.GetAssetsStream>(),
  ));
  gh.singleton<_i237.DashboardAssetActionBloc>(_i237.DashboardAssetActionBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i129.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i131.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i238.DashboardItemActionBloc>(_i238.DashboardItemActionBloc(
    authenticationBloc: gh<_i189.AuthenticationBloc>(),
    filterBloc: gh<_i225.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i130.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i132.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i239.TaskFilterBloc>(_i239.TaskFilterBloc(
    gh<_i189.AuthenticationBloc>(),
    gh<_i197.UserProfileBloc>(),
    gh<_i231.TaskBloc>(),
    gh<_i233.WorkRequestBloc>(),
  ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i240.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i240.FirebaseStorageService {}

class _$FirebaseMessagingService extends _i240.FirebaseMessagingService {}

class _$SharedPreferencesService extends _i240.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i241.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i241.DataConnectionCheckerModule {}
