import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../domain/entities/user_profile.dart';
import '../blocs/user_management/user_management_bloc.dart';
import '../widgets/inactive_user_list_tile.dart';

class SuspendedUsersListPage extends StatelessWidget {
  const SuspendedUsersListPage({Key? key}) : super(key: key);

  static const routeName = '/users/suspended_users_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.user_suspended_users),
      ),
      body: BlocListener<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          String message = '';

          if (state is UserManagementSuccessful) {
            switch (state.message) {
              case userUnsuspended:
                message = AppLocalizations.of(context)!.user_unsuspended;
                break;
              default:
                message = '';
            }
            if (message.isNotEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
            }
          }
        },
        child: Stack(
          children: [
            BlocBuilder<SuspendedUsersBloc, SuspendedUsersState>(
              builder: (context, state) {
                if (state is SuspendedUsersLoadedState) {
                  List<UserProfile> users = state.suspendedUsers.allUsers
                    ..sort(
                      (a, b) => a.firstName.compareTo(b.firstName),
                    );
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: users.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      child: InactiveUserListTile(
                        user: users[index],
                        isNewUser: false,
                      ),
                    ),
                  );
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
