import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/choice.dart';
import '../../../tasks/presentation/pages/add_work_request_page.dart';

List<Choice> dashboardOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    Choice(
      title: AppLocalizations.of(context)!.work_request_add,
      icon: Icons.add,
      onTap: () {
        Navigator.pushNamed(
          context,
          AddWorkRequestPage.routeName,
        );
      },
    ),
  ];
  return choices;
}
