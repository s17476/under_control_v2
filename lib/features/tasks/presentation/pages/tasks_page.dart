import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart';

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

class _TasksPageState extends State<TasksPage>
    with ResponsiveSize, SingleTickerProviderStateMixin {
  int _index = 0;
  bool _hasWorkRequests = false;
  late TabController _tabController;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    final workRequestsState = context.watch<WorkRequestBloc>().state;
    if (workRequestsState is WorkRequestLoadedState) {
      _hasWorkRequests =
          workRequestsState.allWorkRequests.allWorkRequests.isNotEmpty;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_hasWorkRequests)
                      Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        child: TabBar(
                          tabs: [
                            Tab(
                              icon: Text(
                                AppLocalizations.of(context)!.work_requests,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color,
                                ),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                AppLocalizations.of(context)!
                                    .bottom_bar_title_tasks,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color,
                                ),
                              ),
                            ),
                          ],
                          controller: _tabController,
                          indicatorColor: tabBarIconColor,
                          onTap: _setIndex,
                        ),
                      ),
                    if (_hasWorkRequests && _index == 0)
                      const WorkRequestsTabView(),
                    if (!_hasWorkRequests || _index == 1) const TasksTabView(),
                  ],
                ),
        ),
      ],
    );
  }
}
