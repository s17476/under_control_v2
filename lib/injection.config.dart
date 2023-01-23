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
    as _i68;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i70;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i72;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i91;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i67;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i69;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i71;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i90;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i175;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i176;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i95;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i115;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i124;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i126;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i133;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i166;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i177;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i96;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i116;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i167;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i81;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i94;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i117;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i118;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i165;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i230;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i195;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i231;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i183;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i77;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i76;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i78;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i82;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i152;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i153;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i154;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i155;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i156;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i184;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i84;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i83;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i178;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i97;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i121;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i168;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i86;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i88;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i85;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i87;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i179;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i180;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i108;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i109;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i110;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i111;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i122;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i169;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i24;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/dashboard/data/repositories/task_action_status_repository_impl.dart'
    as _i30;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i51;
import 'package:under_control_v2/features/dashboard/domain/repositories/task_action_status_repository.dart'
    as _i29;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i50;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i119;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i120;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i123;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_latest_task_actions.dart'
    as _i135;
import 'package:under_control_v2/features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart'
    as _i229;
import 'package:under_control_v2/features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i228;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i143;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i145;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i144;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i181;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i185;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i187;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i190;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i159;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i170;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i93;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i92;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i54;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i57;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i100;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i103;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i132;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i55;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i101;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i125;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i127;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i130;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i134;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i38;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i56;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i102;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i131;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i39;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i37;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i40;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i232;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i52;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i98;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i129;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i53;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i99;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i128;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i36;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i35;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i146;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i148;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i147;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i182;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i186;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i188;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i189;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i160;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i171;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i21;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i28;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i32;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i34;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i49;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i27;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i31;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i33;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i48;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i58;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i79;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i89;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i104;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i112;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i113;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i138;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i41;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i59;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i105;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i136;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i137;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i42;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i60;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i106;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i139;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i43;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i63;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i80;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i107;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i114;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i142;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i173;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i25;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i158;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i233;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i45;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i47;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i44;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i46;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i61;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i62;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i64;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i65;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i66;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i73;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i74;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i75;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i140;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i141;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i150;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i151;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i157;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i161;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i162;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i163;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i164;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i172;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i174;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i192;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i235;
import 'features/core/injectable_modules/injectable_modules.dart' as _i234;

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
  gh.lazySingleton<_i29.TaskActionStatusRepository>(() =>
      _i30.TaskActionStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i31.TaskRepository>(() => _i32.TaskRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i33.TaskTemplatesRepository>(
      () => _i34.TaskTemplatesRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i35.UpdateInstruction>(() =>
      _i35.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i36.UpdateInstructionCategory>(() =>
      _i36.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i37.UpdateItem>(
      () => _i37.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i38.UpdateItemAction>(
      () => _i38.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i39.UpdateItemCategory>(() =>
      _i39.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i40.UpdateItemPhoto>(
      () => _i40.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i41.UpdateTask>(
      () => _i41.UpdateTask(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i42.UpdateTaskAction>(
      () => _i42.UpdateTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i43.UpdateTaskTemplate>(() =>
      _i43.UpdateTaskTemplate(repository: gh<_i33.TaskTemplatesRepository>()));
  gh.lazySingleton<_i44.UserFilesRepository>(() =>
      _i45.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i46.UserProfileRepository>(() =>
      _i47.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i48.WorkRequestsRepository>(
      () => _i49.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i50.WorkRequestsStatusRepository>(() =>
      _i51.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i52.AddInstruction>(
      () => _i52.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i53.AddInstructionCategory>(() =>
      _i53.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i54.AddItem>(
      () => _i54.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i55.AddItemAction>(
      () => _i55.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i56.AddItemCategory>(() =>
      _i56.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i57.AddItemPhoto>(
      () => _i57.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i58.AddTask>(
      () => _i58.AddTask(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i59.AddTaskAction>(
      () => _i59.AddTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i60.AddTaskTemplate>(() =>
      _i60.AddTaskTemplate(repository: gh<_i33.TaskTemplatesRepository>()));
  gh.lazySingleton<_i61.AddUser>(
      () => _i61.AddUser(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i62.AddUserAvatar>(
      () => _i62.AddUserAvatar(repository: gh<_i44.UserFilesRepository>()));
  gh.lazySingleton<_i63.AddWorkRequest>(
      () => _i63.AddWorkRequest(repository: gh<_i48.WorkRequestsRepository>()));
  gh.lazySingleton<_i64.ApprovePassiveUser>(() =>
      _i64.ApprovePassiveUser(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i65.ApproveUser>(
      () => _i65.ApproveUser(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i66.ApproveUserAndMakeAdmin>(() =>
      _i66.ApproveUserAndMakeAdmin(
          repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i67.AssetActionRepository>(() =>
      _i68.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i69.AssetCategoryRepository>(() =>
      _i70.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i71.AssetRepository>(() => _i72.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i73.AssignGroupAdmin>(() =>
      _i73.AssignGroupAdmin(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i74.AssignUserToCompany>(() =>
      _i74.AssignUserToCompany(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i75.AssignUserToGroup>(() =>
      _i75.AssignUserToGroup(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i76.AuthenticationRepository>(
      () => _i77.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i24.NetworkInfo>(),
          ));
  gh.lazySingleton<_i78.AutoSignin>(() => _i78.AutoSignin(
      authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i79.CancelTask>(
      () => _i79.CancelTask(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i80.CancelWorkRequest>(() =>
      _i80.CancelWorkRequest(repository: gh<_i48.WorkRequestsRepository>()));
  gh.lazySingleton<_i81.CheckCodeAvailability>(
      () => _i81.CheckCodeAvailability(repository: gh<_i71.AssetRepository>()));
  gh.lazySingleton<_i82.CheckEmailVerification>(() =>
      _i82.CheckEmailVerification(
          authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i83.CheckListsRepository>(() =>
      _i84.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i85.CompanyManagementRepository>(
      () => _i86.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i87.CompanyRepository>(() => _i88.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i89.CompleteTask>(
      () => _i89.CompleteTask(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i90.DashboardAssetActionRepository>(() =>
      _i91.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i92.DashboardItemActionRepository>(() =>
      _i93.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i94.DeleteAsset>(
      () => _i94.DeleteAsset(repository: gh<_i71.AssetRepository>()));
  gh.lazySingleton<_i95.DeleteAssetAction>(() =>
      _i95.DeleteAssetAction(repository: gh<_i67.AssetActionRepository>()));
  gh.lazySingleton<_i96.DeleteAssetCategory>(() =>
      _i96.DeleteAssetCategory(repository: gh<_i69.AssetCategoryRepository>()));
  gh.lazySingleton<_i97.DeleteChecklist>(
      () => _i97.DeleteChecklist(repository: gh<_i83.CheckListsRepository>()));
  gh.lazySingleton<_i98.DeleteInstruction>(() =>
      _i98.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i99.DeleteInstructionCategory>(() =>
      _i99.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i100.DeleteItem>(
      () => _i100.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i101.DeleteItemAction>(() =>
      _i101.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i102.DeleteItemCategory>(() =>
      _i102.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i103.DeleteItemPhoto>(
      () => _i103.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i104.DeleteTask>(
      () => _i104.DeleteTask(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i105.DeleteTaskAction>(() =>
      _i105.DeleteTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i106.DeleteTaskTemplate>(() =>
      _i106.DeleteTaskTemplate(repository: gh<_i33.TaskTemplatesRepository>()));
  gh.lazySingleton<_i107.DeleteWorkRequest>(() =>
      _i107.DeleteWorkRequest(repository: gh<_i48.WorkRequestsRepository>()));
  gh.lazySingleton<_i108.FetchAllCompanies>(() => _i108.FetchAllCompanies(
      companyManagementRepository: gh<_i85.CompanyManagementRepository>()));
  gh.lazySingleton<_i109.FetchAllCompanyUsers>(() => _i109.FetchAllCompanyUsers(
      companyRepository: gh<_i87.CompanyRepository>()));
  gh.lazySingleton<_i110.FetchNewUsers>(() =>
      _i110.FetchNewUsers(companyRepository: gh<_i87.CompanyRepository>()));
  gh.lazySingleton<_i111.FetchSuspendedUsers>(() => _i111.FetchSuspendedUsers(
      companyRepository: gh<_i87.CompanyRepository>()));
  gh.lazySingleton<_i112.GetArchiveLatestTasksStream>(() =>
      _i112.GetArchiveLatestTasksStream(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i113.GetArchiveTasksStream>(
      () => _i113.GetArchiveTasksStream(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i114.GetArchiveWorkRequestsStream>(() =>
      _i114.GetArchiveWorkRequestsStream(
          repository: gh<_i48.WorkRequestsRepository>()));
  gh.lazySingleton<_i115.GetAssetActionsStream>(() =>
      _i115.GetAssetActionsStream(
          repository: gh<_i67.AssetActionRepository>()));
  gh.lazySingleton<_i116.GetAssetsCategoriesStream>(() =>
      _i116.GetAssetsCategoriesStream(
          repository: gh<_i69.AssetCategoryRepository>()));
  gh.lazySingleton<_i117.GetAssetsStream>(
      () => _i117.GetAssetsStream(repository: gh<_i71.AssetRepository>()));
  gh.lazySingleton<_i118.GetAssetsStreamForParent>(() =>
      _i118.GetAssetsStreamForParent(repository: gh<_i71.AssetRepository>()));
  gh.lazySingleton<_i119.GetAwaitingWorkRequestsCount>(() =>
      _i119.GetAwaitingWorkRequestsCount(
          repository: gh<_i50.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i120.GetCancelledWorkRequestsCount>(() =>
      _i120.GetCancelledWorkRequestsCount(
          repository: gh<_i50.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i121.GetChecklistStream>(() =>
      _i121.GetChecklistStream(repository: gh<_i83.CheckListsRepository>()));
  gh.lazySingleton<_i122.GetCompanyById>(() =>
      _i122.GetCompanyById(companyRepository: gh<_i87.CompanyRepository>()));
  gh.lazySingleton<_i123.GetConvertedWorkRequestsCount>(() =>
      _i123.GetConvertedWorkRequestsCount(
          repository: gh<_i50.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i124.GetDashboardAssetActionsStream>(() =>
      _i124.GetDashboardAssetActionsStream(
          repository: gh<_i90.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i125.GetDashboardItemsActionsStream>(() =>
      _i125.GetDashboardItemsActionsStream(
          repository: gh<_i92.DashboardItemActionRepository>()));
  gh.lazySingleton<_i126.GetDashboardLastFiveAssetActionsStream>(() =>
      _i126.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i90.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i127.GetDashboardLastFiveItemsActionsStream>(() =>
      _i127.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i92.DashboardItemActionRepository>()));
  gh.lazySingleton<_i128.GetInstructionsCategoriesStream>(() =>
      _i128.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i129.GetInstructionsStream>(() =>
      _i129.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i130.GetItemsActionsStream>(() =>
      _i130.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i131.GetItemsCategoriesStream>(() =>
      _i131.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i132.GetItemsStream>(
      () => _i132.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i133.GetLastFiveAssetActionsStream>(() =>
      _i133.GetLastFiveAssetActionsStream(
          repository: gh<_i67.AssetActionRepository>()));
  gh.lazySingleton<_i134.GetLastFiveItemsActionsStream>(() =>
      _i134.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i135.GetLatestTaskActions>(() => _i135.GetLatestTaskActions(
      repository: gh<_i29.TaskActionStatusRepository>()));
  gh.lazySingleton<_i136.GetLatestTaskActionsStream>(() =>
      _i136.GetLatestTaskActionsStream(
          repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i137.GetTaskActionsStream>(() =>
      _i137.GetTaskActionsStream(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i138.GetTasksStream>(
      () => _i138.GetTasksStream(repository: gh<_i31.TaskRepository>()));
  gh.lazySingleton<_i139.GetTasksTemplatesStream>(() =>
      _i139.GetTasksTemplatesStream(
          repository: gh<_i33.TaskTemplatesRepository>()));
  gh.lazySingleton<_i140.GetUserById>(
      () => _i140.GetUserById(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i141.GetUserStreamById>(() => _i141.GetUserStreamById(
      userRepository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i142.GetWorkRequestsStream>(() =>
      _i142.GetWorkRequestsStream(
          repository: gh<_i48.WorkRequestsRepository>()));
  gh.lazySingleton<_i143.GroupLocalDataSource>(() =>
      _i143.GroupLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i144.GroupRepository>(() => _i145.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i143.GroupLocalDataSource>(),
      ));
  gh.lazySingleton<_i146.LocationLocalDataSource>(() =>
      _i146.LocationLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i147.LocationRepository>(() => _i148.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i146.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i149.MakeUserAdministrator>(() =>
      _i149.MakeUserAdministrator(
          repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i150.RejectUser>(
      () => _i150.RejectUser(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i151.ResetCompany>(
      () => _i151.ResetCompany(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i152.SendPasswordResetEmail>(() =>
      _i152.SendPasswordResetEmail(
          authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i153.SendVerificationEmail>(() =>
      _i153.SendVerificationEmail(
          authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i154.Signin>(() => _i154.Signin(
      authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i155.Signout>(() => _i155.Signout(
      authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i156.Signup>(() => _i156.Signup(
      authenticationRepository: gh<_i76.AuthenticationRepository>()));
  gh.lazySingleton<_i157.SuspendUser>(
      () => _i157.SuspendUser(repository: gh<_i46.UserProfileRepository>()));
  gh.factory<_i158.TaskActionBloc>(() => _i158.TaskActionBloc(
      getTaskActionsStream: gh<_i137.GetTaskActionsStream>()));
  gh.lazySingleton<_i159.TryToGetCachedGroups>(() =>
      _i159.TryToGetCachedGroups(groupRepository: gh<_i144.GroupRepository>()));
  gh.lazySingleton<_i160.TryToGetCachedLocation>(() =>
      _i160.TryToGetCachedLocation(
          locationRepository: gh<_i147.LocationRepository>()));
  gh.lazySingleton<_i161.UnassignGroupAdmin>(() =>
      _i161.UnassignGroupAdmin(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i162.UnassignUserFromGroup>(() =>
      _i162.UnassignUserFromGroup(
          repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i163.UnmakeUserAdministrator>(() =>
      _i163.UnmakeUserAdministrator(
          repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i164.UnsuspendUser>(
      () => _i164.UnsuspendUser(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i165.UpdateAsset>(
      () => _i165.UpdateAsset(repository: gh<_i71.AssetRepository>()));
  gh.lazySingleton<_i166.UpdateAssetAction>(() =>
      _i166.UpdateAssetAction(repository: gh<_i67.AssetActionRepository>()));
  gh.lazySingleton<_i167.UpdateAssetCategory>(() => _i167.UpdateAssetCategory(
      repository: gh<_i69.AssetCategoryRepository>()));
  gh.lazySingleton<_i168.UpdateChecklist>(
      () => _i168.UpdateChecklist(repository: gh<_i83.CheckListsRepository>()));
  gh.lazySingleton<_i169.UpdateCompany>(() => _i169.UpdateCompany(
      companyRepository: gh<_i85.CompanyManagementRepository>()));
  gh.lazySingleton<_i170.UpdateGroup>(
      () => _i170.UpdateGroup(groupRepository: gh<_i144.GroupRepository>()));
  gh.lazySingleton<_i171.UpdateLocation>(() =>
      _i171.UpdateLocation(locationRepository: gh<_i147.LocationRepository>()));
  gh.lazySingleton<_i172.UpdateUserData>(
      () => _i172.UpdateUserData(repository: gh<_i46.UserProfileRepository>()));
  gh.lazySingleton<_i173.UpdateWorkRequest>(() =>
      _i173.UpdateWorkRequest(repository: gh<_i48.WorkRequestsRepository>()));
  gh.factory<_i174.UserManagementBloc>(() => _i174.UserManagementBloc(
        approveUser: gh<_i65.ApproveUser>(),
        approvePassiveUser: gh<_i64.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i149.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i163.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i66.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i150.RejectUser>(),
        suspendUser: gh<_i157.SuspendUser>(),
        unsuspendUser: gh<_i164.UnsuspendUser>(),
        updateUserData: gh<_i172.UpdateUserData>(),
        assignUserToGroup: gh<_i75.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i162.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i73.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i161.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i62.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i175.AddAsset>(
      () => _i175.AddAsset(repository: gh<_i71.AssetRepository>()));
  gh.lazySingleton<_i176.AddAssetAction>(
      () => _i176.AddAssetAction(repository: gh<_i67.AssetActionRepository>()));
  gh.lazySingleton<_i177.AddAssetCategory>(() =>
      _i177.AddAssetCategory(repository: gh<_i69.AssetCategoryRepository>()));
  gh.lazySingleton<_i178.AddChecklist>(
      () => _i178.AddChecklist(repository: gh<_i83.CheckListsRepository>()));
  gh.lazySingleton<_i179.AddCompany>(() => _i179.AddCompany(
      companyManagementRepository: gh<_i85.CompanyManagementRepository>()));
  gh.lazySingleton<_i180.AddCompanyLogo>(() =>
      _i180.AddCompanyLogo(repository: gh<_i85.CompanyManagementRepository>()));
  gh.lazySingleton<_i181.AddGroup>(
      () => _i181.AddGroup(groupRepository: gh<_i144.GroupRepository>()));
  gh.lazySingleton<_i182.AddLocation>(() =>
      _i182.AddLocation(locationRepository: gh<_i147.LocationRepository>()));
  gh.factory<_i183.AssetInternalNumberCubit>(
      () => _i183.AssetInternalNumberCubit(gh<_i81.CheckCodeAvailability>()));
  gh.lazySingleton<_i184.AuthenticationBloc>(() => _i184.AuthenticationBloc(
        signin: gh<_i154.Signin>(),
        signup: gh<_i156.Signup>(),
        signout: gh<_i155.Signout>(),
        autoSignin: gh<_i78.AutoSignin>(),
        sendVerificationEmail: gh<_i153.SendVerificationEmail>(),
        checkEmailVerification: gh<_i82.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i152.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i185.CacheGroups>(
      () => _i185.CacheGroups(groupRepository: gh<_i144.GroupRepository>()));
  gh.lazySingleton<_i186.CacheLocation>(() =>
      _i186.CacheLocation(locationRepository: gh<_i147.LocationRepository>()));
  gh.lazySingleton<_i187.DeleteGroup>(
      () => _i187.DeleteGroup(groupRepository: gh<_i144.GroupRepository>()));
  gh.lazySingleton<_i188.DeleteLocation>(() =>
      _i188.DeleteLocation(locationRepository: gh<_i147.LocationRepository>()));
  gh.lazySingleton<_i189.FetchAllLocations>(() => _i189.FetchAllLocations(
      locationRepository: gh<_i147.LocationRepository>()));
  gh.lazySingleton<_i190.GetGroupsStream>(() =>
      _i190.GetGroupsStream(groupRepository: gh<_i144.GroupRepository>()));
  gh.factory<_i191.ItemActionBloc>(() => _i191.ItemActionBloc(
        authenticationBloc: gh<_i184.AuthenticationBloc>(),
        getItemsActionsStream: gh<_i130.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i134.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i192.UserProfileBloc>(() => _i192.UserProfileBloc(
        authenticationBloc: gh<_i184.AuthenticationBloc>(),
        addUser: gh<_i61.AddUser>(),
        assignUserToCompany: gh<_i74.AssignUserToCompany>(),
        resetCompany: gh<_i151.ResetCompany>(),
        getUserById: gh<_i140.GetUserById>(),
        getUserStreamById: gh<_i141.GetUserStreamById>(),
        updateUserData: gh<_i172.UpdateUserData>(),
        addUserAvatar: gh<_i62.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.factory<_i193.WorkRequestManagementBloc>(
      () => _i193.WorkRequestManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addWorkRequest: gh<_i63.AddWorkRequest>(),
            deleteWorkRequest: gh<_i107.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i173.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i80.CancelWorkRequest>(),
          ));
  gh.factory<_i194.AssetActionBloc>(() => _i194.AssetActionBloc(
        authenticationBloc: gh<_i184.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i115.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i133.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i195.AssetActionManagementBloc>(
      () => _i195.AssetActionManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addAssetAction: gh<_i176.AddAssetAction>(),
            updateAssetAction: gh<_i166.UpdateAssetAction>(),
            deleteAssetAction: gh<_i95.DeleteAssetAction>(),
          ));
  gh.singleton<_i196.AssetCategoryBloc>(_i196.AssetCategoryBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i116.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i197.AssetCategoryManagementBloc>(
      () => _i197.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addAssetCategory: gh<_i177.AddAssetCategory>(),
            updateAssetCategory: gh<_i167.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i96.DeleteAssetCategory>(),
          ));
  gh.factory<_i198.AssetManagementBloc>(() => _i198.AssetManagementBloc(
        userProfileBloc: gh<_i192.UserProfileBloc>(),
        addAsset: gh<_i175.AddAsset>(),
        deleteAsset: gh<_i94.DeleteAsset>(),
        updateAsset: gh<_i165.UpdateAsset>(),
      ));
  gh.factory<_i199.AssetPartsBloc>(() => _i199.AssetPartsBloc(
        authenticationBloc: gh<_i184.AuthenticationBloc>(),
        userProfileBloc: gh<_i192.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i118.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i200.ChecklistBloc>(_i200.ChecklistBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    getChecklistsStream: gh<_i121.GetChecklistStream>(),
  ));
  gh.factory<_i201.ChecklistManagementBloc>(() => _i201.ChecklistManagementBloc(
        userProfileBloc: gh<_i192.UserProfileBloc>(),
        addChecklist: gh<_i178.AddChecklist>(),
        updateChecklist: gh<_i168.UpdateChecklist>(),
        deleteChecklist: gh<_i97.DeleteChecklist>(),
      ));
  gh.singleton<_i202.CompanyManagementBloc>(_i202.CompanyManagementBloc(
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    inputValidator: gh<_i8.InputValidator>(),
    addCompany: gh<_i179.AddCompany>(),
    fetchAllCompanies: gh<_i108.FetchAllCompanies>(),
    addCompanyLogo: gh<_i180.AddCompanyLogo>(),
    updateCompany: gh<_i169.UpdateCompany>(),
  ));
  gh.singleton<_i203.CompanyProfileBloc>(_i203.CompanyProfileBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i109.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i122.GetCompanyById>(),
    inputValidator: gh<_i8.InputValidator>(),
  ));
  gh.singleton<_i204.GroupBloc>(_i204.GroupBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    companyProfileBloc: gh<_i203.CompanyProfileBloc>(),
    addGroup: gh<_i181.AddGroup>(),
    updateGroup: gh<_i170.UpdateGroup>(),
    deleteGroup: gh<_i187.DeleteGroup>(),
    getGroupsStream: gh<_i190.GetGroupsStream>(),
    cacheGroups: gh<_i185.CacheGroups>(),
    tryToGetCachedGroups: gh<_i159.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i205.InstructionCategoryBloc>(_i205.InstructionCategoryBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i128.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i206.InstructionCategoryManagementBloc>(
      () => _i206.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addInstructionCategory: gh<_i53.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i36.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i99.DeleteInstructionCategory>(),
          ));
  gh.factory<_i207.InstructionManagementBloc>(
      () => _i207.InstructionManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addInstruction: gh<_i52.AddInstruction>(),
            deleteInstruction: gh<_i98.DeleteInstruction>(),
            updateInstruction: gh<_i35.UpdateInstruction>(),
          ));
  gh.factory<_i208.ItemActionManagementBloc>(
      () => _i208.ItemActionManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addItemAction: gh<_i55.AddItemAction>(),
            updateItemAction: gh<_i38.UpdateItemAction>(),
            deleteItemAction: gh<_i101.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.singleton<_i209.ItemCategoryBloc>(_i209.ItemCategoryBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i131.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i210.ItemCategoryManagementBloc>(
      () => _i210.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addItemCategory: gh<_i56.AddItemCategory>(),
            updateItemCategory: gh<_i39.UpdateItemCategory>(),
            deleteItemCategory: gh<_i102.DeleteItemCategory>(),
          ));
  gh.factory<_i211.ItemsManagementBloc>(() => _i211.ItemsManagementBloc(
        addItemPhoto: gh<_i57.AddItemPhoto>(),
        deleteItemPhoto: gh<_i103.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i40.UpdateItemPhoto>(),
        userProfileBloc: gh<_i192.UserProfileBloc>(),
        addItem: gh<_i54.AddItem>(),
        deleteItem: gh<_i100.DeleteItem>(),
        updateItem: gh<_i37.UpdateItem>(),
      ));
  gh.singleton<_i212.LocationBloc>(_i212.LocationBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    addLocation: gh<_i182.AddLocation>(),
    cacheLocation: gh<_i186.CacheLocation>(),
    deleteLocation: gh<_i188.DeleteLocation>(),
    fetchAllLocations: gh<_i189.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i160.TryToGetCachedLocation>(),
    updateLocation: gh<_i171.UpdateLocation>(),
  ));
  gh.singleton<_i213.NewUsersBloc>(_i213.NewUsersBloc(
    gh<_i203.CompanyProfileBloc>(),
    gh<_i110.FetchNewUsers>(),
  ));
  gh.singleton<_i214.SuspendedUsersBloc>(_i214.SuspendedUsersBloc(
    gh<_i203.CompanyProfileBloc>(),
    gh<_i111.FetchSuspendedUsers>(),
  ));
  gh.factory<_i215.TaskActionManagementBloc>(
      () => _i215.TaskActionManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addTaskAction: gh<_i59.AddTaskAction>(),
            deleteTaskAction: gh<_i105.DeleteTaskAction>(),
            updateTaskAction: gh<_i42.UpdateTaskAction>(),
          ));
  gh.factory<_i216.TaskManagementBloc>(() => _i216.TaskManagementBloc(
        userProfileBloc: gh<_i192.UserProfileBloc>(),
        addTask: gh<_i58.AddTask>(),
        deleteTask: gh<_i104.DeleteTask>(),
        updateTask: gh<_i41.UpdateTask>(),
        cancelTask: gh<_i79.CancelTask>(),
        completeTask: gh<_i89.CompleteTask>(),
      ));
  gh.lazySingleton<_i217.TaskTemplatesBloc>(() => _i217.TaskTemplatesBloc(
        authenticationBloc: gh<_i184.AuthenticationBloc>(),
        userProfileBloc: gh<_i192.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i139.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i218.TaskTemplatesManagementBloc>(
      () => _i218.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i192.UserProfileBloc>(),
            addTaskTemplate: gh<_i60.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i43.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i106.DeleteTaskTemplate>(),
          ));
  gh.singleton<_i219.FilterBloc>(_i219.FilterBloc(
    locationBloc: gh<_i212.LocationBloc>(),
    groupBloc: gh<_i204.GroupBloc>(),
    userProfileBloc: gh<_i192.UserProfileBloc>(),
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
  ));
  gh.singleton<_i220.InstructionBloc>(_i220.InstructionBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getInstructionsStream: gh<_i129.GetInstructionsStream>(),
  ));
  gh.singleton<_i221.ItemsBloc>(_i221.ItemsBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getChecklistsStream: gh<_i132.GetItemsStream>(),
  ));
  gh.singleton<_i222.TaskActionsStatusBloc>(_i222.TaskActionsStatusBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getLatestTaskActions: gh<_i135.GetLatestTaskActions>(),
  ));
  gh.singleton<_i223.TaskArchiveBloc>(_i223.TaskArchiveBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getArchiveTasksStream: gh<_i113.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i224.TaskArchiveLatestBloc>(_i224.TaskArchiveLatestBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i112.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i225.TaskBloc>(_i225.TaskBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getTasksStream: gh<_i138.GetTasksStream>(),
  ));
  gh.singleton<_i226.WorkRequestArchiveBloc>(_i226.WorkRequestArchiveBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i114.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i227.WorkRequestBloc>(_i227.WorkRequestBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getWorkRequestsStream: gh<_i142.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i228.WorkRequestsStatusBloc>(_i228.WorkRequestsStatusBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i119.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i123.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i120.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i229.ActivityBloc>(_i229.ActivityBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    workRequestBloc: gh<_i227.WorkRequestBloc>(),
    workRequestArchiveBloc: gh<_i226.WorkRequestArchiveBloc>(),
    taskBloc: gh<_i225.TaskBloc>(),
    taskArchiveBloc: gh<_i223.TaskArchiveBloc>(),
    taskActionsStatusBloc: gh<_i222.TaskActionsStatusBloc>(),
  ));
  gh.singleton<_i230.AssetBloc>(_i230.AssetBloc(
    filterBloc: gh<_i219.FilterBloc>(),
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    getAssetsStream: gh<_i117.GetAssetsStream>(),
  ));
  gh.singleton<_i231.DashboardAssetActionBloc>(_i231.DashboardAssetActionBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i124.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i126.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i232.DashboardItemActionBloc>(_i232.DashboardItemActionBloc(
    authenticationBloc: gh<_i184.AuthenticationBloc>(),
    filterBloc: gh<_i219.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i125.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i127.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i233.TaskFilterBloc>(_i233.TaskFilterBloc(
    gh<_i184.AuthenticationBloc>(),
    gh<_i192.UserProfileBloc>(),
    gh<_i225.TaskBloc>(),
    gh<_i227.WorkRequestBloc>(),
  ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i234.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i234.FirebaseStorageService {}

class _$SharedPreferencesService extends _i234.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i235.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i235.DataConnectionCheckerModule {}
