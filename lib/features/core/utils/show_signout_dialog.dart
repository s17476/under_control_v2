import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';

import '../../authentication/presentation/blocs/authentication/authentication_bloc.dart';

Future<dynamic> showSignoutDialog({
  required BuildContext context,
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
            AppLocalizations.of(context)!.main_drawer_signout,
          ),
          content: Text(
            AppLocalizations.of(context)!.main_drawer_signout_question,
          ),
          actions: [
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: const TextStyle(
                  color: Colors.amber,
                ),
              ),
              onPressed: () {
                context.read<AuthenticationBloc>().add(SignoutEvent());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
