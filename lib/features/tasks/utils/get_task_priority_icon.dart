import 'package:flutter/material.dart';
import '../domain/entities/task_priority.dart';

Widget getTaskPriorityIcon(
  BuildContext context,
  TaskPriority priority, [
  double iconSize = 70,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 12,
  ),
]) {
  String assetPath = '';
  switch (priority) {
    case TaskPriority.low:
      assetPath = 'assets/priority_low_shadow.png';
      break;
    case TaskPriority.medium:
      assetPath = 'assets/priority_medium_shadow.png';
      break;
    case TaskPriority.high:
      assetPath = 'assets/priority_high_shadow.png';
      break;
    default:
      assetPath = 'assets/status_disposed.png';
      break;
  }
  return Container(
    padding: padding,
    child: SizedBox(
      height: iconSize,
      width: iconSize,
      child: Image.asset(assetPath),
    ),
  );
}
