import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../error/error_messages.dart';

void showValidationSnackBar(UserProfileState state, BuildContext context) {
  if (state.message.isNotEmpty) {
    final String errorMessage;
    final localization = AppLocalizations.of(context)!;

    switch (state.message) {
      case inputToShort:
        errorMessage = localization.input_validation_to_short;
        break;
      case inputFormatInvalid:
        errorMessage = localization.input_validation_name_invalid_format;
        break;
      case phoneNumberFormatInvalid:
        errorMessage = localization.input_validation_phone_number;
        break;
      case fileIsNull:
        errorMessage = localization.input_validation_no_avatar;
        break;
      default:
        {
          errorMessage = state.message;
        }
    }

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: state.error
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).snackBarTheme.backgroundColor,
        ),
      );
  }
}
