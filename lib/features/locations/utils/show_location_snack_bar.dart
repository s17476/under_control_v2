import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../presentation/blocs/bloc/location_bloc.dart';

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
      case 'assets':
        message = AppLocalizations.of(context)!.location_delete_assets;
        error = true;
        break;
      case 'tasks':
        message = AppLocalizations.of(context)!.location_delete_tasks;
        error = true;
        break;
      case 'items':
        message = AppLocalizations.of(context)!.location_delete_items;
        error = true;
        break;
      default:
        message = '';
    }
  } else if (state is LocationErrorState) {
    message = 'Failed!';
    error = true;
  }
  if (message.isNotEmpty) {
    showSnackBar(
      context: context,
      message: message,
      isErrorMessage: error,
    );
  }
}
