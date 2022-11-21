import 'package:flutter/material.dart';

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
    return AnimatedSize(
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
    );
  }
}
