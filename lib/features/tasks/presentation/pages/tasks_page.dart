import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../blocs/task_filter/task_filter_bloc.dart';
import '../widgets/show_all_tasks_button.dart';
import '../widgets/task_tile.dart';
import '../widgets/work_request_tile.dart';

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
    if (!permission) {
      return Column(
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
      );
    }
    return BlocBuilder<TaskFilterBloc, TaskFilterState>(
        builder: (context, state) {
      // loading tasks
      if (state is TaskFilterInitialState) {
        return ListView.separated(
          padding: const EdgeInsets.only(top: 4),
          separatorBuilder: (context, index) => const SizedBox(
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
        children: [
          AnimatedContainer(
            color: Theme.of(context).scaffoldBackgroundColor,
            duration: const Duration(milliseconds: 300),
            height: state.isFilterVisible ? state.filterHeight : 0,
          ),
          // work requests
          if (state.workRequests.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
              ),
              child: Text(
                AppLocalizations.of(context)!.work_requests,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 18),
              ),
            ),
            ...state.workRequests.map(
              (workRequest) => Padding(
                key: ValueKey(workRequest.id),
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  right: 8,
                  left: 2,
                ),
                child: WorkRequestTile(
                  workRequest: workRequest,
                ),
              ),
            ),
          ],
          if (state.workRequests.isNotEmpty && state.tasks.isNotEmpty)
            const Divider(
              thickness: 1.5,
            ),
          if (state.workRequests.isEmpty)
            const SizedBox(
              height: 8,
            ),

          if (state.tasks.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                AppLocalizations.of(context)!.bottom_bar_title_tasks,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 18),
              ),
            ),
            ...state.tasks.map(
              (task) => Padding(
                key: ValueKey(task.id),
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  right: 8,
                  left: 2,
                ),
                child: TaskTile(task: task),
              ),
            ),
          ],
          const ShowAllTasksButton(),
          const SizedBox(
            height: 40,
          ),
        ],
      );
    });
  }
}
