import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_archive_for_asset/tasks_archive_for_asset_bloc.dart';

import '../../../assets/domain/entities/asset.dart';
import '../../domain/entities/task/task.dart';
import 'task_tile.dart';

class TasksArchiveTabView extends StatelessWidget {
  const TasksArchiveTabView({
    Key? key,
    required this.tasks,
    required this.asset,
  }) : super(key: key);

  final List<Task> tasks;
  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.task_archive,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 18),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<TasksArchiveForAssetBloc>().add(
                        GetTasksArchiveForAssetEvent(
                          assetId: asset.id,
                          isAll: true,
                        ),
                      );
                  // Navigator.pushNamed(
                  //   context,
                  //   AllAssetsWithoutInspectionListPage.routeName,
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.show_all),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 4),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) => Padding(
              key: ValueKey(tasks[index].id),
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
                right: 8,
                left: 2,
              ),
              child: TaskTile(task: tasks[index]),
            ),
          ),
        ),
      ],
    );
  }
}
