import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../domain/entities/user_profile.dart';
import '../blocs/user_management/user_management_bloc.dart';
import '../widgets/inactive_user_list_tile.dart';

class NewUsersListPage extends StatelessWidget {
  const NewUsersListPage({Key? key}) : super(key: key);

  static const routeName = '/users/new_users_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.user_new_users),
      ),
      body: BlocListener<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          String message = '';
          bool isError = false;

          if (state is UserManagementSuccessful) {
            switch (state.message) {
              case userApproved:
                message = AppLocalizations.of(context)!.user_new_user_approved;
                break;
              case userRejected:
                message = AppLocalizations.of(context)!.user_new_user_rejected;
                isError = true;
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
                    backgroundColor: isError
                        ? Theme.of(context).errorColor
                        : Theme.of(context).primaryColor,
                  ),
                );
            }
          }
        },
        child: Stack(
          children: [
            BlocBuilder<NewUsersBloc, NewUsersState>(
              builder: (context, state) {
                if (state is NewUsersLoadedState) {
                  List<UserProfile> users = state.newUsers.allUsers
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
                        isNewUser: true,
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
