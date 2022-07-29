import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/groups/presentation/pages/add_group_page.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';

import '../../../core/presentation/widgets/add_user_card.dart';
import '../../../core/presentation/widgets/user_info_card.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/group.dart';
import '../blocs/group/group_bloc.dart';
import '../widgets/group_details/group_locations.dart';
import '../widgets/group_details/group_members.dart';
import '../widgets/group_details/show_group_delete_dialog.dart';
import '../widgets/group_management/group_management_feature_card.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/groups/group-details';

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  UserProfile? userProfile;

  bool isUserInfoCardVisible = false;
  bool isAddUsersCardVisible = false;

  bool isAdministrator = false;
  bool isGroupAdministrator = false;

  late Group group;

  void showUserInfoCard(UserProfile userProfile) {
    setState(() {
      this.userProfile = userProfile;
      isUserInfoCardVisible = true;
    });
  }

  void hideUserInfoCard() {
    setState(() {
      isUserInfoCardVisible = false;
      userProfile = null;
    });
  }

  void showAddUsersCard() {
    setState(() {
      isAddUsersCardVisible = true;
    });
  }

  void hideAddUsersCard() {
    setState(() {
      isAddUsersCardVisible = false;
    });
  }

  // assign / unassign member
  void toggleUser(
    BuildContext context,
    Group group,
    UserProfile user,
  ) {
    // user is aleraedy a member
    if (user.userGroups.contains(group.id)) {
      context.read<UserManagementBloc>().add(
            UnassignUserFromGroupEvent(groupId: group.id, userId: user.id),
          );
      // user is not a member
    } else {
      context.read<UserManagementBloc>().add(
            AssignUserToGroupEvent(groupId: group.id, userId: user.id),
          );
    }
  }

  @override
  void didChangeDependencies() {
    // gets group data
    group = ModalRoute.of(context)!.settings.arguments as Group;
    final currentUserProfile =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    isAdministrator = currentUserProfile.administrator;
    isGroupAdministrator =
        group.groupAdministrators.contains(currentUserProfile.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isUserInfoCardVisible) {
          hideUserInfoCard();
          return false;
        }
        if (isAddUsersCardVisible) {
          hideAddUsersCard();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.group_details),
          centerTitle: true,
          actions: [
            // add member button
            if (isAdministrator || isGroupAdministrator)
              IconButton(
                onPressed: () async {
                  hideUserInfoCard();
                  if (isAddUsersCardVisible) {
                    hideAddUsersCard();
                  } else {
                    showAddUsersCard();
                  }
                },
                icon: const Icon(Icons.group),
              ),
            // edit button
            if (isAdministrator)
              IconButton(
                onPressed: () async {
                  hideUserInfoCard();
                  hideAddUsersCard();
                  Navigator.popAndPushNamed(
                    context,
                    AddGroupPage.routeName,
                    arguments: group,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            // delete button
            if (isAdministrator)
              IconButton(
                onPressed: () async {
                  hideUserInfoCard();
                  hideAddUsersCard();
                  final result = await showGroupDeleteDialog(
                      context: context, group: group);
                  if (result != null && result) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        body: BlocListener<GroupBloc, GroupState>(
          listener: (context, state) {
            String message = '';
            if (state is GroupLoadedState) {
              switch (state.message) {
                case groupContainsMembers:
                  message = AppLocalizations.of(context)!
                      .group_management_delete_error_not_empty;
                  break;
                default:
                  message = '';
                  break;
              }
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
                    backgroundColor: state.error
                        ? Theme.of(context).errorColor
                        : Theme.of(context).primaryColor,
                  ),
                );
            }
          },
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // data

                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.group,
                                  size: 20,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of(context)!.group_data,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // name
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: Text(
                            group.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        // description
                        if (group.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 8,
                              right: 8,
                            ),
                            child: Text(
                              group.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            thickness: 1.5,
                          ),
                        ),
                        // features
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.error,
                                  size: 20,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .group_management_add_card_permissions,
                                style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        for (var feature in group.features)
                          GroupManagementFeatureCard(feature: feature),
                        const Divider(thickness: 1.5),
                        // locations
                        GroupLocations(group: group),
                        const Divider(
                          thickness: 1.5,
                          // height: 32,
                        ),
                        // group members
                        GroupMembers(
                          group: group,
                          onTap: showUserInfoCard,
                        ),
                      ],
                    ),
                  ),
                ),
                // user info card
                if (isUserInfoCardVisible)
                  UserInfoCard(
                    onDismiss: hideUserInfoCard,
                    user: userProfile!,
                  ),
                // add users to the group card
                if (isAddUsersCardVisible)
                  AddUserCard(
                    onDismiss: hideAddUsersCard,
                    onToggleUserSelection: toggleUser,
                    group: group,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
