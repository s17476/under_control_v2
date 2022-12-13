import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';

import '../data/models/instruction_model.dart';
import '../domain/entities/instruction.dart';
import '../presentation/blocs/instruction_management/instruction_management_bloc.dart';

Future<bool?> showInstructionDeleteDialog({
  required BuildContext context,
  required Instruction instruction,
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
            AppLocalizations.of(context)!
                .location_management_add_location_message_delete_confirm,
          ),
          content: Text(
            AppLocalizations.of(context)!
                .location_management_add_location_message_delete_question(
              instruction.name,
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
                context.read<InstructionManagementBloc>().add(
                      DeleteInstructionEvent(
                        instruction:
                            InstructionModel.fromInstruction(instruction),
                      ),
                    );
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
