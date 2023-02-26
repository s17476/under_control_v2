import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

List<SpeedDialChild> dashboardOverlayMenuSpeedDialItems(BuildContext context) {
  final List<SpeedDialChild> choices = [
    SpeedDialChild(
      label: AppLocalizations.of(context)!.work_request_add,
      child: const Icon(Icons.add),
      onTap: () {
        Navigator.pushNamed(
          context,
          AddWorkRequestPage.routeName,
        );
      },
      shape: const StadiumBorder(),
      backgroundColor: Colors.red,
    ),
  ];
  return choices;
}
