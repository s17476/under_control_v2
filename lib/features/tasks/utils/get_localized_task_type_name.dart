import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/entities/task_type.dart';

String getLocalizedTaskTypeName(
  BuildContext context,
  TaskType type,
) {
  switch (type) {
    case TaskType.maintenance:
      return AppLocalizations.of(context)!.task_type_maintenance;
    case TaskType.reparation:
      return AppLocalizations.of(context)!.task_type_reparation;
    case TaskType.inspection:
      return AppLocalizations.of(context)!.task_type_inspection;
    case TaskType.event:
      return AppLocalizations.of(context)!.task_type_event;
    default:
      return '';
  }
}
