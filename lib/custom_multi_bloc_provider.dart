import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_for_asset/tasks_for_asset_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/cubits/task/task_cubit.dart';

import 'features/assets/presentation/blocs/asset/asset_bloc.dart';
import 'features/assets/presentation/blocs/asset_action/asset_action_bloc.dart';
import 'features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart';
import 'features/assets/presentation/blocs/asset_category/asset_category_bloc.dart';
import 'features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart';
import 'features/assets/presentation/blocs/asset_management/asset_management_bloc.dart';
import 'features/assets/presentation/blocs/asset_parts/asset_parts_bloc.dart';
import 'features/assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart';
import 'features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart';
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/checklists/presentation/blocs/checklist/checklist_bloc.dart';
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart';
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart';
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart';
import 'features/dashboard/presentation/blocs/activity_bloc/activity_bloc_bloc.dart';
import 'features/dashboard/presentation/blocs/task_actions_status/task_actions_status_bloc.dart';
import 'features/dashboard/presentation/blocs/work_requests_status/work_requests_status_bloc.dart';
import 'features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'features/groups/presentation/blocs/group/group_bloc.dart';
import 'features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';
import 'features/inventory/presentation/blocs/item_action/item_action_bloc.dart';
import 'features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart';
import 'features/inventory/presentation/blocs/item_category/item_category_bloc.dart';
import 'features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart';
import 'features/inventory/presentation/blocs/items/items_bloc.dart';
import 'features/inventory/presentation/blocs/items_management/items_management_bloc.dart';
import 'features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import 'features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart';
import 'features/knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart';
import 'features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart';
import 'features/locations/presentation/blocs/bloc/location_bloc.dart';
import 'features/notifications/presentation/blocs/uc_notification/uc_notification_bloc.dart';
import 'features/notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart';
import 'features/notifications/presentation/cubits/cubit/device_token_cubit.dart';
import 'features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart';
import 'features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart';
import 'features/tasks/presentation/blocs/task/task_bloc.dart';
import 'features/tasks/presentation/blocs/task_action/task_action_bloc.dart';
import 'features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart';
import 'features/tasks/presentation/blocs/task_archive/task_archive_bloc.dart';
import 'features/tasks/presentation/blocs/task_archive_latest/task_archive_latest_bloc.dart';
import 'features/tasks/presentation/blocs/task_filter/task_filter_bloc.dart';
import 'features/tasks/presentation/blocs/task_management/task_management_bloc.dart';
import 'features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart';
import 'features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart';
import 'features/tasks/presentation/blocs/work_request/work_request_bloc.dart';
import 'features/tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart';
import 'features/tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart';
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'injection.dart';

class CustomMultiBlocProvider extends StatelessWidget {
  const CustomMultiBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthenticationBloc>()),
        BlocProvider(create: (context) => getIt<UserProfileBloc>()),
        BlocProvider(create: (context) => getIt<UserManagementBloc>()),
        BlocProvider(create: (context) => getIt<CompanyProfileBloc>()),
        BlocProvider(create: (context) => getIt<CompanyManagementBloc>()),
        BlocProvider(create: (context) => getIt<LocationBloc>()),
        BlocProvider(create: (context) => getIt<GroupBloc>()),
        BlocProvider(create: (context) => getIt<NewUsersBloc>()),
        BlocProvider(create: (context) => getIt<SuspendedUsersBloc>()),
        BlocProvider(create: (context) => getIt<ChecklistBloc>()),
        BlocProvider(create: (context) => getIt<ChecklistManagementBloc>()),
        BlocProvider(create: (context) => getIt<ItemCategoryBloc>()),
        BlocProvider(create: (context) => getIt<ItemCategoryManagementBloc>()),
        BlocProvider(create: (context) => getIt<ItemsBloc>()),
        BlocProvider(create: (context) => getIt<ItemsManagementBloc>()),
        BlocProvider(create: (context) => getIt<ItemActionBloc>()),
        BlocProvider(create: (context) => getIt<ItemActionManagementBloc>()),
        BlocProvider(create: (context) => getIt<DashboardItemActionBloc>()),
        BlocProvider(create: (context) => getIt<InstructionCategoryBloc>()),
        BlocProvider(
          create: (context) => getIt<InstructionCategoryManagementBloc>(),
        ),
        BlocProvider(create: (context) => getIt<InstructionBloc>()),
        BlocProvider(create: (context) => getIt<InstructionManagementBloc>()),
        BlocProvider(create: (context) => getIt<AssetCategoryBloc>()),
        BlocProvider(create: (context) => getIt<AssetCategoryManagementBloc>()),
        BlocProvider(create: (context) => getIt<AssetActionBloc>()),
        BlocProvider(create: (context) => getIt<AssetBloc>()),
        BlocProvider(create: (context) => getIt<AssetActionManagementBloc>()),
        BlocProvider(create: (context) => getIt<AssetManagementBloc>()),
        BlocProvider(create: (context) => getIt<AssetInternalNumberCubit>()),
        BlocProvider(create: (context) => getIt<DashboardAssetActionBloc>()),
        BlocProvider(create: (context) => getIt<WorkRequestBloc>()),
        BlocProvider(create: (context) => getIt<WorkRequestManagementBloc>()),
        BlocProvider(create: (context) => getIt<WorkRequestArchiveBloc>()),
        BlocProvider(create: (context) => getIt<TaskBloc>()),
        BlocProvider(create: (context) => getIt<TaskManagementBloc>()),
        BlocProvider(create: (context) => getIt<TaskActionBloc>()),
        BlocProvider(create: (context) => getIt<TaskActionManagementBloc>()),
        BlocProvider(create: (context) => getIt<TaskArchiveBloc>()),
        BlocProvider(create: (context) => getIt<TaskArchiveLatestBloc>()),
        BlocProvider(create: (context) => getIt<FilterBloc>()),
        BlocProvider(create: (context) => getIt<TaskFilterBloc>()),
        BlocProvider(create: (context) => getIt<ReservedSparePartsBloc>()),
        BlocProvider(create: (context) => getIt<AssetPartsBloc>()),
        BlocProvider(
          create: (context) => getIt<LanguageCubit>()..getInitLanguage(),
        ),
        BlocProvider(create: (context) => getIt<WorkRequestsStatusBloc>()),
        BlocProvider(create: (context) => getIt<TaskTemplatesBloc>()),
        BlocProvider(create: (context) => getIt<TaskTemplatesManagementBloc>()),
        BlocProvider(create: (context) => getIt<TaskActionsStatusBloc>()),
        BlocProvider(create: (context) => getIt<ActivityBloc>()),
        BlocProvider(create: (context) => getIt<DeviceTokenCubit>()),
        BlocProvider(create: (context) => getIt<NotificationSettingsCubit>()),
        BlocProvider(create: (context) => getIt<UcNotificationBloc>()),
        BlocProvider(
          create: (context) => getIt<UcNotificationManagementBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<TaskCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<TasksForAssetBloc>(),
        ),
      ],
      child: child,
    );
  }
}
