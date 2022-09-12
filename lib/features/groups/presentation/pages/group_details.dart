import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/icon_title_row.dart';

import '../../../core/presentation/widgets/add_members_card.dart';
import '../../../core/presentation/widgets/user_info_card.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_management/user_management_bloc.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/group.dart';
import '../blocs/group/group_bloc.dart';
import '../widgets/group_details/group_locations.dart';
import '../widgets/group_details/group_members.dart';
import '../widgets/group_details/show_group_delete_dialog.dart';
import '../widgets/group_management/group_management_feature_card.dart';
import 'add_group_page.dart';

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
  bool isAddMembersCardVisible = false;

  bool isAdministrator = false;
  bool isGroupAdministrator = false;

  late Group group;

  List<Choice> choices = [];

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
      isAddMembersCardVisible = true;
    });
  }

  void hideAddUsersCard() {
    setState(() {
      isAddMembersCardVisible = false;
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
    final groupId = (ModalRoute.of(context)!.settings.arguments as Group).id;
    final groupState = context.watch<GroupBloc>().state;
    if (groupState is GroupLoadedState) {
      final index = groupState.allGroups.allGroups
          .indexWhere((element) => element.id == groupId);
      if (index >= 0) {
        setState(() {
          group = groupState.allGroups.allGroups[index];
        });
      }
    }
    // gets current user
    final currentUserProfile =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    isAdministrator = currentUserProfile.administrator;
    isGroupAdministrator =
        group.groupAdministrators.contains(currentUserProfile.id);

    // popup menu items list
    setState(() {
      choices = [
        // manage group members
        if (isAdministrator || isGroupAdministrator)
          Choice(
            title: AppLocalizations.of(context)!.group_members,
            icon: Icons.group,
            onTap: () => showAddUsersCard(),
          ),
        // edit group
        if (isAdministrator)
          Choice(
            title: AppLocalizations.of(context)!.user_details_edit_data,
            icon: Icons.edit,
            onTap: () => Navigator.pushNamed(
              context,
              AddGroupPage.routeName,
              arguments: group,
            ),
          ),
        // delete group
        if (isAdministrator)
          Choice(
            title: AppLocalizations.of(context)!.delete,
            icon: Icons.delete,
            onTap: () async {
              final result =
                  await showGroupDeleteDialog(context: context, group: group);
              if (result != null && result) {
                Navigator.pop(context);
              }
            },
          ),
      ];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '';
    if (isAddMembersCardVisible) {
      appBarTitle = AppLocalizations.of(context)!.group_toggle_group_members;
    } else if (isUserInfoCardVisible) {
      appBarTitle = AppLocalizations.of(context)!.user_details_title;
    } else {
      appBarTitle = AppLocalizations.of(context)!.group_details;
    }
    return WillPopScope(
      onWillPop: () async {
        if (isUserInfoCardVisible) {
          hideUserInfoCard();
          return false;
        }
        if (isAddMembersCardVisible) {
          hideAddUsersCard();
          return false;
        }
        return true;
      },
      child: BlocListener<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          if (state is UserManagementSuccessful) {
            String message = '';
            switch (state.message) {
              case userAssignedToGroup:
                message =
                    AppLocalizations.of(context)!.user_details_user_assigned;
                break;
              case userUnassignedFromGroup:
                message =
                    AppLocalizations.of(context)!.user_details_user_unassigned;
                break;
              case assignedGroupAdmin:
                message =
                    AppLocalizations.of(context)!.group_assigned_group_admin;
                break;
              case unassignedGroupAdmin:
                message =
                    AppLocalizations.of(context)!.group_unassigned_group_admin;
                break;
              default:
                message = '';
                break;
            }
            if (message.isNotEmpty) {
              showSnackBar(
                context: context,
                message: message,
                isErrorMessage: state.error,
              );
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            centerTitle: true,
            actions: [
              // popup menu
              if (choices.isNotEmpty)
                PopupMenuButton<Choice>(
                  onSelected: (Choice choice) {
                    if (isAddMembersCardVisible) {
                      hideAddUsersCard();
                    }
                    if (isUserInfoCardVisible) {
                      hideUserInfoCard();
                    }
                    choice.onTap();
                  },
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(choice.icon),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              choice.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
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
                showSnackBar(
                  context: context,
                  message: message,
                  isErrorMessage: state.error,
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
                            child: IconTitleRow(
                              icon: Icons.group,
                              iconColor: Colors.white,
                              iconBackground: Colors.black,
                              title: AppLocalizations.of(context)!.group_data,
                              titleFontSize: 16,
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
                            child: IconTitleRow(
                              icon: Icons.error,
                              iconColor: Colors.white,
                              iconBackground: Colors.black,
                              title: AppLocalizations.of(context)!
                                  .group_management_add_card_permissions,
                              titleFontSize: 16,
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
                      group: group,
                    ),
                  // add users to the group card
                  if (isAddMembersCardVisible)
                    AddMembersCard(
                      onDismiss: hideAddUsersCard,
                      onToggleUserSelection: toggleUser,
                      group: group,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
