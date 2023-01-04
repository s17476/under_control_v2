import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/duration_apis.dart';
import '../../../domain/entities/task/task.dart';
import '../../blocs/task_action/task_action_bloc.dart';
import 'shimmer_task_action_tile.dart';
import 'task_action_tile.dart';
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
                return Column(
                  children: [
                    if (actions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${AppLocalizations.of(context)!.total_time}:',
                              ),
                            ),
                            Text(state.getTotalDuration.toFormatedString()),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: actions.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 6,
                          width: double.infinity,
                        ),
                        itemBuilder: (context, index) => TaskActionTile(
                          taskAction: actions[index],
                        ),
                      ),
                    ),
                  ],
                );
              }
              // loading widget
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                    width: double.infinity,
                  ),
                  itemBuilder: (context, index) =>
                      const ShimmerTaskActionTile(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
