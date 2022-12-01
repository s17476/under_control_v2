import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/add_members_card.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
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
import '../../utils/show_group_delete_dialog.dart';
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
  UserProfile? _userProfile;

  bool _isUserInfoCardVisible = false;
  bool _isAddMembersCardVisible = false;
  bool _isAdministrator = false;
  bool _isGroupAdministrator = false;

  late Group _group;

  List<Choice> _choices = [];

  void _showUserInfoCard(UserProfile userProfile) {
    setState(() {
      _userProfile = userProfile;
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    setState(() {
      _isUserInfoCardVisible = false;
      _userProfile = null;
    });
  }

  void _showAddUsersCard() {
    setState(() {
      _isAddMembersCardVisible = true;
    });
  }

  void _hideAddUsersCard() {
    setState(() {
      _isAddMembersCardVisible = false;
    });
  }

  // assign / unassign member
  void _toggleUser(
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
          _group = groupState.allGroups.allGroups[index];
        });
      }
    }
    // gets current user
    final currentUserProfile =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    _isAdministrator = currentUserProfile.administrator;
    _isGroupAdministrator =
        _group.groupAdministrators.contains(currentUserProfile.id);

    // popup menu items list
    setState(() {
      _choices = [
        // manage group members
        if (_isAdministrator || _isGroupAdministrator)
          Choice(
            title: AppLocalizations.of(context)!.group_members,
            icon: Icons.group,
            onTap: () => _showAddUsersCard(),
          ),
        // edit group
        if (_isAdministrator)
          Choice(
            title: AppLocalizations.of(context)!.user_details_edit_data,
            icon: Icons.edit,
            onTap: () => Navigator.pushNamed(
              context,
              AddGroupPage.routeName,
              arguments: _group,
            ),
          ),
        // delete group
        if (_isAdministrator)
          Choice(
            title: AppLocalizations.of(context)!.delete,
            icon: Icons.delete,
            onTap: () async {
              final result =
                  await showGroupDeleteDialog(context: context, group: _group);
              if (result != null && result && mounted) {
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
    if (_isAddMembersCardVisible) {
      appBarTitle = AppLocalizations.of(context)!.group_toggle_group_members;
    } else if (_isUserInfoCardVisible) {
      appBarTitle = AppLocalizations.of(context)!.user_details_title;
    } else {
      appBarTitle = AppLocalizations.of(context)!.group_details;
    }
    return WillPopScope(
      onWillPop: () async {
        if (_isUserInfoCardVisible) {
          _hideUserInfoCard();
          return false;
        }
        if (_isAddMembersCardVisible) {
          _hideAddUsersCard();
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
              if (_choices.isNotEmpty)
                PopupMenuButton<Choice>(
                  onSelected: (Choice choice) {
                    if (_isAddMembersCardVisible) {
                      _hideAddUsersCard();
                    }
                    if (_isUserInfoCardVisible) {
                      _hideUserInfoCard();
                    }
                    choice.onTap();
                  },
                  itemBuilder: (BuildContext context) {
                    return _choices.map((Choice choice) {
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
                              _group.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          // description
                          if (_group.description.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                              ),
                              child: Text(
                                _group.description,
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
                          for (var feature in _group.features)
                            GroupManagementFeatureCard(feature: feature),
                          const Divider(thickness: 1.5),
                          // locations
                          GroupLocations(group: _group),
                          const Divider(
                            thickness: 1.5,
                            // height: 32,
                          ),
                          // group members
                          GroupMembers(
                            group: _group,
                            onTap: _showUserInfoCard,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // user info card
                  if (_isUserInfoCardVisible)
                    UserInfoCard(
                      onDismiss: _hideUserInfoCard,
                      user: _userProfile!,
                      group: _group,
                    ),
                  // add users to the group card
                  if (_isAddMembersCardVisible)
                    AddMembersCard(
                      onDismiss: _hideAddUsersCard,
                      onToggleUserSelection: _toggleUser,
                      group: _group,
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
