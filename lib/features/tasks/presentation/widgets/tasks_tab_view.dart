import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/task/task.dart';
import 'task_tile.dart';

class TasksTabView extends StatelessWidget {
  const TasksTabView({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
