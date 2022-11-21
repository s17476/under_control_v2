import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/bloc_message.dart';
import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/task_management/task_management_bloc.dart';

void taskManagementBlocListener(
    BuildContext context, TaskManagementState state) {
  if (state is TaskManagementSuccessState ||
      state is TaskManagementErrorState) {
    String message = '';
    switch (state.message) {
      case BlocMessage.updated:
        message = AppLocalizations.of(context)!.task_msg_updated;
        break;

      case BlocMessage.notUpdated:
        message = AppLocalizations.of(context)!.task_msg_not_updated;
        break;
      case BlocMessage.added:
        message = AppLocalizations.of(context)!.task_msg_added;
        break;
      case BlocMessage.notAdded:
        message = AppLocalizations.of(context)!.task_msg_not_added;
        break;
      case BlocMessage.deleted:
        message = AppLocalizations.of(context)!.task_msg_deleted;
        break;
      case BlocMessage.notDeleted:
        message = AppLocalizations.of(context)!.task_msg_not_deleted;
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
