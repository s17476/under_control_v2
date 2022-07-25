import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/pages/loading_page.dart';
import 'package:under_control_v2/features/core/presentation/widgets/loading_widget.dart';
import 'package:under_control_v2/features/groups/presentation/widgets/group_management/group_tile.dart';

import '../blocs/group/group_bloc.dart';
import 'add_group_page.dart';

class GroupManagementPage extends StatelessWidget {
  const GroupManagementPage({Key? key}) : super(key: key);

  static const routeName = '/groups';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.group_management_title),
        centerTitle: true,
      ),
      body: BlocConsumer<GroupBloc, GroupState>(
        // shows message
        listener: (context, state) {
          if (state is GroupLoadedState) {
            if (state.message.isNotEmpty) {
              String message = '';
              switch (state.message) {
                case addedMessage:
                  message = AppLocalizations.of(context)!
                      .group_management_add_added_new_msg;
                  break;
                case updateSuccess:
                  message = AppLocalizations.of(context)!.update_success;
                  break;
                default:
                  message = '';
              }
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: state.error
                        ? Theme.of(context).errorColor
                        : Theme.of(context).primaryColor,
                  ),
                );
            }
          }
        },
        builder: (context, state) {
          if (state is GroupLoadedState) {
            return ListView.builder(
              itemCount: state.allGroups.allGroups.length + 1,
              itemBuilder: (context, index) {
                if (index == state.allGroups.allGroups.length) {
                  return const SizedBox(
                    height: 80,
                  );
                } else {
                  return GroupTile(
                    key: ValueKey(state.allGroups.allGroups[index].id),
                    group: state.allGroups.allGroups[index],
                  );
                }
              },
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddGroupPage.routeName);
        },
        icon: Icon(
          Icons.group_add,
          color: Colors.grey.shade200,
        ),
        label: Text(
          AppLocalizations.of(context)!.group_management_add_button,
          style: TextStyle(
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
