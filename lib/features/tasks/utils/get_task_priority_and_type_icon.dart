import 'package:flutter/material.dart';

import '../domain/entities/task_priority.dart';
import '../domain/entities/task_type.dart';
import 'get_task_type_icon.dart';

Widget getTaskPriorityAndTypeIcon({
  required BuildContext context,
  required TaskPriority priority,
  required TaskType type,
  double iconSize = 26,
  double backgroundSize = 70,
  bool shadow = false,
}) {
  String assetPath = '';
  switch (priority) {
    case TaskPriority.low:
      assetPath =
          shadow ? 'assets/status_ok_shadow.png' : 'assets/status_ok.png';
      break;
    case TaskPriority.medium:
      assetPath = shadow
          ? 'assets/status_working_shadow.png'
          : 'assets/status_working.png';
      break;
    case TaskPriority.high:
      assetPath = shadow
          ? 'assets/status_not_working_shadow.png'
          : 'assets/status_not_working.png';
      break;
    default:
      assetPath = shadow
          ? 'assets/status_disposed_shadow.png'
          : 'assets/status_disposed.png';
      break;
  }
  return SizedBox(
    width: backgroundSize,
    height: backgroundSize,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(assetPath),
        getTaskTypeIcon(
          context,
          type,
          iconSize,
          false,
          Colors.black,
        ),
      ],
    ),
  );
}
