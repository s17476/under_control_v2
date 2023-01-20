import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/dashboard/presentation/widgets/tasks_status.dart';
import 'work_requests_status.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.status_in_locations,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                AppLocalizations.of(context)!.status_recent,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const WorkRequestsStatus(),
          const SizedBox(
            height: 8,
          ),
          const TasksStatus(),
        ],
      ),
    );
  }
}
