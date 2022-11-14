import 'package:flutter/material.dart';

import '../domain/entities/task_type.dart';

Widget getTaskTypeIcon(
  BuildContext context,
  TaskType type, [
  double iconSize = 36,
  bool shadow = true,
  Color? color,
]) {
  IconData iconData;
  switch (type) {
    case TaskType.maintenance:
      iconData = Icons.settings_suggest;
      break;
    case TaskType.reparation:
      iconData = Icons.build;
      break;
    case TaskType.inspection:
      iconData = Icons.search;
      break;
    case TaskType.event:
      iconData = Icons.today;
      break;
    default:
      iconData = Icons.question_mark;
      break;
  }
  return Icon(
    iconData,
    size: iconSize,
    color: color,
    shadows: shadow
        ? [
            const Shadow(
              color: Colors.black,
              blurRadius: 25,
            ),
          ]
        : null,
  );
}
