import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../domain/entities/task_priority.dart';
import '../../../utils/get_task_priority_icon.dart';

class SetPriorityCard extends StatelessWidget with ResponsiveSize {
  const SetPriorityCard({
    Key? key,
    required this.setPriority,
    required this.priority,
  }) : super(key: key);

  final Function(String) setPriority;
  final String priority;

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
                    AppLocalizations.of(context)!.task_priority,
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
                        // low priority
                        SelectionButton<String>(
                          onSelected: (val) {
                            setPriority(val);
                          },
                          leading:
                              getTaskPriorityIcon(context, TaskPriority.low),
                          iconSize: 50,
                          title:
                              AppLocalizations.of(context)!.task_priority_low,
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
                          value: TaskPriority.low.name,
                          groupValue: priority,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // medium priority
                        SelectionButton<String>(
                          onSelected: (val) {
                            setPriority(val);
                          },
                          leading:
                              getTaskPriorityIcon(context, TaskPriority.medium),
                          iconSize: 50,
                          title: AppLocalizations.of(context)!
                              .task_priority_medium,
                          titleSize: 24,
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber.withAlpha(100),
                              Colors.amber,
                              Colors.amber.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: TaskPriority.medium.name,
                          groupValue: priority,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // high priority
                        SelectionButton<String>(
                          onSelected: (val) {
                            setPriority(val);
                          },
                          leading:
                              getTaskPriorityIcon(context, TaskPriority.high),
                          iconSize: 50,
                          title:
                              AppLocalizations.of(context)!.task_priority_high,
                          titleSize: 24,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).errorColor.withAlpha(100),
                              Theme.of(context).errorColor,
                              Theme.of(context).errorColor.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: TaskPriority.high.name,
                          groupValue: priority,
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
