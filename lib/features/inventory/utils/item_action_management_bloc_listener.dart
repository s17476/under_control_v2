import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/item_action_management/item_action_management_bloc.dart';

void itemActionManagementBlocListener(
    BuildContext context, ItemActionManagementState state) {
  if (state is ItemActionManagementSuccessState ||
      state is ItemActionManagementErrorState) {
    String message = '';
    switch (state.message) {
      case ItemActionMessage.added:
        message = AppLocalizations.of(context)!.item_action_msg_added;
        break;
      case ItemActionMessage.notAdded:
        message = AppLocalizations.of(context)!.item_action_msg_not_added;
        break;
      case ItemActionMessage.updated:
        message = AppLocalizations.of(context)!.item_action_msg_updated;
        break;
      case ItemActionMessage.notUpdated:
        message = AppLocalizations.of(context)!.item_action_msg_not_updated;
        break;
      case ItemActionMessage.deleted:
        message = AppLocalizations.of(context)!.item_action_msg_deleted;
        break;
      case ItemActionMessage.notDeleted:
        message = AppLocalizations.of(context)!.item_action_msg_not_deleted;
        break;
      case ItemActionMessage.moved:
        message = AppLocalizations.of(context)!.item_action_msg_added;
        break;
      case ItemActionMessage.notMoved:
        message = AppLocalizations.of(context)!.item_action_msg_not_added;
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
