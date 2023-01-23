import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import 'assets_status.dart';
import 'tasks_status.dart';
import 'work_requests_status.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
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
                  icon: Icons.health_and_safety,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.status_in_locations,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              WorkRequestsStatus(),
              SizedBox(
                height: 8,
              ),
              TasksStatus(),
              SizedBox(
                height: 8,
              ),
              AssetsStatus(),
            ],
          ),
        ),
      ],
    );
  }
}
