import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../blocs/task_archive/task_archive_bloc.dart';
import '../widgets/task_tile.dart';

class TaskArchivePage extends StatelessWidget {
  const TaskArchivePage({Key? key}) : super(key: key);

  static const routeName = '/tasks/task-archive';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.task_archive),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskArchiveBloc, TaskArchiveState>(
        builder: (context, state) {
          if (state is TaskArchiveEmptyState) {
            context.read<TaskArchiveBloc>().add(
                  GetTasksArchiveStreamEvent(),
                );
          }
          if (state is TaskArchiveLoadedState) {
            if (state.allTasks.allTasks.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.item_no_items,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.allTasks.allTasks.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  right: 8,
                  left: 2,
                ),
                child: TaskTile(
                  task: state.allTasks.allTasks[index],
                ),
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
