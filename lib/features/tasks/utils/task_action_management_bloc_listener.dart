import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/bloc_message.dart';
import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/task_action_management/task_action_management_bloc.dart';

void taskActionManagementBlocListener(
    BuildContext context, TaskActionManagementState state) {
  if (state is TaskActionManagementSuccessState ||
      state is TaskActionManagementErrorState) {
    String message = '';
    switch (state.message) {
      case BlocMessage.added:
        message = AppLocalizations.of(context)!.task_action_msg_added;
        break;
      case BlocMessage.notAdded:
        message = AppLocalizations.of(context)!.task_action_msg_not_added;
        break;
      case BlocMessage.updated:
        message = AppLocalizations.of(context)!.task_action_msg_updated;
        break;
      case BlocMessage.notUpdated:
        message = AppLocalizations.of(context)!.task_action_msg_not_updated;
        break;
      case BlocMessage.deleted:
        message = AppLocalizations.of(context)!.task_action_msg_deleted;
        break;
      case BlocMessage.notDeleted:
        message = AppLocalizations.of(context)!.task_action_msg_not_deleted;
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
