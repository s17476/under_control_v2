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
  bool shadow = true,
]) {
  String assetPath = '';
  switch (priority) {
    case TaskPriority.low:
      assetPath =
          shadow ? 'assets/priority_low_shadow.png' : 'assets/priority_low.png';
      break;
    case TaskPriority.medium:
      assetPath = shadow
          ? 'assets/priority_medium_shadow.png'
          : 'assets/priority_medium.png';
      break;
    case TaskPriority.high:
      assetPath = shadow
          ? 'assets/priority_high_shadow.png'
          : 'assets/priority_high.png';
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
