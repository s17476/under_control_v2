import 'package:flutter/material.dart';

import '../../../domain/entities/task/task.dart';
import 'task_actions_buttons.dart';

class TaskActionsTab extends StatelessWidget {
  const TaskActionsTab({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TaskActionsButtons(task: task),
        ),
      ],
    );
  }
}
