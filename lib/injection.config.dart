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
    as _i66;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i68;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i70;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i89;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i65;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i67;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i69;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i88;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i173;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i174;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i93;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i113;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i122;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i124;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i131;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i164;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i175;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i94;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i114;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i165;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i79;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i92;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i115;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i116;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i163;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i225;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i192;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i195;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i226;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i181;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i75;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i74;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i76;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i80;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i150;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i151;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i152;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i153;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i154;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i182;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i82;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i81;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i176;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i95;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i119;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i166;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i84;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i86;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i83;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i85;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i177;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i178;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i106;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i107;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i108;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i109;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i120;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i167;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i24;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/dashboard/data/repositories/work_request_status_repository_impl.dart'
    as _i49;
import 'package:under_control_v2/features/dashboard/domain/repositories/work_request_status_repository.dart'
    as _i48;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart'
    as _i117;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart'
    as _i118;
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart'
    as _i121;
import 'package:under_control_v2/features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart'
    as _i224;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i216;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i140;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i142;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i141;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i179;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i183;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i185;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i188;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i157;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i168;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i91;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i90;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i52;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i55;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i98;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i101;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i130;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i53;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i99;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i123;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i125;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i128;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i132;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i36;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i54;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i100;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i129;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i37;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i35;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i38;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i227;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i143;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i218;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i50;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i96;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i127;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i51;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i97;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i126;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i34;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i33;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i217;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i144;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i146;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i145;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i180;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i184;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i186;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i187;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i158;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i169;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart'
    as _i21;
import 'package:under_control_v2/features/tasks/data/repositories/task_action_repository_impl.dart'
    as _i28;
import 'package:under_control_v2/features/tasks/data/repositories/task_repository_impl.dart'
    as _i30;
import 'package:under_control_v2/features/tasks/data/repositories/task_templates_repository_impl.dart'
    as _i32;
import 'package:under_control_v2/features/tasks/data/repositories/work_request_repository_impl.dart'
    as _i47;
import 'package:under_control_v2/features/tasks/domain/repositories/task_action_repository.dart'
    as _i27;
import 'package:under_control_v2/features/tasks/domain/repositories/task_repository.dart'
    as _i29;
import 'package:under_control_v2/features/tasks/domain/repositories/task_templates_repository.dart'
    as _i31;
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart'
    as _i46;
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart'
    as _i56;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i77;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i87;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i102;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i110;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i111;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i135;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i39;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i57;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i103;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i133;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i134;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i40;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/add_task_template.dart'
    as _i58;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart'
    as _i104;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/get_tasks_templates_stream.dart'
    as _i136;
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/update_task_template.dart'
    as _i41;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i61;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i78;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i105;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i112;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i139;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i171;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i25;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i221;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i156;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i219;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i220;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i228;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart'
    as _i215;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i223;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i222;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i190;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i43;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i45;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i42;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i44;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i59;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i60;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i62;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i63;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i64;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i71;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i72;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i73;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i137;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i138;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i147;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i148;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i155;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i159;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i160;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i161;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i162;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i170;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i172;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i189;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i230;
