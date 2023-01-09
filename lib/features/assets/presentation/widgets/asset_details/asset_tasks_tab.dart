import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    style: Theme.of(context).textTheme.caption!.copyWith(
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
        BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadedState) {
              final tasksForAsset = state.allTasks.allTasks
                  .where((task) => task.assetId == asset.id)
                  .toList();
              if (tasksForAsset.isNotEmpty) {
                return TasksTabView(
                  tasks: tasksForAsset,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.asset_no_tasks,
                    style: Theme.of(context).textTheme.caption!.copyWith(
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
