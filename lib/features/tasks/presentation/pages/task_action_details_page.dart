import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskActionDetailsPage extends StatelessWidget {
  const TaskActionDetailsPage({super.key});

  static const routeName = '/task-action/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.task_action_details),
      ),
    );
  }
}
