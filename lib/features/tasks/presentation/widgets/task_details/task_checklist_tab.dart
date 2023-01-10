import 'package:flutter/material.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';

class TaskChecklistTab extends StatelessWidget {
  const TaskChecklistTab({
    Key? key,
    required this.checklist,
  }) : super(key: key);

  final List<CheckpointModel> checklist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: checklist.length,
      itemBuilder: (context, index) {
        return Container(
          color: (index % 2 == 0) ? null : Colors.black26,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: IconTitleRow(
                    icon: Icons.check_circle_outline_outlined,
                    iconColor: Colors.grey.shade200,
                    iconBackground: Theme.of(context).primaryColor,
                    title: checklist[index].title,
                  ),
                ),
                Icon(
                  checklist[index].isChecked
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
