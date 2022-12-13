import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';

import '../domain/entities/item.dart';
import '../presentation/blocs/items_management/items_management_bloc.dart';

Future<bool?> showItemDeleteDialog({
  required BuildContext context,
  required Item item,
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
            AppLocalizations.of(context)!.item_delete_question(item.name),
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
                context
                    .read<ItemsManagementBloc>()
                    .add(DeleteItemEvent(item: item));
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
