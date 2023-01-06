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
    as _i60;
import 'package:under_control_v2/features/assets/data/repositories/asset_category_repository_impl.dart'
    as _i62;
import 'package:under_control_v2/features/assets/data/repositories/asset_repository_impl.dart'
    as _i64;
import 'package:under_control_v2/features/assets/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i83;
import 'package:under_control_v2/features/assets/domain/repositories/asset_action_repository.dart'
    as _i59;
import 'package:under_control_v2/features/assets/domain/repositories/asset_category_repository.dart'
    as _i61;
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart'
    as _i63;
import 'package:under_control_v2/features/assets/domain/repositories/dashboard_asset_action_repository.dart'
    as _i82;
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart'
    as _i162;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart'
    as _i163;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart'
    as _i87;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart'
    as _i106;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart'
    as _i112;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart'
    as _i114;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart'
    as _i121;
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart'
    as _i153;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart'
    as _i164;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart'
    as _i88;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart'
    as _i107;
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart'
    as _i154;
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart'
    as _i73;
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart'
    as _i86;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart'
    as _i108;
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream_for_parent.dart'
    as _i109;
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart'
    as _i152;
import 'package:under_control_v2/features/assets/presentation/blocs/asset/asset_bloc.dart'
    as _i211;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart'
    as _i170;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart'
    as _i198;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart'
    as _i180;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart'
    as _i199;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart'
    as _i181;
import 'package:under_control_v2/features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart'
    as _i200;
import 'package:under_control_v2/features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart'
    as _i212;
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart'
    as _i171;
import 'package:under_control_v2/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i69;
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart'
    as _i68;
import 'package:under_control_v2/features/authentication/domain/usecases/auto_signin.dart'
    as _i70;
import 'package:under_control_v2/features/authentication/domain/usecases/check_email_verification.dart'
    as _i74;
import 'package:under_control_v2/features/authentication/domain/usecases/send_password_reset_email.dart'
    as _i139;
import 'package:under_control_v2/features/authentication/domain/usecases/send_verification_email.dart'
    as _i140;
import 'package:under_control_v2/features/authentication/domain/usecases/signin.dart'
    as _i141;
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart'
    as _i142;
import 'package:under_control_v2/features/authentication/domain/usecases/signup.dart'
    as _i143;
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart'
    as _i172;
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart'
    as _i76;
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart'
    as _i75;
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart'
    as _i165;
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart'
    as _i89;
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart'
    as _i110;
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart'
    as _i155;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart'
    as _i201;
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart'
    as _i202;
import 'package:under_control_v2/features/company_profile/data/repositories/company_management_repository_impl.dart'
    as _i78;
import 'package:under_control_v2/features/company_profile/data/repositories/company_repository_impl.dart'
    as _i80;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart'
    as _i77;
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart'
    as _i79;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart'
    as _i166;
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart'
    as _i167;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart'
    as _i99;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart'
    as _i100;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart'
    as _i101;
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart'
    as _i102;
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart'
    as _i111;
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart'
    as _i156;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart'
    as _i182;
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart'
    as _i183;
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart'
    as _i193;
import 'package:under_control_v2/features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart'
    as _i194;
import 'package:under_control_v2/features/core/network/network_info.dart'
    as _i24;
import 'package:under_control_v2/features/core/utils/input_validator.dart'
    as _i8;
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart'
    as _i203;
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart'
    as _i129;
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart'
    as _i7;
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart'
    as _i131;
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart'
    as _i130;
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart'
    as _i168;
import 'package:under_control_v2/features/groups/domain/usecases/cache_groups.dart'
    as _i173;
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart'
    as _i175;
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart'
    as _i178;
import 'package:under_control_v2/features/groups/domain/usecases/try_to_get_cached_groups.dart'
    as _i146;
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart'
    as _i157;
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart'
    as _i184;
import 'package:under_control_v2/features/inventory/data/repositories/dashboard_item_action_repository_impl.dart'
    as _i85;
import 'package:under_control_v2/features/inventory/data/repositories/item_action_repository_impl.dart'
    as _i14;
import 'package:under_control_v2/features/inventory/data/repositories/item_category_repository_impl.dart'
    as _i16;
import 'package:under_control_v2/features/inventory/data/repositories/item_fles_repository_impl.dart'
    as _i18;
import 'package:under_control_v2/features/inventory/data/repositories/item_repository_impl.dart'
    as _i20;
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart'
    as _i84;
import 'package:under_control_v2/features/inventory/domain/repositories/item_action_repository.dart'
    as _i13;
import 'package:under_control_v2/features/inventory/domain/repositories/item_category_repository.dart'
    as _i15;
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart'
    as _i17;
