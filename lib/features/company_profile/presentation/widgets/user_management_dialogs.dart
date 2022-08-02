import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

import '../../../user_profile/presentation/blocs/user_management/user_management_bloc.dart';

Future<bool?> showUserApproveDialog({
  required BuildContext context,
  required UserProfile user,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(AppLocalizations.of(context)!.user_new_user_confirm_approved),
      content: Text(
        AppLocalizations.of(context)!
            .user_new_user_approve_question(user.firstName),
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
            AppLocalizations.of(context)!.approve,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context
                .read<UserManagementBloc>()
                .add(ApproveUserEvent(userId: user.id));
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}

Future<bool?> showUserRejectDialog({
  required BuildContext context,
  required UserProfile user,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(AppLocalizations.of(context)!.user_new_user_confirm_rejected),
      content: Text(
        AppLocalizations.of(context)!
            .user_new_user_rejected_question(user.firstName),
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
            AppLocalizations.of(context)!.reject,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context
                .read<UserManagementBloc>()
                .add(RejectUserEvent(userId: user.id));
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}