import 'features/core/injectable_modules/injectable_modules.dart' as _i229;

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
  gh.lazySingleton<_i31.TaskTemplatesRepository>(
      () => _i32.TaskTemplatesRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i33.UpdateInstruction>(() =>
      _i33.UpdateInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i34.UpdateInstructionCategory>(() =>
      _i34.UpdateInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i35.UpdateItem>(
      () => _i35.UpdateItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i36.UpdateItemAction>(
      () => _i36.UpdateItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i37.UpdateItemCategory>(() =>
      _i37.UpdateItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i38.UpdateItemPhoto>(
      () => _i38.UpdateItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i39.UpdateTask>(
      () => _i39.UpdateTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i40.UpdateTaskAction>(
      () => _i40.UpdateTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i41.UpdateTaskTemplate>(() =>
      _i41.UpdateTaskTemplate(repository: gh<_i31.TaskTemplatesRepository>()));
  gh.lazySingleton<_i42.UserFilesRepository>(() =>
      _i43.UserFilesRepositoryImpl(firebaseStorage: gh<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i44.UserProfileRepository>(() =>
      _i45.UserProfileRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i46.WorkRequestsRepository>(
      () => _i47.WorkRequestsRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i48.WorkRequestsStatusRepository>(() =>
      _i49.WorkRequestsStatusRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i50.AddInstruction>(
      () => _i50.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i51.AddInstructionCategory>(() =>
      _i51.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i52.AddItem>(
      () => _i52.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i53.AddItemAction>(
      () => _i53.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i54.AddItemCategory>(() =>
      _i54.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i55.AddItemPhoto>(
      () => _i55.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i56.AddTask>(
      () => _i56.AddTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i57.AddTaskAction>(
      () => _i57.AddTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i58.AddTaskTemplate>(() =>
      _i58.AddTaskTemplate(repository: gh<_i31.TaskTemplatesRepository>()));
  gh.lazySingleton<_i59.AddUser>(
      () => _i59.AddUser(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i60.AddUserAvatar>(
      () => _i60.AddUserAvatar(repository: gh<_i42.UserFilesRepository>()));
  gh.lazySingleton<_i61.AddWorkRequest>(
      () => _i61.AddWorkRequest(repository: gh<_i46.WorkRequestsRepository>()));
  gh.lazySingleton<_i62.ApprovePassiveUser>(() =>
      _i62.ApprovePassiveUser(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i63.ApproveUser>(
      () => _i63.ApproveUser(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i64.ApproveUserAndMakeAdmin>(() =>
      _i64.ApproveUserAndMakeAdmin(
          repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i65.AssetActionRepository>(() =>
      _i66.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i67.AssetCategoryRepository>(() =>
      _i68.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i69.AssetRepository>(() => _i70.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i71.AssignGroupAdmin>(() =>
      _i71.AssignGroupAdmin(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i72.AssignUserToCompany>(() =>
      _i72.AssignUserToCompany(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i73.AssignUserToGroup>(() =>
      _i73.AssignUserToGroup(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i74.AuthenticationRepository>(
      () => _i75.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i24.NetworkInfo>(),
          ));
  gh.lazySingleton<_i76.AutoSignin>(() => _i76.AutoSignin(
      authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i77.CancelTask>(
      () => _i77.CancelTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i78.CancelWorkRequest>(() =>
      _i78.CancelWorkRequest(repository: gh<_i46.WorkRequestsRepository>()));
  gh.lazySingleton<_i79.CheckCodeAvailability>(
      () => _i79.CheckCodeAvailability(repository: gh<_i69.AssetRepository>()));
  gh.lazySingleton<_i80.CheckEmailVerification>(() =>
      _i80.CheckEmailVerification(
          authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i81.CheckListsRepository>(() =>
      _i82.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i83.CompanyManagementRepository>(
      () => _i84.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i85.CompanyRepository>(() => _i86.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i87.CompleteTask>(
      () => _i87.CompleteTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i88.DashboardAssetActionRepository>(() =>
      _i89.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i90.DashboardItemActionRepository>(() =>
      _i91.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i92.DeleteAsset>(
      () => _i92.DeleteAsset(repository: gh<_i69.AssetRepository>()));
  gh.lazySingleton<_i93.DeleteAssetAction>(() =>
      _i93.DeleteAssetAction(repository: gh<_i65.AssetActionRepository>()));
  gh.lazySingleton<_i94.DeleteAssetCategory>(() =>
      _i94.DeleteAssetCategory(repository: gh<_i67.AssetCategoryRepository>()));
  gh.lazySingleton<_i95.DeleteChecklist>(
      () => _i95.DeleteChecklist(repository: gh<_i81.CheckListsRepository>()));
  gh.lazySingleton<_i96.DeleteInstruction>(() =>
      _i96.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i97.DeleteInstructionCategory>(() =>
      _i97.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i98.DeleteItem>(
      () => _i98.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i99.DeleteItemAction>(
      () => _i99.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i100.DeleteItemCategory>(() =>
      _i100.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i101.DeleteItemPhoto>(
      () => _i101.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i102.DeleteTask>(
      () => _i102.DeleteTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i103.DeleteTaskAction>(() =>
      _i103.DeleteTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i104.DeleteTaskTemplate>(() =>
      _i104.DeleteTaskTemplate(repository: gh<_i31.TaskTemplatesRepository>()));
  gh.lazySingleton<_i105.DeleteWorkRequest>(() =>
      _i105.DeleteWorkRequest(repository: gh<_i46.WorkRequestsRepository>()));
  gh.lazySingleton<_i106.FetchAllCompanies>(() => _i106.FetchAllCompanies(
      companyManagementRepository: gh<_i83.CompanyManagementRepository>()));
  gh.lazySingleton<_i107.FetchAllCompanyUsers>(() => _i107.FetchAllCompanyUsers(
      companyRepository: gh<_i85.CompanyRepository>()));
  gh.lazySingleton<_i108.FetchNewUsers>(() =>
      _i108.FetchNewUsers(companyRepository: gh<_i85.CompanyRepository>()));
  gh.lazySingleton<_i109.FetchSuspendedUsers>(() => _i109.FetchSuspendedUsers(
      companyRepository: gh<_i85.CompanyRepository>()));
  gh.lazySingleton<_i110.GetArchiveLatestTasksStream>(() =>
      _i110.GetArchiveLatestTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i111.GetArchiveTasksStream>(
      () => _i111.GetArchiveTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i112.GetArchiveWorkRequestsStream>(() =>
      _i112.GetArchiveWorkRequestsStream(
          repository: gh<_i46.WorkRequestsRepository>()));
  gh.lazySingleton<_i113.GetAssetActionsStream>(() =>
      _i113.GetAssetActionsStream(
          repository: gh<_i65.AssetActionRepository>()));
  gh.lazySingleton<_i114.GetAssetsCategoriesStream>(() =>
      _i114.GetAssetsCategoriesStream(
          repository: gh<_i67.AssetCategoryRepository>()));
  gh.lazySingleton<_i115.GetAssetsStream>(
      () => _i115.GetAssetsStream(repository: gh<_i69.AssetRepository>()));
  gh.lazySingleton<_i116.GetAssetsStreamForParent>(() =>
      _i116.GetAssetsStreamForParent(repository: gh<_i69.AssetRepository>()));
  gh.lazySingleton<_i117.GetAwaitingWorkRequestsCount>(() =>
      _i117.GetAwaitingWorkRequestsCount(
          repository: gh<_i48.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i118.GetCancelledWorkRequestsCount>(() =>
      _i118.GetCancelledWorkRequestsCount(
          repository: gh<_i48.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i119.GetChecklistStream>(() =>
      _i119.GetChecklistStream(repository: gh<_i81.CheckListsRepository>()));
  gh.lazySingleton<_i120.GetCompanyById>(() =>
      _i120.GetCompanyById(companyRepository: gh<_i85.CompanyRepository>()));
  gh.lazySingleton<_i121.GetConvertedWorkRequestsCount>(() =>
      _i121.GetConvertedWorkRequestsCount(
          repository: gh<_i48.WorkRequestsStatusRepository>()));
  gh.lazySingleton<_i122.GetDashboardAssetActionsStream>(() =>
      _i122.GetDashboardAssetActionsStream(
          repository: gh<_i88.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i123.GetDashboardItemsActionsStream>(() =>
      _i123.GetDashboardItemsActionsStream(
          repository: gh<_i90.DashboardItemActionRepository>()));
  gh.lazySingleton<_i124.GetDashboardLastFiveAssetActionsStream>(() =>
      _i124.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i88.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i125.GetDashboardLastFiveItemsActionsStream>(() =>
      _i125.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i90.DashboardItemActionRepository>()));
  gh.lazySingleton<_i126.GetInstructionsCategoriesStream>(() =>
      _i126.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i127.GetInstructionsStream>(() =>
      _i127.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i128.GetItemsActionsStream>(() =>
      _i128.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i129.GetItemsCategoriesStream>(() =>
      _i129.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i130.GetItemsStream>(
      () => _i130.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i131.GetLastFiveAssetActionsStream>(() =>
      _i131.GetLastFiveAssetActionsStream(
          repository: gh<_i65.AssetActionRepository>()));
  gh.lazySingleton<_i132.GetLastFiveItemsActionsStream>(() =>
      _i132.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i133.GetLatestTaskActionsStream>(() =>
      _i133.GetLatestTaskActionsStream(
          repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i134.GetTaskActionsStream>(() =>
      _i134.GetTaskActionsStream(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i135.GetTasksStream>(
      () => _i135.GetTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i136.GetTasksTemplatesStream>(() =>
      _i136.GetTasksTemplatesStream(
          repository: gh<_i31.TaskTemplatesRepository>()));
  gh.lazySingleton<_i137.GetUserById>(
      () => _i137.GetUserById(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i138.GetUserStreamById>(() => _i138.GetUserStreamById(
      userRepository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i139.GetWorkRequestsStream>(() =>
      _i139.GetWorkRequestsStream(
          repository: gh<_i46.WorkRequestsRepository>()));
  gh.lazySingleton<_i140.GroupLocalDataSource>(() =>
      _i140.GroupLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i141.GroupRepository>(() => _i142.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i140.GroupLocalDataSource>(),
      ));
  gh.factory<_i143.ItemActionBloc>(() => _i143.ItemActionBloc(
        getItemsActionsStream: gh<_i128.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i132.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i144.LocationLocalDataSource>(() =>
      _i144.LocationLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i145.LocationRepository>(() => _i146.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i144.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i147.MakeUserAdministrator>(() =>
      _i147.MakeUserAdministrator(
          repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i148.RejectUser>(
      () => _i148.RejectUser(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i149.ResetCompany>(
      () => _i149.ResetCompany(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i150.SendPasswordResetEmail>(() =>
      _i150.SendPasswordResetEmail(
          authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i151.SendVerificationEmail>(() =>
      _i151.SendVerificationEmail(
          authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i152.Signin>(() => _i152.Signin(
      authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i153.Signout>(() => _i153.Signout(
      authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i154.Signup>(() => _i154.Signup(
      authenticationRepository: gh<_i74.AuthenticationRepository>()));
  gh.lazySingleton<_i155.SuspendUser>(
      () => _i155.SuspendUser(repository: gh<_i44.UserProfileRepository>()));
  gh.factory<_i156.TaskActionBloc>(() => _i156.TaskActionBloc(
      getTaskActionsStream: gh<_i134.GetTaskActionsStream>()));
  gh.lazySingleton<_i157.TryToGetCachedGroups>(() =>
      _i157.TryToGetCachedGroups(groupRepository: gh<_i141.GroupRepository>()));
  gh.lazySingleton<_i158.TryToGetCachedLocation>(() =>
      _i158.TryToGetCachedLocation(
          locationRepository: gh<_i145.LocationRepository>()));
  gh.lazySingleton<_i159.UnassignGroupAdmin>(() =>
      _i159.UnassignGroupAdmin(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i160.UnassignUserFromGroup>(() =>
      _i160.UnassignUserFromGroup(
          repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i161.UnmakeUserAdministrator>(() =>
      _i161.UnmakeUserAdministrator(
          repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i162.UnsuspendUser>(
      () => _i162.UnsuspendUser(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i163.UpdateAsset>(
      () => _i163.UpdateAsset(repository: gh<_i69.AssetRepository>()));
  gh.lazySingleton<_i164.UpdateAssetAction>(() =>
      _i164.UpdateAssetAction(repository: gh<_i65.AssetActionRepository>()));
  gh.lazySingleton<_i165.UpdateAssetCategory>(() => _i165.UpdateAssetCategory(
      repository: gh<_i67.AssetCategoryRepository>()));
  gh.lazySingleton<_i166.UpdateChecklist>(
      () => _i166.UpdateChecklist(repository: gh<_i81.CheckListsRepository>()));
  gh.lazySingleton<_i167.UpdateCompany>(() => _i167.UpdateCompany(
      companyRepository: gh<_i83.CompanyManagementRepository>()));
  gh.lazySingleton<_i168.UpdateGroup>(
      () => _i168.UpdateGroup(groupRepository: gh<_i141.GroupRepository>()));
  gh.lazySingleton<_i169.UpdateLocation>(() =>
      _i169.UpdateLocation(locationRepository: gh<_i145.LocationRepository>()));
  gh.lazySingleton<_i170.UpdateUserData>(
      () => _i170.UpdateUserData(repository: gh<_i44.UserProfileRepository>()));
  gh.lazySingleton<_i171.UpdateWorkRequest>(() =>
      _i171.UpdateWorkRequest(repository: gh<_i46.WorkRequestsRepository>()));
  gh.factory<_i172.UserManagementBloc>(() => _i172.UserManagementBloc(
        approveUser: gh<_i63.ApproveUser>(),
        approvePassiveUser: gh<_i62.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i147.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i161.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i64.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i148.RejectUser>(),
        suspendUser: gh<_i155.SuspendUser>(),
        unsuspendUser: gh<_i162.UnsuspendUser>(),
        updateUserData: gh<_i170.UpdateUserData>(),
        assignUserToGroup: gh<_i73.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i160.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i71.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i159.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i60.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i173.AddAsset>(
      () => _i173.AddAsset(repository: gh<_i69.AssetRepository>()));
  gh.lazySingleton<_i174.AddAssetAction>(
      () => _i174.AddAssetAction(repository: gh<_i65.AssetActionRepository>()));
  gh.lazySingleton<_i175.AddAssetCategory>(() =>
      _i175.AddAssetCategory(repository: gh<_i67.AssetCategoryRepository>()));
  gh.lazySingleton<_i176.AddChecklist>(
      () => _i176.AddChecklist(repository: gh<_i81.CheckListsRepository>()));
  gh.lazySingleton<_i177.AddCompany>(() => _i177.AddCompany(
      companyManagementRepository: gh<_i83.CompanyManagementRepository>()));
  gh.lazySingleton<_i178.AddCompanyLogo>(() =>
      _i178.AddCompanyLogo(repository: gh<_i83.CompanyManagementRepository>()));
  gh.lazySingleton<_i179.AddGroup>(
      () => _i179.AddGroup(groupRepository: gh<_i141.GroupRepository>()));
  gh.lazySingleton<_i180.AddLocation>(() =>
      _i180.AddLocation(locationRepository: gh<_i145.LocationRepository>()));
  gh.factory<_i181.AssetInternalNumberCubit>(
      () => _i181.AssetInternalNumberCubit(gh<_i79.CheckCodeAvailability>()));
  gh.lazySingleton<_i182.AuthenticationBloc>(() => _i182.AuthenticationBloc(
        signin: gh<_i152.Signin>(),
        signup: gh<_i154.Signup>(),
        signout: gh<_i153.Signout>(),
        autoSignin: gh<_i76.AutoSignin>(),
        sendVerificationEmail: gh<_i151.SendVerificationEmail>(),
        checkEmailVerification: gh<_i80.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i150.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i183.CacheGroups>(
      () => _i183.CacheGroups(groupRepository: gh<_i141.GroupRepository>()));
  gh.lazySingleton<_i184.CacheLocation>(() =>
      _i184.CacheLocation(locationRepository: gh<_i145.LocationRepository>()));
  gh.lazySingleton<_i185.DeleteGroup>(
      () => _i185.DeleteGroup(groupRepository: gh<_i141.GroupRepository>()));
  gh.lazySingleton<_i186.DeleteLocation>(() =>
      _i186.DeleteLocation(locationRepository: gh<_i145.LocationRepository>()));
  gh.lazySingleton<_i187.FetchAllLocations>(() => _i187.FetchAllLocations(
      locationRepository: gh<_i145.LocationRepository>()));
  gh.lazySingleton<_i188.GetGroupsStream>(() =>
      _i188.GetGroupsStream(groupRepository: gh<_i141.GroupRepository>()));
  gh.lazySingleton<_i189.UserProfileBloc>(() => _i189.UserProfileBloc(
        authenticationBloc: gh<_i182.AuthenticationBloc>(),
        addUser: gh<_i59.AddUser>(),
        assignUserToCompany: gh<_i72.AssignUserToCompany>(),
        resetCompany: gh<_i149.ResetCompany>(),
        getUserById: gh<_i137.GetUserById>(),
        getUserStreamById: gh<_i138.GetUserStreamById>(),
        updateUserData: gh<_i170.UpdateUserData>(),
        addUserAvatar: gh<_i60.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.factory<_i190.WorkRequestManagementBloc>(
      () => _i190.WorkRequestManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addWorkRequest: gh<_i61.AddWorkRequest>(),
            deleteWorkRequest: gh<_i105.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i171.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i78.CancelWorkRequest>(),
          ));
  gh.factory<_i191.AssetActionBloc>(() => _i191.AssetActionBloc(
        authenticationBloc: gh<_i182.AuthenticationBloc>(),
        getAssetActionsStream: gh<_i113.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i131.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i192.AssetActionManagementBloc>(
      () => _i192.AssetActionManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addAssetAction: gh<_i174.AddAssetAction>(),
            updateAssetAction: gh<_i164.UpdateAssetAction>(),
            deleteAssetAction: gh<_i93.DeleteAssetAction>(),
          ));
  gh.singleton<_i193.AssetCategoryBloc>(_i193.AssetCategoryBloc(
    authenticationBloc: gh<_i182.AuthenticationBloc>(),
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    getAssetsCategoriesStream: gh<_i114.GetAssetsCategoriesStream>(),
  ));
  gh.factory<_i194.AssetCategoryManagementBloc>(
      () => _i194.AssetCategoryManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addAssetCategory: gh<_i175.AddAssetCategory>(),
            updateAssetCategory: gh<_i165.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i94.DeleteAssetCategory>(),
          ));
  gh.factory<_i195.AssetManagementBloc>(() => _i195.AssetManagementBloc(
        userProfileBloc: gh<_i189.UserProfileBloc>(),
        addAsset: gh<_i173.AddAsset>(),
        deleteAsset: gh<_i92.DeleteAsset>(),
        updateAsset: gh<_i163.UpdateAsset>(),
      ));
  gh.factory<_i196.AssetPartsBloc>(() => _i196.AssetPartsBloc(
        authenticationBloc: gh<_i182.AuthenticationBloc>(),
        userProfileBloc: gh<_i189.UserProfileBloc>(),
        getAssetsStreamForParent: gh<_i116.GetAssetsStreamForParent>(),
      ));
  gh.singleton<_i197.ChecklistBloc>(_i197.ChecklistBloc(
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    getChecklistsStream: gh<_i119.GetChecklistStream>(),
  ));
  gh.factory<_i198.ChecklistManagementBloc>(() => _i198.ChecklistManagementBloc(
        userProfileBloc: gh<_i189.UserProfileBloc>(),
        addChecklist: gh<_i176.AddChecklist>(),
        updateChecklist: gh<_i166.UpdateChecklist>(),
        deleteChecklist: gh<_i95.DeleteChecklist>(),
      ));
  gh.singleton<_i199.CompanyManagementBloc>(_i199.CompanyManagementBloc(
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    inputValidator: gh<_i8.InputValidator>(),
    addCompany: gh<_i177.AddCompany>(),
    fetchAllCompanies: gh<_i106.FetchAllCompanies>(),
    addCompanyLogo: gh<_i178.AddCompanyLogo>(),
    updateCompany: gh<_i167.UpdateCompany>(),
  ));
  gh.singleton<_i200.CompanyProfileBloc>(_i200.CompanyProfileBloc(
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    fetchAllCompanyUsers: gh<_i107.FetchAllCompanyUsers>(),
    getCompanyById: gh<_i120.GetCompanyById>(),
    inputValidator: gh<_i8.InputValidator>(),
  ));
  gh.singleton<_i201.GroupBloc>(_i201.GroupBloc(
    companyProfileBloc: gh<_i200.CompanyProfileBloc>(),
    addGroup: gh<_i179.AddGroup>(),
    updateGroup: gh<_i168.UpdateGroup>(),
    deleteGroup: gh<_i185.DeleteGroup>(),
    getGroupsStream: gh<_i188.GetGroupsStream>(),
    cacheGroups: gh<_i183.CacheGroups>(),
    tryToGetCachedGroups: gh<_i157.TryToGetCachedGroups>(),
  ));
  gh.singleton<_i202.InstructionCategoryBloc>(_i202.InstructionCategoryBloc(
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    getInstructionsCategoriesStream:
        gh<_i126.GetInstructionsCategoriesStream>(),
  ));
  gh.factory<_i203.InstructionCategoryManagementBloc>(
      () => _i203.InstructionCategoryManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addInstructionCategory: gh<_i51.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i34.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i97.DeleteInstructionCategory>(),
          ));
  gh.factory<_i204.InstructionManagementBloc>(
      () => _i204.InstructionManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addInstruction: gh<_i50.AddInstruction>(),
            deleteInstruction: gh<_i96.DeleteInstruction>(),
            updateInstruction: gh<_i33.UpdateInstruction>(),
          ));
  gh.factory<_i205.ItemActionManagementBloc>(
      () => _i205.ItemActionManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addItemAction: gh<_i53.AddItemAction>(),
            updateItemAction: gh<_i36.UpdateItemAction>(),
            deleteItemAction: gh<_i99.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.singleton<_i206.ItemCategoryBloc>(_i206.ItemCategoryBloc(
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    getItemsCategoriesStream: gh<_i129.GetItemsCategoriesStream>(),
  ));
  gh.factory<_i207.ItemCategoryManagementBloc>(
      () => _i207.ItemCategoryManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addItemCategory: gh<_i54.AddItemCategory>(),
            updateItemCategory: gh<_i37.UpdateItemCategory>(),
            deleteItemCategory: gh<_i100.DeleteItemCategory>(),
          ));
  gh.factory<_i208.ItemsManagementBloc>(() => _i208.ItemsManagementBloc(
        addItemPhoto: gh<_i55.AddItemPhoto>(),
        deleteItemPhoto: gh<_i101.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i38.UpdateItemPhoto>(),
        userProfileBloc: gh<_i189.UserProfileBloc>(),
        addItem: gh<_i52.AddItem>(),
        deleteItem: gh<_i98.DeleteItem>(),
        updateItem: gh<_i35.UpdateItem>(),
      ));
  gh.singleton<_i209.LocationBloc>(_i209.LocationBloc(
    userProfileBloc: gh<_i189.UserProfileBloc>(),
    addLocation: gh<_i180.AddLocation>(),
    cacheLocation: gh<_i184.CacheLocation>(),
    deleteLocation: gh<_i186.DeleteLocation>(),
    fetchAllLocations: gh<_i187.FetchAllLocations>(),
    tryToGetCachedLocation: gh<_i158.TryToGetCachedLocation>(),
    updateLocation: gh<_i169.UpdateLocation>(),
  ));
  gh.singleton<_i210.NewUsersBloc>(_i210.NewUsersBloc(
    gh<_i200.CompanyProfileBloc>(),
    gh<_i108.FetchNewUsers>(),
  ));
  gh.singleton<_i211.SuspendedUsersBloc>(_i211.SuspendedUsersBloc(
    gh<_i200.CompanyProfileBloc>(),
    gh<_i109.FetchSuspendedUsers>(),
  ));
  gh.factory<_i212.TaskActionManagementBloc>(
      () => _i212.TaskActionManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addTaskAction: gh<_i57.AddTaskAction>(),
            deleteTaskAction: gh<_i103.DeleteTaskAction>(),
            updateTaskAction: gh<_i40.UpdateTaskAction>(),
          ));
  gh.factory<_i213.TaskManagementBloc>(() => _i213.TaskManagementBloc(
        userProfileBloc: gh<_i189.UserProfileBloc>(),
        addTask: gh<_i56.AddTask>(),
        deleteTask: gh<_i102.DeleteTask>(),
        updateTask: gh<_i39.UpdateTask>(),
        cancelTask: gh<_i77.CancelTask>(),
        completeTask: gh<_i87.CompleteTask>(),
      ));
  gh.factory<_i214.TaskTemplatesBloc>(() => _i214.TaskTemplatesBloc(
        userProfileBloc: gh<_i189.UserProfileBloc>(),
        getTasksTemplatesStream: gh<_i136.GetTasksTemplatesStream>(),
      ));
  gh.factory<_i215.TaskTemplatesManagementBloc>(
      () => _i215.TaskTemplatesManagementBloc(
            userProfileBloc: gh<_i189.UserProfileBloc>(),
            addTaskTemplate: gh<_i58.AddTaskTemplate>(),
            updateTaskTemplate: gh<_i41.UpdateTaskTemplate>(),
            deleteTaskTemplate: gh<_i104.DeleteTaskTemplate>(),
          ));
  gh.singleton<_i216.FilterBloc>(_i216.FilterBloc(
    locationBloc: gh<_i209.LocationBloc>(),
    groupBloc: gh<_i201.GroupBloc>(),
    userProfileBloc: gh<_i189.UserProfileBloc>(),
  ));
  gh.singleton<_i217.InstructionBloc>(_i217.InstructionBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getInstructionsStream: gh<_i127.GetInstructionsStream>(),
  ));
  gh.singleton<_i218.ItemsBloc>(_i218.ItemsBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getChecklistsStream: gh<_i130.GetItemsStream>(),
  ));
  gh.singleton<_i219.TaskArchiveBloc>(_i219.TaskArchiveBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getArchiveTasksStream: gh<_i111.GetArchiveTasksStream>(),
  ));
  gh.singleton<_i220.TaskArchiveLatestBloc>(_i220.TaskArchiveLatestBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getArchiveLatestTasksStream: gh<_i110.GetArchiveLatestTasksStream>(),
  ));
  gh.singleton<_i221.TaskBloc>(_i221.TaskBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getTasksStream: gh<_i135.GetTasksStream>(),
  ));
  gh.singleton<_i222.WorkRequestArchiveBloc>(_i222.WorkRequestArchiveBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getArchiveWorkRequestsStream: gh<_i112.GetArchiveWorkRequestsStream>(),
  ));
  gh.singleton<_i223.WorkRequestBloc>(_i223.WorkRequestBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getWorkRequestsStream: gh<_i139.GetWorkRequestsStream>(),
  ));
  gh.singleton<_i224.WorkRequestsStatusBloc>(_i224.WorkRequestsStatusBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getAwaitingWorkRequestsCount: gh<_i117.GetAwaitingWorkRequestsCount>(),
    getConvertedWorkRequestsCount: gh<_i121.GetConvertedWorkRequestsCount>(),
    getCancelledWorkRequestsCount: gh<_i118.GetCancelledWorkRequestsCount>(),
  ));
  gh.singleton<_i225.AssetBloc>(_i225.AssetBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    authenticationBloc: gh<_i182.AuthenticationBloc>(),
    getAssetsStream: gh<_i115.GetAssetsStream>(),
  ));
  gh.singleton<_i226.DashboardAssetActionBloc>(_i226.DashboardAssetActionBloc(
    authenticationBloc: gh<_i182.AuthenticationBloc>(),
    filterBloc: gh<_i216.FilterBloc>(),
    getDashboardAssetActionsStream: gh<_i122.GetDashboardAssetActionsStream>(),
    getDashboardLastFiveAssetActionsStream:
        gh<_i124.GetDashboardLastFiveAssetActionsStream>(),
  ));
  gh.singleton<_i227.DashboardItemActionBloc>(_i227.DashboardItemActionBloc(
    filterBloc: gh<_i216.FilterBloc>(),
    getDashboardItemsActionsStream: gh<_i123.GetDashboardItemsActionsStream>(),
    getDashboardLastFiveItemsActionsStream:
        gh<_i125.GetDashboardLastFiveItemsActionsStream>(),
  ));
  gh.singleton<_i228.TaskFilterBloc>(_i228.TaskFilterBloc(
    gh<_i189.UserProfileBloc>(),
    gh<_i221.TaskBloc>(),
    gh<_i223.WorkRequestBloc>(),
  ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i229.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i229.FirebaseStorageService {}

class _$SharedPreferencesService extends _i229.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i230.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i230.DataConnectionCheckerModule {}
