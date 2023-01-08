import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../blocs/task_filter/task_filter_bloc.dart';
import '../widgets/tasks_tab_view.dart';
import '../widgets/work_requests_tab_view.dart';

class TasksPage extends StatelessWidget with ResponsiveSize {
  const TasksPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.tasks,
      permissionType: PermissionType.read,
    );
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: !permission
              ? Column(
                  children: [
                    SizedBox(
                      height: responsiveSizeVerticalPct(small: 40),
                    ),
                    SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.permission_no_permission,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    BlocBuilder<TaskFilterBloc, TaskFilterState>(
                      builder: (context, state) {
                        if (state is TaskFilterNothingSelectedState ||
                            state is TaskFilterSelectedState) {
                          return AnimatedContainer(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            duration: const Duration(milliseconds: 300),
                            height:
                                state.isFilterVisible ? state.filterHeight : 0,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    BlocBuilder<TaskFilterBloc, TaskFilterState>(
                      builder: (context, state) {
                        if (state is TaskFilterInitialState) {
                          return ListView.separated(
                            padding: const EdgeInsets.only(top: 4),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 4,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            itemBuilder: (context, index) =>
                                // shimmer work order
                                const ShimmerAssetActionListTile(),
                          );
                        }
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            if (state.workRequests.isNotEmpty)
                              WorkRequestsTabView(
                                workRequests: state.workRequests,
                              ),
                            if (state.workRequests.isNotEmpty &&
                                state.tasks.isNotEmpty)
                              const Divider(
                                thickness: 1.5,
                              ),
                            if (state.tasks.isNotEmpty)
                              TasksTabView(
                                tasks: state.tasks,
                              ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
