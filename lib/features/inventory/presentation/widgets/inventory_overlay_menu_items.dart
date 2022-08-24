import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../checklists/presentation/pages/checklist_management_page.dart';
import '../../../core/utils/choice.dart';

List<Choice> inventoryOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
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
