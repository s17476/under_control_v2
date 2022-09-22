import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/items_management/items_management_bloc.dart';

void itemManagementBlocListener(
    BuildContext context, ItemsManagementState state) {
  if (state is ItemsManagementSuccessState ||
      state is ItemsManagementErrorState) {
    String message = '';
    switch (state.message) {
      case ItemsMessage.itemUpdated:
        message = AppLocalizations.of(context)!.item_msg_updated;
        break;

      case ItemsMessage.itemNotUpdated:
        message = AppLocalizations.of(context)!.item_msg_not_updated;
        break;
      case ItemsMessage.itemAdded:
        message = AppLocalizations.of(context)!.item_msg_added;
        break;
      case ItemsMessage.itemNotAdded:
        message = AppLocalizations.of(context)!.item_msg_not_added;
        break;
      case ItemsMessage.itemDeleted:
        message = AppLocalizations.of(context)!.item_msg_deleted;
        break;
      case ItemsMessage.itemNotDeleted:
        message = AppLocalizations.of(context)!.item_msg_not_deleted;
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
