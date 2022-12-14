import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/presentation/widgets/glass_layer.dart';
import '../domain/entities/item.dart';

Future<bool?> showSparePartItemDeleteDialog({
  required BuildContext context,
  required Item item,
  required Function() onDelete,
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
            AppLocalizations.of(context)!.group_management_delete_confirm,
          ),
          content: Text(
            AppLocalizations.of(context)!
                .item_delete_spare_part_question(item.name),
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
                onDelete();
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
