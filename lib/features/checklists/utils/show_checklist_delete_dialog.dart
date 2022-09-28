import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/entities/checklist.dart';
import '../presentation/blocs/checklist_management/checklist_management_bloc.dart';

Future<bool?> showChecklistDeleteDialog({
  required BuildContext context,
  required Checklist checklist,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(AppLocalizations.of(context)!.confirm),
      content: Text(
        AppLocalizations.of(context)!
            .checklist_details_delete_question(checklist.title),
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.delete,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context.read<ChecklistManagementBloc>().add(
                  DeleteChecklistEvent(checklist: checklist),
                );
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}
