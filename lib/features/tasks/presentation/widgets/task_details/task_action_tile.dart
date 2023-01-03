import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/task_action/task_action.dart';

class TaskActionTile extends StatelessWidget {
  const TaskActionTile({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskAction taskAction;

  @override
  Widget build(BuildContext context) {
    final dateTimeFormat = DateFormat('dd-MM-yyyy HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm');
    final isSameDate = dateFormat.format(taskAction.startTime) ==
        dateFormat.format(taskAction.stopTime);
    final captionStyle = Theme.of(context).textTheme.caption;
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (isSameDate)
                  SameDateRow(
                    dateFormat: dateFormat,
                    taskAction: taskAction,
                    captionStyle: captionStyle!,
                    timeFormat: timeFormat,
                  ),
                if (!isSameDate)
                  DifferentDateRow(
                    dateTimeFormat: dateTimeFormat,
                    taskAction: taskAction,
                    captionStyle: captionStyle!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SameDateRow extends StatelessWidget {
  const SameDateRow({
    Key? key,
    required this.dateFormat,
    required this.taskAction,
    required this.captionStyle,
    required this.timeFormat,
  }) : super(key: key);

  final DateFormat dateFormat;
  final TaskAction taskAction;
  final TextStyle captionStyle;
  final DateFormat timeFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          dateFormat.format(taskAction.startTime),
          style: captionStyle,
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.play_arrow,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          timeFormat.format(taskAction.startTime),
          style: captionStyle,
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.stop,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          timeFormat.format(taskAction.stopTime),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class DifferentDateRow extends StatelessWidget {
  const DifferentDateRow({
    Key? key,
    required this.dateTimeFormat,
    required this.taskAction,
    required this.captionStyle,
  }) : super(key: key);

  final DateFormat dateTimeFormat;
  final TaskAction taskAction;
  final TextStyle captionStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.play_arrow,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          dateTimeFormat.format(taskAction.startTime),
          style: captionStyle,
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.stop,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          dateTimeFormat.format(taskAction.stopTime),
          style: captionStyle,
        ),
      ],
    );
  }
}
