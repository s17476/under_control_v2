import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/presentation/widgets/glass_layer.dart';
import '../../core/presentation/widgets/rounded_button.dart';
import '../data/models/task/task_model.dart';
import '../domain/entities/task/task.dart';
import '../domain/entities/task_priority.dart';
import '../presentation/blocs/task_management/task_management_bloc.dart';
import 'get_task_priority_icon.dart';

Future<dynamic> showTaskCompleteDialog({
  required BuildContext context,
  required Task task,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => Material(
      color: Colors.transparent,
      child: GlassLayer(
        onDismiss: () => Navigator.pop(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              alignment: Alignment.topCenter,
              insetPadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 24,
                right: 24,
                bottom: 24,
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Text(
                    AppLocalizations.of(context)!.task_complete_question,
                  ),
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    // success
                    RoundedButton(
                      axis: Axis.horizontal,
                      onPressed: () {
                        final updatedTask = TaskModel.fromTask(task)
                            .copyWith(isSuccessful: true);
                        context.read<TaskManagementBloc>().add(
                              CompleteTaskEvent(task: updatedTask),
                            );
                        Navigator.pop(context, true);
                      },
                      icon: Icons.done_rounded,
                      iconSize: 40,
                      title:
                          AppLocalizations.of(context)!.task_complete_success,
                      titleSize: 20,
                      foregroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withAlpha(60),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // failed
                    RoundedButton(
                      axis: Axis.horizontal,
                      onPressed: () {
                        final updatedTask = TaskModel.fromTask(task)
                            .copyWith(isSuccessful: false);
                        context.read<TaskManagementBloc>().add(
                              CompleteTaskEvent(task: updatedTask),
                            );
                        Navigator.pop(context, true);
                      },
                      icon: Icons.clear_rounded,
                      iconSize: 40,
                      title: AppLocalizations.of(context)!.task_complete_fail,
                      titleSize: 20,
                      foregroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.error.withAlpha(200),
                          Theme.of(context).colorScheme.error.withAlpha(100),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                // cancel
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.2) - 100,
              child: getTaskPriorityIcon(
                context,
                TaskPriority.low,
                200,
                EdgeInsets.zero,
                true,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
