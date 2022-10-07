import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/bloc_message.dart';
import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/instruction_management/instruction_management_bloc.dart';

void instructionManagementBlocListener(
    BuildContext context, InstructionManagementState state) {
  if (state is InstructionManagementSuccessState ||
      state is InstructionManagementErrorState) {
    String message = '';
    switch (state.message) {
      case BlocMessage.updated:
        message = AppLocalizations.of(context)!.instruction_msg_updated;
        break;

      case BlocMessage.notUpdated:
        message = AppLocalizations.of(context)!.instruction_msg_not_updated;
        break;
      case BlocMessage.added:
        message = AppLocalizations.of(context)!.instruction_msg_added;
        break;
      case BlocMessage.notAdded:
        message = AppLocalizations.of(context)!.instruction_msg_not_added;
        break;
      case BlocMessage.deleted:
        message = AppLocalizations.of(context)!.instruction_msg_deleted;
        break;
      case BlocMessage.notDeleted:
        message = AppLocalizations.of(context)!.instruction_msg_not_deleted;
        break;
      default:
        message = '';
        break;
    }
    if (message.isNotEmpty) {
      showSnackBar(
        context: context,
        message: message,
        isErrorMessage: state.error,
      );
    }
  }
}
