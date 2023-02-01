import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../domain/entities/task/task.dart';

class AddTaskActionChecklistCard extends StatelessWidget with ResponsiveSize {
  const AddTaskActionChecklistCard({
    Key? key,
    required this.task,
    required this.checklist,
    required this.toggleCheckpoint,
  }) : super(key: key);

  final Task task;
  final List<CheckpointModel> checklist;
  final Function(CheckpointModel) toggleCheckpoint;

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
                    AppLocalizations.of(context)!.checklist,
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
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: task.checklist.length,
                    itemBuilder: (context, index) {
                      final isChecked = checklist
                          .map((e) => e.title)
                          .contains(task.checklist[index].title);
                      return IgnorePointer(
                        ignoring: task.checklist[index].isChecked,
                        child: Container(
                          color: (index % 2 == 0) ? null : Colors.black26,
                          child: InkWell(
                            onTap: () => toggleCheckpoint(
                              task.checklist[index],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: IconTitleRow(
                                        icon:
                                            Icons.check_circle_outline_outlined,
                                        iconColor: Colors.grey.shade200,
                                        iconBackground: task
                                                .checklist[index].isChecked
                                            ? Colors.grey
                                            : Theme.of(context).primaryColor,
                                        title: task.checklist[index].title,
                                        titleColor:
                                            task.checklist[index].isChecked
                                                ? Colors.grey
                                                : null,
                                      ),
                                    ),
                                    IgnorePointer(
                                      child: Checkbox(
                                        value:
                                            task.checklist[index].isChecked ||
                                                isChecked,
                                        onChanged: (_) => toggleCheckpoint(
                                          task.checklist[index],
                                        ),
                                        activeColor: task
                                                .checklist[index].isChecked
                                            ? Colors.grey
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
