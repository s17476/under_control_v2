import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import 'activity_card.dart';
import 'assets_status.dart';
import 'tasks_status.dart';
import 'work_requests_status.dart';

List<Widget> getStatusCardWidgets(BuildContext context) {
  return [
    Container(
      key: const ValueKey('status-title'),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: IconTitleRow(
              icon: Icons.monitor_heart_outlined,
              iconColor: Colors.white,
              iconBackground: Theme.of(context).primaryColor,
              title: AppLocalizations.of(context)!.status_in_locations,
            ),
          ),
        ],
      ),
    ),
    const SizedBox(
      height: 8,
    ),
    const Padding(
      key: ValueKey('work-request-status'),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: WorkRequestsStatus(),
    ),
    const Padding(
      key: ValueKey('task-status'),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TasksStatus(),
    ),
    const Padding(
      key: ValueKey('asset-status'),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: AssetsStatus(),
    ),
    const Padding(
      key: ValueKey('activity-status'),
      padding: EdgeInsets.only(left: 8, right: 8),
      child: ActivityCard(),
    ),
    const SizedBox(
      height: 8,
    ),
  ];
}
