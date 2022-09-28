import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../user_profile/domain/entities/user_profile.dart';
import '../../user_profile/presentation/blocs/user_management/user_management_bloc.dart';

Future<bool?> showUserApproveDialog({
  required BuildContext context,
  required UserProfile user,
  required bool isActive,
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
            isActive
                ? AppLocalizations.of(context)!.approve
                : AppLocalizations.of(context)!.approve_passive,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            if (isActive) {
              context
                  .read<UserManagementBloc>()
                  .add(ApproveUserEvent(userId: user.id));
            } else {
              context
                  .read<UserManagementBloc>()
                  .add(ApprovePassiveUserEvent(userId: user.id));
            }
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

Future<bool?> showUserSuspendDialog({
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
      title: Text(AppLocalizations.of(context)!.user_confirm_suspended),
      content: Text(
        AppLocalizations.of(context)!.user_suspended_question(user.firstName),
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
            Navigator.pop(context, false);
          },
        ),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.suspend,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context
                .read<UserManagementBloc>()
                .add(SuspendUserEvent(userId: user.id));
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}

Future<bool?> showUserUnsuspendDialog({
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
      title: Text(AppLocalizations.of(context)!.user_confirm_unsuspended),
      content: Text(
        AppLocalizations.of(context)!.user_unsuspended_question(user.firstName),
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
            AppLocalizations.of(context)!.unsuspend,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context
                .read<UserManagementBloc>()
                .add(UnsuspendUserEvent(userId: user.id));
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}

Future<bool?> showMakeAdminDialog({
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
      title: Text(AppLocalizations.of(context)!.user_make_admin),
      content: Text(
        AppLocalizations.of(context)!.user_make_admin_question(user.firstName),
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
            AppLocalizations.of(context)!.confirm,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context
                .read<UserManagementBloc>()
                .add(MakeUserAdministratorEvent(userId: user.id));
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}

Future<bool?> showUnmakeAdminDialog({
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
      title: Text(AppLocalizations.of(context)!.user_unmake_admin),
      content: Text(
        AppLocalizations.of(context)!
            .user_unmake_admin_question(user.firstName),
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
            AppLocalizations.of(context)!.confirm,
            style: const TextStyle(
              color: Colors.amber,
            ),
          ),
          onPressed: () {
            context
                .read<UserManagementBloc>()
                .add(UnmakeUserAdministratorEvent(userId: user.id));
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}
