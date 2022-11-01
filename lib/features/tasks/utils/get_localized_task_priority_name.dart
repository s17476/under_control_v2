import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';

String getLocalizedTaskPriorityName(
  BuildContext context,
  TaskPriority priority,
) {
  switch (priority) {
    case TaskPriority.low:
      return AppLocalizations.of(context)!.task_priority_low;
    case TaskPriority.medium:
      return AppLocalizations.of(context)!.task_priority_medium;
    case TaskPriority.high:
      return AppLocalizations.of(context)!.task_priority_high;
    default:
      return '';
  }
}
