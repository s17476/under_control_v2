import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_type.dart';
import 'package:under_control_v2/features/tasks/utils/get_localized_task_type_name.dart';
import 'package:under_control_v2/features/tasks/utils/get_task_type_icon.dart';

import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddTaskTypeCard extends StatelessWidget with ResponsiveSize {
  const AddTaskTypeCard({
    Key? key,
    required this.setTaskType,
    required this.taskType,
    required this.isConnectedToAsset,
  }) : super(key: key);

  final Function(String) setTaskType;
  final String taskType;
  final bool isConnectedToAsset;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.task_type,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // maintenance
                        SelectionButton<String>(
                          onSelected: (val) {
                            setTaskType(val);
                          },
                          leading: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            width: 70,
                            height: 70,
                            child: getTaskTypeIcon(
                              context,
                              TaskType.maintenance,
                              50,
                            ),
                          ),
                          iconSize: 50,
                          title: getLocalizedTaskTypeName(
                            context,
                            TaskType.maintenance,
                          ),
                          titleSize: 24,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withAlpha(100),
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: TaskType.maintenance.name,
                          groupValue: taskType,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // reparation
                        SelectionButton<String>(
                          onSelected: (val) {
                            setTaskType(val);
                          },
                          leading: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            width: 70,
                            height: 70,
                            child: getTaskTypeIcon(
                              context,
                              TaskType.reparation,
                              50,
                            ),
                          ),
                          iconSize: 50,
                          title: getLocalizedTaskTypeName(
                            context,
                            TaskType.reparation,
                          ),
                          titleSize: 24,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withAlpha(100),
                              Theme.of(context).colorScheme.error,
                              Theme.of(context).colorScheme.error.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: TaskType.reparation.name,
                          groupValue: taskType,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // inspection
                        if (isConnectedToAsset) ...[
                          SelectionButton<String>(
                            onSelected: (val) {
                              setTaskType(val);
                            },
                            leading: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                              width: 70,
                              height: 70,
                              child: getTaskTypeIcon(
                                context,
                                TaskType.inspection,
                                50,
                              ),
                            ),
                            iconSize: 50,
                            title: getLocalizedTaskTypeName(
                              context,
                              TaskType.inspection,
                            ),
                            titleSize: 24,
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.withAlpha(80),
                                Colors.deepPurple,
                                Colors.deepPurple.withAlpha(100),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            value: TaskType.inspection.name,
                            groupValue: taskType,
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                        // event
                        SelectionButton<String>(
                          onSelected: (val) {
                            setTaskType(val);
                          },
                          leading: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            width: 70,
                            height: 70,
                            child: getTaskTypeIcon(
                              context,
                              TaskType.event,
                              50,
                            ),
                          ),
                          iconSize: 50,
                          title: getLocalizedTaskTypeName(
                            context,
                            TaskType.event,
                          ),
                          titleSize: 24,
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigo.withAlpha(80),
                              Colors.indigo,
                              Colors.indigo.withAlpha(100),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: TaskType.event.name,
                          groupValue: taskType,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