import 'package:under_control_v2/features/inventory/domain/repositories/item_repository.dart'
    as _i19;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart'
    as _i47;
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart'
    as _i50;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart'
    as _i92;
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart'
    as _i95;
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart'
    as _i120;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart'
    as _i48;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart'
    as _i93;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart'
    as _i113;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart'
    as _i115;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart'
    as _i118;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart'
    as _i122;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart'
    as _i23;
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart'
    as _i34;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart'
    as _i49;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart'
    as _i94;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart'
    as _i119;
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart'
    as _i35;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart'
    as _i33;
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart'
    as _i36;
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart'
    as _i213;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart'
    as _i132;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart'
    as _i188;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart'
    as _i189;
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart'
    as _i190;
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart'
    as _i205;
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart'
    as _i191;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_category_repository_impl.dart'
    as _i10;
import 'package:under_control_v2/features/knowledge_base/data/repositories/instruction_repository_impl.dart'
    as _i12;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart'
    as _i9;
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart'
    as _i11;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart'
    as _i45;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart'
    as _i90;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart'
    as _i117;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart'
    as _i46;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/delete_instruction_category.dart'
    as _i91;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart'
    as _i116;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/update_instruction_category.dart'
    as _i32;
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart'
    as _i31;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart'
    as _i204;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart'
    as _i185;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart'
    as _i186;
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart'
    as _i187;
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart'
    as _i133;
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart'
    as _i22;
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart'
    as _i135;
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart'
    as _i134;
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart'
    as _i169;
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart'
    as _i174;
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart'
    as _i176;
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart'
    as _i177;
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart'
    as _i147;
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart'
    as _i158;
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart'
    as _i192;
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
    as _i51;
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart'
    as _i71;
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart'
    as _i81;
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart'
    as _i96;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_latest_tasks_stream.dart'
    as _i103;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_archive_tasks_stream.dart'
    as _i104;
import 'package:under_control_v2/features/tasks/domain/usecases/task/get_tasks_stream.dart'
    as _i125;
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart'
    as _i37;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart'
    as _i52;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart'
    as _i97;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_latest_task_actions_stream.dart'
    as _i123;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart'
    as _i124;
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart'
    as _i38;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_request.dart'
    as _i55;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart'
    as _i72;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_request.dart'
    as _i98;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart'
    as _i105;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_work_requests_stream.dart'
    as _i128;
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_request.dart'
    as _i160;
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart'
    as _i25;
import 'package:under_control_v2/features/tasks/presentation/blocs/task/task_bloc.dart'
    as _i208;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart'
    as _i145;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart'
    as _i195;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart'
    as _i206;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart'
    as _i207;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart'
    as _i214;
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart'
    as _i196;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart'
    as _i210;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart'
    as _i209;
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart'
    as _i197;
import 'package:under_control_v2/features/user_profile/data/repositories/user_files_repository_impl.dart'
    as _i40;
import 'package:under_control_v2/features/user_profile/data/repositories/user_profile_repository_impl.dart'
    as _i42;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart'
    as _i39;
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart'
    as _i41;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart'
    as _i53;
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart'
    as _i54;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart'
    as _i56;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart'
    as _i57;
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart'
    as _i58;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart'
    as _i65;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart'
    as _i66;
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart'
    as _i67;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart'
    as _i126;
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_stream_by_id.dart'
    as _i127;
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart'
    as _i136;
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart'
    as _i137;
import 'package:under_control_v2/features/user_profile/domain/usecases/reset_company.dart'
    as _i138;
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart'
    as _i144;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart'
    as _i148;
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart'
    as _i149;
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart'
    as _i150;
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart'
    as _i151;
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart'
    as _i159;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart'
    as _i161;
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i179;

import 'features/authentication/domain/repositories/injectable_modules.dart'
    as _i216;
