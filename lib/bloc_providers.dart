import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/checklists/presentation/blocs/Checklist/checklist_bloc.dart';
import 'features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart';
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart';
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'features/company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import 'features/company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart';
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
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'injection.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({
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
        BlocProvider(
          create: (context) => getIt<CompanyProfileBloc>(),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<CompanyManagementBloc>()),
        BlocProvider(
          create: (context) => getIt<LocationBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<GroupBloc>(),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<NewUsersBloc>()),
        BlocProvider(create: (context) => getIt<SuspendedUsersBloc>()),
        BlocProvider(
          create: (context) => getIt<FilterBloc>(),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<ChecklistBloc>()),
        BlocProvider(
          create: (context) => getIt<ChecklistManagementBloc>(),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<ItemCategoryBloc>()),
        BlocProvider(
          create: (context) => getIt<ItemCategoryManagementBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<ItemsBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<ItemsManagementBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<ItemActionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ItemActionManagementBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<DashboardItemActionBloc>(),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<InstructionCategoryBloc>()),
        BlocProvider(
          create: (context) => getIt<InstructionCategoryManagementBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<InstructionBloc>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => getIt<InstructionManagementBloc>(),
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
