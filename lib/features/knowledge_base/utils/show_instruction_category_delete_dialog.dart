import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/entities/instruction_category/instruction_category.dart';
import '../presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart';

Future<dynamic> showInstructionCategoryDeleteDialog({
  required BuildContext context,
  required InstructionCategory instructionCategory,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        AppLocalizations.of(context)!
            .location_management_add_location_message_delete_confirm,
      ),
      content: Text(
        AppLocalizations.of(context)!
            .location_management_add_location_message_delete_question(
          instructionCategory.name,
        ),
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
            Navigator.pop(context);
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
            context.read<InstructionCategoryManagementBloc>().add(
                  DeleteInstructionCategoryEvent(
                    instructionCategory: instructionCategory,
                  ),
                );
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
