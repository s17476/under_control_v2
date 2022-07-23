import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              for (var i in Iterable<int>.generate(100).toList())
                Text(
                  AppLocalizations.of(context)!.bottom_bar_title_tasks +
                      i.toString(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
