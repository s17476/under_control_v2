import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/task/task.dart';
import '../../blocs/task_action/task_action_bloc.dart';
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
        Expanded(
          child: BlocBuilder<TaskActionBloc, TaskActionState>(
            builder: (context, state) {
              if (state is TaskActionLoadedState) {
                final actions = state.allActions.allTaskActions;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: actions.length,
                  itemBuilder: (context, index) => Text(actions[index].comment),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