import 'features/core/injectable_modules/injectable_modules.dart' as _i215;

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
  gh.lazySingleton<_i45.AddInstruction>(
      () => _i45.AddInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i46.AddInstructionCategory>(() =>
      _i46.AddInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i47.AddItem>(
      () => _i47.AddItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i48.AddItemAction>(
      () => _i48.AddItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i49.AddItemCategory>(() =>
      _i49.AddItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i50.AddItemPhoto>(
      () => _i50.AddItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i51.AddTask>(
      () => _i51.AddTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i52.AddTaskAction>(
      () => _i52.AddTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i53.AddUser>(
      () => _i53.AddUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i54.AddUserAvatar>(
      () => _i54.AddUserAvatar(repository: gh<_i39.UserFilesRepository>()));
  gh.lazySingleton<_i55.AddWorkRequest>(
      () => _i55.AddWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i56.ApprovePassiveUser>(() =>
      _i56.ApprovePassiveUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i57.ApproveUser>(
      () => _i57.ApproveUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i58.ApproveUserAndMakeAdmin>(() =>
      _i58.ApproveUserAndMakeAdmin(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i59.AssetActionRepository>(() =>
      _i60.AssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i61.AssetCategoryRepository>(() =>
      _i62.AssetCategoryRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i63.AssetRepository>(() => _i64.AssetRepositoryImpl(
        firebaseFirestore: gh<_i5.FirebaseFirestore>(),
        firebaseStorage: gh<_i6.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i65.AssignGroupAdmin>(() =>
      _i65.AssignGroupAdmin(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i66.AssignUserToCompany>(() =>
      _i66.AssignUserToCompany(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i67.AssignUserToGroup>(() =>
      _i67.AssignUserToGroup(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i68.AuthenticationRepository>(
      () => _i69.AuthenticationRepositoryImpl(
            firebaseAuth: gh<_i4.FirebaseAuth>(),
            networkInfo: gh<_i24.NetworkInfo>(),
          ));
  gh.lazySingleton<_i70.AutoSignin>(() => _i70.AutoSignin(
      authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i71.CancelTask>(
      () => _i71.CancelTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i72.CancelWorkRequest>(() =>
      _i72.CancelWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i73.CheckCodeAvailability>(
      () => _i73.CheckCodeAvailability(repository: gh<_i63.AssetRepository>()));
  gh.lazySingleton<_i74.CheckEmailVerification>(() =>
      _i74.CheckEmailVerification(
          authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i75.CheckListsRepository>(() =>
      _i76.ChecklistsRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i77.CompanyManagementRepository>(
      () => _i78.CompanyManagementRepositoryImpl(
            firebaseFirestore: gh<_i5.FirebaseFirestore>(),
            firebaseStorage: gh<_i6.FirebaseStorage>(),
          ));
  gh.lazySingleton<_i79.CompanyRepository>(() => _i80.CompanyRepositoryImpl(
      firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i81.CompleteTask>(
      () => _i81.CompleteTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i82.DashboardAssetActionRepository>(() =>
      _i83.DashboardAssetActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i84.DashboardItemActionRepository>(() =>
      _i85.DashboardItemActionRepositoryImpl(
          firebaseFirestore: gh<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i86.DeleteAsset>(
      () => _i86.DeleteAsset(repository: gh<_i63.AssetRepository>()));
  gh.lazySingleton<_i87.DeleteAssetAction>(() =>
      _i87.DeleteAssetAction(repository: gh<_i59.AssetActionRepository>()));
  gh.lazySingleton<_i88.DeleteAssetCategory>(() =>
      _i88.DeleteAssetCategory(repository: gh<_i61.AssetCategoryRepository>()));
  gh.lazySingleton<_i89.DeleteChecklist>(
      () => _i89.DeleteChecklist(repository: gh<_i75.CheckListsRepository>()));
  gh.lazySingleton<_i90.DeleteInstruction>(() =>
      _i90.DeleteInstruction(repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i91.DeleteInstructionCategory>(() =>
      _i91.DeleteInstructionCategory(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i92.DeleteItem>(
      () => _i92.DeleteItem(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i93.DeleteItemAction>(
      () => _i93.DeleteItemAction(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i94.DeleteItemCategory>(() =>
      _i94.DeleteItemCategory(repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i95.DeleteItemPhoto>(
      () => _i95.DeleteItemPhoto(repository: gh<_i17.ItemFilesRepository>()));
  gh.lazySingleton<_i96.DeleteTask>(
      () => _i96.DeleteTask(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i97.DeleteTaskAction>(
      () => _i97.DeleteTaskAction(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i98.DeleteWorkRequest>(() =>
      _i98.DeleteWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i99.FetchAllCompanies>(() => _i99.FetchAllCompanies(
      companyManagementRepository: gh<_i77.CompanyManagementRepository>()));
  gh.lazySingleton<_i100.FetchAllCompanyUsers>(() => _i100.FetchAllCompanyUsers(
      companyRepository: gh<_i79.CompanyRepository>()));
  gh.lazySingleton<_i101.FetchNewUsers>(() =>
      _i101.FetchNewUsers(companyRepository: gh<_i79.CompanyRepository>()));
  gh.lazySingleton<_i102.FetchSuspendedUsers>(() => _i102.FetchSuspendedUsers(
      companyRepository: gh<_i79.CompanyRepository>()));
  gh.lazySingleton<_i103.GetArchiveLatestTasksStream>(() =>
      _i103.GetArchiveLatestTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i104.GetArchiveTasksStream>(
      () => _i104.GetArchiveTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i105.GetArchiveWorkRequestsStream>(() =>
      _i105.GetArchiveWorkRequestsStream(
          repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i106.GetAssetActionsStream>(() =>
      _i106.GetAssetActionsStream(
          repository: gh<_i59.AssetActionRepository>()));
  gh.lazySingleton<_i107.GetAssetsCategoriesStream>(() =>
      _i107.GetAssetsCategoriesStream(
          repository: gh<_i61.AssetCategoryRepository>()));
  gh.lazySingleton<_i108.GetAssetsStream>(
      () => _i108.GetAssetsStream(repository: gh<_i63.AssetRepository>()));
  gh.lazySingleton<_i109.GetAssetsStreamForParent>(() =>
      _i109.GetAssetsStreamForParent(repository: gh<_i63.AssetRepository>()));
  gh.lazySingleton<_i110.GetChecklistStream>(() =>
      _i110.GetChecklistStream(repository: gh<_i75.CheckListsRepository>()));
  gh.lazySingleton<_i111.GetCompanyById>(() =>
      _i111.GetCompanyById(companyRepository: gh<_i79.CompanyRepository>()));
  gh.lazySingleton<_i112.GetDashboardAssetActionsStream>(() =>
      _i112.GetDashboardAssetActionsStream(
          repository: gh<_i82.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i113.GetDashboardItemsActionsStream>(() =>
      _i113.GetDashboardItemsActionsStream(
          repository: gh<_i84.DashboardItemActionRepository>()));
  gh.lazySingleton<_i114.GetDashboardLastFiveAssetActionsStream>(() =>
      _i114.GetDashboardLastFiveAssetActionsStream(
          repository: gh<_i82.DashboardAssetActionRepository>()));
  gh.lazySingleton<_i115.GetDashboardLastFiveItemsActionsStream>(() =>
      _i115.GetDashboardLastFiveItemsActionsStream(
          repository: gh<_i84.DashboardItemActionRepository>()));
  gh.lazySingleton<_i116.GetInstructionsCategoriesStream>(() =>
      _i116.GetInstructionsCategoriesStream(
          repository: gh<_i9.InstructionCategoryRepository>()));
  gh.lazySingleton<_i117.GetInstructionsStream>(() =>
      _i117.GetInstructionsStream(
          repository: gh<_i11.InstructionRepository>()));
  gh.lazySingleton<_i118.GetItemsActionsStream>(() =>
      _i118.GetItemsActionsStream(repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i119.GetItemsCategoriesStream>(() =>
      _i119.GetItemsCategoriesStream(
          repository: gh<_i15.ItemCategoryRepository>()));
  gh.lazySingleton<_i120.GetItemsStream>(
      () => _i120.GetItemsStream(repository: gh<_i19.ItemRepository>()));
  gh.lazySingleton<_i121.GetLastFiveAssetActionsStream>(() =>
      _i121.GetLastFiveAssetActionsStream(
          repository: gh<_i59.AssetActionRepository>()));
  gh.lazySingleton<_i122.GetLastFiveItemsActionsStream>(() =>
      _i122.GetLastFiveItemsActionsStream(
          repository: gh<_i13.ItemActionRepository>()));
  gh.lazySingleton<_i123.GetLatestTaskActionsStream>(() =>
      _i123.GetLatestTaskActionsStream(
          repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i124.GetTaskActionsStream>(() =>
      _i124.GetTaskActionsStream(repository: gh<_i27.TaskActionRepository>()));
  gh.lazySingleton<_i125.GetTasksStream>(
      () => _i125.GetTasksStream(repository: gh<_i29.TaskRepository>()));
  gh.lazySingleton<_i126.GetUserById>(
      () => _i126.GetUserById(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i127.GetUserStreamById>(() => _i127.GetUserStreamById(
      userRepository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i128.GetWorkRequestsStream>(() =>
      _i128.GetWorkRequestsStream(
          repository: gh<_i43.WorkRequestsRepository>()));
  gh.lazySingleton<_i129.GroupLocalDataSource>(() =>
      _i129.GroupLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i130.GroupRepository>(() => _i131.GroupRepositoryImpl(
        groupRemoteDataSource: gh<_i7.GroupRemoteDataSource>(),
        groupLocalDataSource: gh<_i129.GroupLocalDataSource>(),
      ));
  gh.factory<_i132.ItemActionBloc>(() => _i132.ItemActionBloc(
        getItemsActionsStream: gh<_i118.GetItemsActionsStream>(),
        getLastFiveItemsActionsStream:
            gh<_i122.GetLastFiveItemsActionsStream>(),
      ));
  gh.lazySingleton<_i133.LocationLocalDataSource>(() =>
      _i133.LocationLocalDataSourceImpl(source: gh<_i26.SharedPreferences>()));
  gh.lazySingleton<_i134.LocationRepository>(() => _i135.LocationRepositoryImpl(
        locationLocalDataSource: gh<_i133.LocationLocalDataSource>(),
        locationRemoteDataSource: gh<_i22.LocationRemoteDataSource>(),
      ));
  gh.lazySingleton<_i136.MakeUserAdministrator>(() =>
      _i136.MakeUserAdministrator(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i137.RejectUser>(
      () => _i137.RejectUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i138.ResetCompany>(
      () => _i138.ResetCompany(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i139.SendPasswordResetEmail>(() =>
      _i139.SendPasswordResetEmail(
          authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i140.SendVerificationEmail>(() =>
      _i140.SendVerificationEmail(
          authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i141.Signin>(() => _i141.Signin(
      authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i142.Signout>(() => _i142.Signout(
      authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i143.Signup>(() => _i143.Signup(
      authenticationRepository: gh<_i68.AuthenticationRepository>()));
  gh.lazySingleton<_i144.SuspendUser>(
      () => _i144.SuspendUser(repository: gh<_i41.UserProfileRepository>()));
  gh.factory<_i145.TaskActionBloc>(() => _i145.TaskActionBloc(
      getTaskActionsStream: gh<_i124.GetTaskActionsStream>()));
  gh.lazySingleton<_i146.TryToGetCachedGroups>(() =>
      _i146.TryToGetCachedGroups(groupRepository: gh<_i130.GroupRepository>()));
  gh.lazySingleton<_i147.TryToGetCachedLocation>(() =>
      _i147.TryToGetCachedLocation(
          locationRepository: gh<_i134.LocationRepository>()));
  gh.lazySingleton<_i148.UnassignGroupAdmin>(() =>
      _i148.UnassignGroupAdmin(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i149.UnassignUserFromGroup>(() =>
      _i149.UnassignUserFromGroup(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i150.UnmakeUserAdministrator>(() =>
      _i150.UnmakeUserAdministrator(
          repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i151.UnsuspendUser>(
      () => _i151.UnsuspendUser(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i152.UpdateAsset>(
      () => _i152.UpdateAsset(repository: gh<_i63.AssetRepository>()));
  gh.lazySingleton<_i153.UpdateAssetAction>(() =>
      _i153.UpdateAssetAction(repository: gh<_i59.AssetActionRepository>()));
  gh.lazySingleton<_i154.UpdateAssetCategory>(() => _i154.UpdateAssetCategory(
      repository: gh<_i61.AssetCategoryRepository>()));
  gh.lazySingleton<_i155.UpdateChecklist>(
      () => _i155.UpdateChecklist(repository: gh<_i75.CheckListsRepository>()));
  gh.lazySingleton<_i156.UpdateCompany>(() => _i156.UpdateCompany(
      companyRepository: gh<_i77.CompanyManagementRepository>()));
  gh.lazySingleton<_i157.UpdateGroup>(
      () => _i157.UpdateGroup(groupRepository: gh<_i130.GroupRepository>()));
  gh.lazySingleton<_i158.UpdateLocation>(() =>
      _i158.UpdateLocation(locationRepository: gh<_i134.LocationRepository>()));
  gh.lazySingleton<_i159.UpdateUserData>(
      () => _i159.UpdateUserData(repository: gh<_i41.UserProfileRepository>()));
  gh.lazySingleton<_i160.UpdateWorkRequest>(() =>
      _i160.UpdateWorkRequest(repository: gh<_i43.WorkRequestsRepository>()));
  gh.factory<_i161.UserManagementBloc>(() => _i161.UserManagementBloc(
        approveUser: gh<_i57.ApproveUser>(),
        approvePassiveUser: gh<_i56.ApprovePassiveUser>(),
        makeUserAdministrator: gh<_i136.MakeUserAdministrator>(),
        unmakeUserAdministrator: gh<_i150.UnmakeUserAdministrator>(),
        approveUserAndMakeAdmin: gh<_i58.ApproveUserAndMakeAdmin>(),
        rejectUser: gh<_i137.RejectUser>(),
        suspendUser: gh<_i144.SuspendUser>(),
        unsuspendUser: gh<_i151.UnsuspendUser>(),
        updateUserData: gh<_i159.UpdateUserData>(),
        assignUserToGroup: gh<_i67.AssignUserToGroup>(),
        unassignUserFromGroup: gh<_i149.UnassignUserFromGroup>(),
        assignGroupAdmin: gh<_i65.AssignGroupAdmin>(),
        unassignGroupAdmin: gh<_i148.UnassignGroupAdmin>(),
        addUserAvatar: gh<_i54.AddUserAvatar>(),
      ));
  gh.lazySingleton<_i162.AddAsset>(
      () => _i162.AddAsset(repository: gh<_i63.AssetRepository>()));
  gh.lazySingleton<_i163.AddAssetAction>(
      () => _i163.AddAssetAction(repository: gh<_i59.AssetActionRepository>()));
  gh.lazySingleton<_i164.AddAssetCategory>(() =>
      _i164.AddAssetCategory(repository: gh<_i61.AssetCategoryRepository>()));
  gh.lazySingleton<_i165.AddChecklist>(
      () => _i165.AddChecklist(repository: gh<_i75.CheckListsRepository>()));
  gh.lazySingleton<_i166.AddCompany>(() => _i166.AddCompany(
      companyManagementRepository: gh<_i77.CompanyManagementRepository>()));
  gh.lazySingleton<_i167.AddCompanyLogo>(() =>
      _i167.AddCompanyLogo(repository: gh<_i77.CompanyManagementRepository>()));
  gh.lazySingleton<_i168.AddGroup>(
      () => _i168.AddGroup(groupRepository: gh<_i130.GroupRepository>()));
  gh.lazySingleton<_i169.AddLocation>(() =>
      _i169.AddLocation(locationRepository: gh<_i134.LocationRepository>()));
  gh.factory<_i170.AssetActionBloc>(() => _i170.AssetActionBloc(
        getAssetActionsStream: gh<_i106.GetAssetActionsStream>(),
        getLastFiveAssetActionsStream:
            gh<_i121.GetLastFiveAssetActionsStream>(),
      ));
  gh.factory<_i171.AssetInternalNumberCubit>(
      () => _i171.AssetInternalNumberCubit(gh<_i73.CheckCodeAvailability>()));
  gh.factory<_i172.AuthenticationBloc>(() => _i172.AuthenticationBloc(
        signin: gh<_i141.Signin>(),
        signup: gh<_i143.Signup>(),
        signout: gh<_i142.Signout>(),
        autoSignin: gh<_i70.AutoSignin>(),
        sendVerificationEmail: gh<_i140.SendVerificationEmail>(),
        checkEmailVerification: gh<_i74.CheckEmailVerification>(),
        sendPasswordResetEmail: gh<_i139.SendPasswordResetEmail>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i173.CacheGroups>(
      () => _i173.CacheGroups(groupRepository: gh<_i130.GroupRepository>()));
  gh.lazySingleton<_i174.CacheLocation>(() =>
      _i174.CacheLocation(locationRepository: gh<_i134.LocationRepository>()));
  gh.lazySingleton<_i175.DeleteGroup>(
      () => _i175.DeleteGroup(groupRepository: gh<_i130.GroupRepository>()));
  gh.lazySingleton<_i176.DeleteLocation>(() =>
      _i176.DeleteLocation(locationRepository: gh<_i134.LocationRepository>()));
  gh.lazySingleton<_i177.FetchAllLocations>(() => _i177.FetchAllLocations(
      locationRepository: gh<_i134.LocationRepository>()));
  gh.lazySingleton<_i178.GetGroupsStream>(() =>
      _i178.GetGroupsStream(groupRepository: gh<_i130.GroupRepository>()));
  gh.factory<_i179.UserProfileBloc>(() => _i179.UserProfileBloc(
        authenticationBloc: gh<_i172.AuthenticationBloc>(),
        addUser: gh<_i53.AddUser>(),
        assignUserToCompany: gh<_i66.AssignUserToCompany>(),
        resetCompany: gh<_i138.ResetCompany>(),
        getUserById: gh<_i126.GetUserById>(),
        getUserStreamById: gh<_i127.GetUserStreamById>(),
        updateUserData: gh<_i159.UpdateUserData>(),
        addUserAvatar: gh<_i54.AddUserAvatar>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i180.AssetCategoryBloc>(() => _i180.AssetCategoryBloc(
        userProfileBloc: gh<_i179.UserProfileBloc>(),
        getAssetsCategoriesStream: gh<_i107.GetAssetsCategoriesStream>(),
      ));
  gh.factory<_i181.AssetManagementBloc>(() => _i181.AssetManagementBloc(
        userProfileBloc: gh<_i179.UserProfileBloc>(),
        addAsset: gh<_i162.AddAsset>(),
        deleteAsset: gh<_i86.DeleteAsset>(),
        updateAsset: gh<_i152.UpdateAsset>(),
      ));
  gh.factory<_i182.CompanyManagementBloc>(() => _i182.CompanyManagementBloc(
        userProfileBloc: gh<_i179.UserProfileBloc>(),
        inputValidator: gh<_i8.InputValidator>(),
        addCompany: gh<_i166.AddCompany>(),
        fetchAllCompanies: gh<_i99.FetchAllCompanies>(),
        addCompanyLogo: gh<_i167.AddCompanyLogo>(),
        updateCompany: gh<_i156.UpdateCompany>(),
      ));
  gh.factory<_i183.CompanyProfileBloc>(() => _i183.CompanyProfileBloc(
        userProfileBloc: gh<_i179.UserProfileBloc>(),
        fetchAllCompanyUsers: gh<_i100.FetchAllCompanyUsers>(),
        getCompanyById: gh<_i111.GetCompanyById>(),
        inputValidator: gh<_i8.InputValidator>(),
      ));
  gh.lazySingleton<_i184.GroupBloc>(() => _i184.GroupBloc(
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        addGroup: gh<_i168.AddGroup>(),
        updateGroup: gh<_i157.UpdateGroup>(),
        deleteGroup: gh<_i175.DeleteGroup>(),
        getGroupsStream: gh<_i178.GetGroupsStream>(),
        cacheGroups: gh<_i173.CacheGroups>(),
        tryToGetCachedGroups: gh<_i146.TryToGetCachedGroups>(),
      ));
  gh.lazySingleton<_i185.InstructionCategoryBloc>(
      () => _i185.InstructionCategoryBloc(
            userProfileBloc: gh<_i179.UserProfileBloc>(),
            getInstructionsCategoriesStream:
                gh<_i116.GetInstructionsCategoriesStream>(),
          ));
  gh.factory<_i186.InstructionCategoryManagementBloc>(
      () => _i186.InstructionCategoryManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addInstructionCategory: gh<_i46.AddInstructionCategory>(),
            updateInstructionCategory: gh<_i32.UpdateInstructionCategory>(),
            deleteInstructionCategory: gh<_i91.DeleteInstructionCategory>(),
          ));
  gh.factory<_i187.InstructionManagementBloc>(
      () => _i187.InstructionManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addInstruction: gh<_i45.AddInstruction>(),
            deleteInstruction: gh<_i90.DeleteInstruction>(),
            updateInstruction: gh<_i31.UpdateInstruction>(),
          ));
  gh.factory<_i188.ItemActionManagementBloc>(
      () => _i188.ItemActionManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addItemAction: gh<_i48.AddItemAction>(),
            updateItemAction: gh<_i34.UpdateItemAction>(),
            deleteItemAction: gh<_i93.DeleteItemAction>(),
            moveItemAction: gh<_i23.MoveItemAction>(),
          ));
  gh.lazySingleton<_i189.ItemCategoryBloc>(() => _i189.ItemCategoryBloc(
        userProfileBloc: gh<_i179.UserProfileBloc>(),
        getItemsCategoriesStream: gh<_i119.GetItemsCategoriesStream>(),
      ));
  gh.factory<_i190.ItemCategoryManagementBloc>(
      () => _i190.ItemCategoryManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addItemCategory: gh<_i49.AddItemCategory>(),
            updateItemCategory: gh<_i35.UpdateItemCategory>(),
            deleteItemCategory: gh<_i94.DeleteItemCategory>(),
          ));
  gh.factory<_i191.ItemsManagementBloc>(() => _i191.ItemsManagementBloc(
        addItemPhoto: gh<_i50.AddItemPhoto>(),
        deleteItemPhoto: gh<_i95.DeleteItemPhoto>(),
        updateItemPhoto: gh<_i36.UpdateItemPhoto>(),
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        addItem: gh<_i47.AddItem>(),
        deleteItem: gh<_i92.DeleteItem>(),
        updateItem: gh<_i33.UpdateItem>(),
      ));
  gh.lazySingleton<_i192.LocationBloc>(() => _i192.LocationBloc(
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        addLocation: gh<_i169.AddLocation>(),
        cacheLocation: gh<_i174.CacheLocation>(),
        deleteLocation: gh<_i176.DeleteLocation>(),
        fetchAllLocations: gh<_i177.FetchAllLocations>(),
        tryToGetCachedLocation: gh<_i147.TryToGetCachedLocation>(),
        updateLocation: gh<_i158.UpdateLocation>(),
      ));
  gh.factory<_i193.NewUsersBloc>(() => _i193.NewUsersBloc(
        gh<_i183.CompanyProfileBloc>(),
        gh<_i101.FetchNewUsers>(),
      ));
  gh.factory<_i194.SuspendedUsersBloc>(() => _i194.SuspendedUsersBloc(
        gh<_i183.CompanyProfileBloc>(),
        gh<_i102.FetchSuspendedUsers>(),
      ));
  gh.factory<_i195.TaskActionManagementBloc>(
      () => _i195.TaskActionManagementBloc(
            userProfileBloc: gh<_i179.UserProfileBloc>(),
            addTaskAction: gh<_i52.AddTaskAction>(),
            deleteTaskAction: gh<_i97.DeleteTaskAction>(),
            updateTaskAction: gh<_i38.UpdateTaskAction>(),
          ));
  gh.factory<_i196.TaskManagementBloc>(() => _i196.TaskManagementBloc(
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        addTask: gh<_i51.AddTask>(),
        deleteTask: gh<_i96.DeleteTask>(),
        updateTask: gh<_i37.UpdateTask>(),
        cancelTask: gh<_i71.CancelTask>(),
        completeTask: gh<_i81.CompleteTask>(),
      ));
  gh.factory<_i197.WorkRequestManagementBloc>(
      () => _i197.WorkRequestManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addWorkRequest: gh<_i55.AddWorkRequest>(),
            deleteWorkRequest: gh<_i98.DeleteWorkRequest>(),
            updateWorkRequest: gh<_i160.UpdateWorkRequest>(),
            cancelWorkRequest: gh<_i72.CancelWorkRequest>(),
          ));
  gh.factory<_i198.AssetActionManagementBloc>(
      () => _i198.AssetActionManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addAssetAction: gh<_i163.AddAssetAction>(),
            updateAssetAction: gh<_i153.UpdateAssetAction>(),
            deleteAssetAction: gh<_i87.DeleteAssetAction>(),
          ));
  gh.factory<_i199.AssetCategoryManagementBloc>(
      () => _i199.AssetCategoryManagementBloc(
            companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
            addAssetCategory: gh<_i164.AddAssetCategory>(),
            updateAssetCategory: gh<_i154.UpdateAssetCategory>(),
            deleteAssetCategory: gh<_i88.DeleteAssetCategory>(),
          ));
  gh.factory<_i200.AssetPartsBloc>(() => _i200.AssetPartsBloc(
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        getAssetsStreamForParent: gh<_i109.GetAssetsStreamForParent>(),
      ));
  gh.factory<_i201.ChecklistBloc>(() => _i201.ChecklistBloc(
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        getChecklistsStream: gh<_i110.GetChecklistStream>(),
      ));
  gh.factory<_i202.ChecklistManagementBloc>(() => _i202.ChecklistManagementBloc(
        companyProfileBloc: gh<_i183.CompanyProfileBloc>(),
        addChecklist: gh<_i165.AddChecklist>(),
        updateChecklist: gh<_i155.UpdateChecklist>(),
        deleteChecklist: gh<_i89.DeleteChecklist>(),
      ));
  gh.factory<_i203.FilterBloc>(() => _i203.FilterBloc(
        locationBloc: gh<_i192.LocationBloc>(),
        groupBloc: gh<_i184.GroupBloc>(),
        userProfileBloc: gh<_i179.UserProfileBloc>(),
      ));
  gh.factory<_i204.InstructionBloc>(() => _i204.InstructionBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getInstructionsStream: gh<_i117.GetInstructionsStream>(),
      ));
  gh.factory<_i205.ItemsBloc>(() => _i205.ItemsBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getChecklistsStream: gh<_i120.GetItemsStream>(),
      ));
  gh.factory<_i206.TaskArchiveBloc>(() => _i206.TaskArchiveBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getArchiveTasksStream: gh<_i104.GetArchiveTasksStream>(),
      ));
  gh.factory<_i207.TaskArchiveLatestBloc>(() => _i207.TaskArchiveLatestBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getArchiveLatestTasksStream: gh<_i103.GetArchiveLatestTasksStream>(),
      ));
  gh.factory<_i208.TaskBloc>(() => _i208.TaskBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getTasksStream: gh<_i125.GetTasksStream>(),
      ));
  gh.factory<_i209.WorkRequestArchiveBloc>(() => _i209.WorkRequestArchiveBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getArchiveWorkRequestsStream: gh<_i105.GetArchiveWorkRequestsStream>(),
      ));
  gh.factory<_i210.WorkRequestBloc>(() => _i210.WorkRequestBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getWorkRequestsStream: gh<_i128.GetWorkRequestsStream>(),
      ));
  gh.factory<_i211.AssetBloc>(() => _i211.AssetBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getAssetsStream: gh<_i108.GetAssetsStream>(),
      ));
  gh.factory<_i212.DashboardAssetActionBloc>(
      () => _i212.DashboardAssetActionBloc(
            filterBloc: gh<_i203.FilterBloc>(),
            getDashboardAssetActionsStream:
                gh<_i112.GetDashboardAssetActionsStream>(),
            getDashboardLastFiveAssetActionsStream:
                gh<_i114.GetDashboardLastFiveAssetActionsStream>(),
          ));
  gh.factory<_i213.DashboardItemActionBloc>(() => _i213.DashboardItemActionBloc(
        filterBloc: gh<_i203.FilterBloc>(),
        getDashboardItemsActionsStream:
            gh<_i113.GetDashboardItemsActionsStream>(),
        getDashboardLastFiveItemsActionsStream:
            gh<_i115.GetDashboardLastFiveItemsActionsStream>(),
      ));
  gh.factory<_i214.TaskFilterBloc>(() => _i214.TaskFilterBloc(
        gh<_i179.UserProfileBloc>(),
        gh<_i208.TaskBloc>(),
        gh<_i210.WorkRequestBloc>(),
      ));
  return getIt;
}

class _$FirebaseFirestoreService extends _i215.FirebaseFirestoreService {}

class _$FirebaseStorageService extends _i215.FirebaseStorageService {}

class _$SharedPreferencesService extends _i215.SharedPreferencesService {}

class _$FirebaseAuthenticationService
    extends _i216.FirebaseAuthenticationService {}

class _$DataConnectionCheckerModule extends _i216.DataConnectionCheckerModule {}
