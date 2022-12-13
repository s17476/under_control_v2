import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';

import '../domain/entities/group.dart';
import '../presentation/blocs/group/group_bloc.dart';

Future<bool?> showGroupDeleteDialog({
  required BuildContext context,
  required Group group,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => Material(
      color: Colors.transparent,
      child: GlassLayer(
        onDismiss: () => Navigator.pop(context),
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
              AppLocalizations.of(context)!.group_management_delete_confirm),
          content: Text(
            AppLocalizations.of(context)!
                .group_management_delete_question(group.name),
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
                context.read<GroupBloc>().add(DeleteGroupEvent(group: group));
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
