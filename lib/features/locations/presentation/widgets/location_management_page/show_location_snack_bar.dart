import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/bloc/location_bloc.dart';

void showLocationSnackBar({
  required BuildContext context,
  required LocationState state,
}) {
  String message = '';
  bool error = false;
  if (state is LocationLoadedState) {
    switch (state.message) {
      case locationAddedMessage:
        message = AppLocalizations.of(context)!
            .location_management_add_location_message_added;
        break;
      case deleteFailed:
        message = AppLocalizations.of(context)!
            .location_management_add_location_message_delete_failed;
        error = true;
        break;
      case deleteSuccess:
        message = AppLocalizations.of(context)!
            .location_management_add_location_message_delete_success;
        break;
      case updateSuccess:
        message = AppLocalizations.of(context)!
            .location_management_add_location_message_update_success;
        break;
      default:
        message = '';
    }
  } else if (state is LocationErrorState) {
    message = 'Failed!';
    error = true;
  }
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: error
              ? Theme.of(context).errorColor
              : Theme.of(context).primaryColor,
        ),
      );
  }
}
