import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/work_requests_tab_view.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/work_request_tile.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/tasks_tab_view.dart';
import 'package:under_control_v2/features/tasks/utils/get_task_priority_icon.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../blocs/work_request/work_request_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with ResponsiveSize {
  @override
  Widget build(BuildContext context) {
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.tasks,
      premissionType: PremissionType.read,
    );
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: !premission
              ? Column(
                  children: [
                    SizedBox(
                      height: responsiveSizeVerticalPct(small: 40),
                    ),
                    SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.premission_no_premission,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: const [
                    WorkRequestsTabView(),
                    SizedBox(
                      height: 8,
                    ),
                    TasksTabView(),
                  ],
                ),
        ),
      ],
    );
  }
}
