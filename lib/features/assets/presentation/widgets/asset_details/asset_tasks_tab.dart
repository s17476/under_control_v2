import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/rounded_button.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_for_asset/tasks_for_asset_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/pages/add_task_page.dart';
import 'package:under_control_v2/features/tasks/presentation/pages/add_work_request_page.dart';

import '../../../../tasks/presentation/blocs/task/task_bloc.dart';
import '../../../../tasks/presentation/blocs/work_request/work_request_bloc.dart';
import '../../../../tasks/presentation/widgets/tasks_tab_view.dart';
import '../../../../tasks/presentation/widgets/work_requests_tab_view.dart';
import '../../../domain/entities/asset.dart';
import 'shimmer_asset_action_list_tile.dart';

class AssetTasksTab extends StatelessWidget {
  const AssetTasksTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // add work request
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 8,
            right: 8,
            bottom: 4,
          ),
          child: RoundedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AddWorkRequestPage.routeName,
              arguments: asset,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            axis: Axis.horizontal,
            icon: Icons.add,
            iconSize: 30,
            title: AppLocalizations.of(context)!.work_request_add,
            titleSize: 18,
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade700.withAlpha(70),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // add task
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: RoundedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AddTaskPage.routeName,
              arguments: asset,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            axis: Axis.horizontal,
            icon: Icons.add_task,
            iconSize: 30,
            title: AppLocalizations.of(context)!.task_add,
            titleSize: 18,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        BlocBuilder<WorkRequestBloc, WorkRequestState>(
          builder: (context, state) {
            if (state is WorkRequestLoadedState) {
              final requestsForAsset = state.allWorkRequests.allWorkRequests
                  .where((request) => request.assetId == asset.id)
                  .toList();
              if (requestsForAsset.isNotEmpty) {
                return WorkRequestsTabView(
                  workRequests: requestsForAsset,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.asset_no_work_requests,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                );
              }
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) =>
                  const ShimmerAssetActionListTile(),
            );
          },
        ),
        // TODO - create bloc to get assets tasks
        BlocBuilder<TasksForAssetBloc, TasksForAssetState>(
          builder: (context, state) {
            if (state is TasksForAssetLoaded && state.assetId == asset.id) {
              final tasksForAsset = state.tasks.allTasks;

              if (tasksForAsset.isNotEmpty) {
                return TasksTabView(
                  tasks: tasksForAsset,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.asset_no_tasks,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                );
              }
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) =>
                  const ShimmerAssetActionListTile(),
            );
          },
        ),
      ],
    );
  }
}
