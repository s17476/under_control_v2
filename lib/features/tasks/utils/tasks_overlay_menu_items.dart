import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../checklists/presentation/pages/checklist_management_page.dart';
import '../../core/utils/choice.dart';
import '../presentation/pages/add_work_order_page.dart';
import '../presentation/pages/work_order_archive_page.dart';

List<Choice> tasksOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    Choice(
      title: AppLocalizations.of(context)!.work_order_add,
      icon: Icons.add,
      onTap: () {
        Navigator.pushNamed(
          context,
          AddWorkOrderPage.routeName,
        );
      },
    ),
    Choice(
      title: AppLocalizations.of(context)!.work_order_archive,
      icon: Icons.history,
      onTap: () {
        Navigator.pushNamed(
          context,
          WorkOrderArchivePage.routeName,
        );
      },
    ),
    Choice(
      title: AppLocalizations.of(context)!.checklist_drawer_title,
      icon: Icons.checklist_rounded,
      onTap: () {
        Navigator.pushNamed(
          context,
          ChecklistManagementPage.routeName,
        );
      },
    ),
  ];
  return choices;
}
