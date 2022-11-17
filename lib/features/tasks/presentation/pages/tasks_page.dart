import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../widgets/tasks_tab_view.dart';
import '../widgets/work_requests_tab_view.dart';

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
