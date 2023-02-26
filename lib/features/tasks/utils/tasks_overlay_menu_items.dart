import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../checklists/presentation/pages/checklist_management_page.dart';
import '../../core/utils/choice.dart';
import '../presentation/blocs/task_templates/task_templates_bloc.dart';
import '../presentation/pages/add_task_page.dart';
import '../presentation/pages/add_work_request_page.dart';
import '../presentation/pages/task_archive_page.dart';
import '../presentation/pages/templates_management_page.dart';
import '../presentation/pages/work_request_archive_page.dart';

List<Choice> tasksOverlayMenuItems(BuildContext context) {
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
    Choice(
      title: AppLocalizations.of(context)!.task_add,
      icon: Icons.add_task,
      onTap: () {
        Navigator.pushNamed(
          context,
          AddTaskPage.routeName,
        );
      },
    ),
    Choice(
      title: AppLocalizations.of(context)!.work_request_archive,
      icon: Icons.history,
      onTap: () {
        Navigator.pushNamed(
          context,
          WorkRequestArchivePage.routeName,
        );
      },
    ),
    Choice(
      title: AppLocalizations.of(context)!.task_archive,
      icon: Icons.history,
      onTap: () {
        Navigator.pushNamed(
          context,
          TaskArchivePage.routeName,
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
    Choice(
      title: AppLocalizations.of(context)!.task_templates,
      icon: Icons.task_outlined,
      onTap: () {
        context.read<TaskTemplatesBloc>().add(GetTaskTemplatesEvent());
        Navigator.pushNamed(
          context,
          TemplatesManagementPage.routeName,
        );
      },
    ),
  ];
  return choices;
}

List<SpeedDialChild> tasksOverlayMenuSpeedDialItems(BuildContext context) {
  final List<SpeedDialChild> choices = [
    SpeedDialChild(
      label: AppLocalizations.of(context)!.checklist_drawer_title,
      child: const Icon(Icons.checklist_rounded),
      onTap: () {
        Navigator.pushNamed(
          context,
          ChecklistManagementPage.routeName,
        );
      },
      shape: const StadiumBorder(),
    ),
    SpeedDialChild(
      label: AppLocalizations.of(context)!.task_templates,
      child: const Icon(Icons.task_outlined),
      onTap: () {
        context.read<TaskTemplatesBloc>().add(GetTaskTemplatesEvent());
        Navigator.pushNamed(
          context,
          TemplatesManagementPage.routeName,
        );
      },
      shape: const StadiumBorder(),
    ),
    SpeedDialChild(
      label: AppLocalizations.of(context)!.work_request_archive,
      child: const Icon(Icons.history),
      onTap: () {
        Navigator.pushNamed(
          context,
          WorkRequestArchivePage.routeName,
        );
      },
      shape: const StadiumBorder(),
      backgroundColor: Colors.red.shade900,
    ),
    SpeedDialChild(
      label: AppLocalizations.of(context)!.task_archive,
      child: const Icon(Icons.history),
      onTap: () {
        Navigator.pushNamed(
          context,
          TaskArchivePage.routeName,
        );
      },
      shape: const StadiumBorder(),
      backgroundColor: Colors.red.shade900,
    ),
    SpeedDialChild(
      label: AppLocalizations.of(context)!.task_add,
      child: const Icon(Icons.add_task),
      onTap: () {
        Navigator.pushNamed(
          context,
          AddTaskPage.routeName,
        );
      },
      shape: const StadiumBorder(),
      backgroundColor: Colors.red,
    ),
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
