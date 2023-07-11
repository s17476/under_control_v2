import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../tasks/presentation/blocs/tasks_archive_for_asset/tasks_archive_for_asset_bloc.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';

class TaskArchiveForAssetPage extends StatelessWidget {
  const TaskArchiveForAssetPage({Key? key}) : super(key: key);

  static const routeName = '/tasks/task-archive-for-asset';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.task_archive),
        centerTitle: true,
      ),
      body: BlocBuilder<TasksArchiveForAssetBloc, TasksArchiveForAssetState>(
        builder: (context, state) {
          if (state is TasksArchiveForAssetLoaded) {
            final tasks = state.tasks.allTasks
              ..sort((a, b) => b.executionDate.compareTo(a.executionDate));
            return Scrollbar(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        right: 8,
                        left: 2,
                      ),
                      child: TaskTile(
                        task: task,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // shows shimmer when loading
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
        },
      ),
    );
  }
}
