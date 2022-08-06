import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_details.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../company_profile/presentation/widgets/user_management_dialogs.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/url_launcher_helpers.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../core/utils/size_config.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../domain/entities/user_profile.dart';
import '../blocs/user_management/user_management_bloc.dart';
import '../blocs/user_profile/user_profile_bloc.dart';
import '../widgets/avatar_editor_card.dart';
import '../widgets/edit_user_modal_bottom_sheet.dart';
import '../widgets/manage_groups_card.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/users/user-details';

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> with ResponsiveSize {
  UserProfile? user;
  late UserProfile currentUser;
  List<Choice> choices = [];

  bool isAvatarEditorVisible = false;

  bool isGroupManagementVisible = false;

  void showAvatarEditor() {
    hideGroupManagement();
    setState(() {
      isAvatarEditorVisible = true;
    });
  }

  void hideAvatarEditor() {
    setState(() {
      isAvatarEditorVisible = false;
    });
  }

  void showGroupManagement() {
    hideAvatarEditor();
    setState(() {
      isGroupManagementVisible = true;
    });
  }

  void hideGroupManagement() {
    setState(() {
      isGroupManagementVisible = false;
    });
  }

  // assign to / unassign from a group
  void toggleGroup(
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
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      currentUser = currentState.userProfile;
    }
    // gets selected user
    final userId =
        (ModalRoute.of(context)?.settings.arguments as UserProfile).id;
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      final index = companyState.companyUsers.allUsers
          .indexWhere((element) => element.id == userId);
      if (index >= 0) {
        setState(() {
          user = companyState.companyUsers.allUsers[index];
        });
        // popup menu items
        choices = [
          // edit users data
          Choice(
            title: AppLocalizations.of(context)!.user_details_edit_data,
            icon: Icons.edit,
            onTap: () => showEditUserModalBottomSheet(
              context: context,
              user: user!,
            ),
          ),
          // edit users avatar image
          Choice(
            title: AppLocalizations.of(context)!.user_details_edit_avatar,
            icon: Icons.person,
            onTap: () => showAvatarEditor(),
          ),
          // manage groups
          if (currentUser.administrator)
            Choice(
              title: AppLocalizations.of(context)!.group_manage_user_groups,
              icon: Icons.group,
              onTap: () => showGroupManagement(),
            ),
          // suspend user
          if (user!.id != currentUser.id && currentUser.administrator)
            Choice(
              title: AppLocalizations.of(context)!.suspend,
              icon: Icons.person_off,
              onTap: () => showUserSuspendDialog(context: context, user: user!),
            ),
          // make admin
          if (user!.id != currentUser.id &&
              !user!.administrator &&
              currentUser.administrator)
            Choice(
              title: AppLocalizations.of(context)!.user_make_admin,
              icon: Icons.gpp_good,
              onTap: () => showMakeAdminDialog(context: context, user: user!),
            ),
          // revoke admin
          if (user!.id != currentUser.id &&
              user!.administrator &&
              currentUser.administrator)
            Choice(
              title: AppLocalizations.of(context)!.user_unmake_admin,
              icon: Icons.gpp_bad,
              onTap: () => showUnmakeAdminDialog(context: context, user: user!),
            ),
        ];
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return WillPopScope(
      onWillPop: () async {
        if (isGroupManagementVisible) {
          hideGroupManagement();
          return false;
        }
        if (isAvatarEditorVisible) {
          hideAvatarEditor();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
          title: Text(AppLocalizations.of(context)!.user_details_title),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          actions: [
            // shows popup menu if current user is administrator
            // or current user is selected user
            if (user != null &&
                (currentUser.administrator || currentUser.id == user!.id))
              PopupMenuButton<Choice>(
                onSelected: (Choice choice) {
                  if (isAvatarEditorVisible) {
                    hideAvatarEditor();
                  }
                  if (isGroupManagementVisible) {
                    hideGroupManagement();
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
        body: user == null
            ? const LoadingWidget()
            : BlocListener<UserManagementBloc, UserManagementState>(
                listener: (context, state) {
                  if (state is UserManagementSuccessful) {
                    String message = '';
                    switch (state.message) {
                      case userUpdated:
                        message = AppLocalizations.of(context)!
                            .user_details_data_updated;
                        break;
                      case avatarUpdated:
                        message = AppLocalizations.of(context)!
                            .user_details_avatar_updated;
                        break;
                      case userAssignedToGroup:
                        message = AppLocalizations.of(context)!
                            .user_details_user_assigned;
                        break;
                      case userUnassignedFromGroup:
                        message = AppLocalizations.of(context)!
                            .user_details_user_unassigned;
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
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            // avatar and name
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: const Alignment(0, 1),
                                  colors: [
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(50),
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(50),
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  CachedUserAvatar(
                                    size: responsiveSizePct(small: 70),
                                    imageUrl: user!.avatarUrl,
                                  ),
                                  Text(
                                    user!.firstName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    user!.lastName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            // user data
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                              ),
                              child: Column(
                                children: [
                                  // title
                                  IconTitleRow(
                                    icon: Icons.person,
                                    iconColor: Colors.grey.shade300,
                                    iconBackground: Colors.black,
                                    title: AppLocalizations.of(context)!
                                        .user_details_data,
                                    titleFontSize: 16,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // phone number
                                  InkWell(
                                    onTap: () =>
                                        makePhoneCall(user!.phoneNumber),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .add_company_intro_card_phone_number,
                                            ),
                                          ),
                                          Text(user!.phoneNumber),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // sms
                                  InkWell(
                                    onTap: () => sendSms(user!.phoneNumber),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.message,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .user_details_sms,
                                            ),
                                          ),
                                          Text(user!.phoneNumber),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // email
                                  InkWell(
                                    onTap: () => mailTo(user!.email),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .add_company_intro_card_email,
                                            ),
                                          ),
                                          Text(
                                            user!.email,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .user_details_join_date,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(user!.joinDate),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 8,
                              endIndent: 8,
                              thickness: 1.5,
                            ),

                            // user premissions
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 16,
                                right: 16,
                              ),
                              child: Column(
                                children: [
                                  // title
                                  IconTitleRow(
                                    icon: Icons.error,
                                    iconColor: Colors.grey.shade300,
                                    iconBackground: Colors.black,
                                    title: AppLocalizations.of(context)!
                                        .user_details_premissions,
                                    titleFontSize: 16,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // administrator
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          user!.administrator
                                              ? Icons.gpp_good
                                              : Icons.gpp_bad,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .user_details_admin,
                                          ),
                                        ),
                                        Text(
                                          user!.administrator
                                              ? AppLocalizations.of(context)!
                                                  .yes
                                              : AppLocalizations.of(context)!
                                                  .no,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 8,
                              endIndent: 8,
                              thickness: 1.5,
                            ),

                            // user groups
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 16,
                                right: 16,
                              ),
                              child: Column(
                                children: [
                                  // title
                                  IconTitleRow(
                                    icon: Icons.group,
                                    iconColor: Colors.grey.shade300,
                                    iconBackground: Colors.black,
                                    title: AppLocalizations.of(context)!
                                        .drawer_item_groups,
                                    titleFontSize: 16,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // groups
                                  BlocBuilder<GroupBloc, GroupState>(
                                    builder: (context, state) {
                                      if (state is GroupLoadedState) {
                                        List<Group> userGroups = [];
                                        for (var group
                                            in state.allGroups.allGroups) {
                                          if (user!.userGroups
                                              .contains(group.id)) {
                                            userGroups.add(group);
                                          }
                                        }
                                        if (userGroups.isEmpty) {
                                          return Text(
                                            AppLocalizations.of(context)!
                                                .group_no_user_groups,
                                          );
                                        } else {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: userGroups.length,
                                            itemBuilder: (context, index) =>
                                                GroupTile(
                                              group: userGroups[index],
                                              onTap: (group) =>
                                                  Navigator.pushNamed(
                                                context,
                                                GroupDetailsPage.routeName,
                                                arguments: group,
                                              ),
                                              user: user,
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isAvatarEditorVisible && user != null)
                        AvatarEditorCard(
                          user: user!,
                          onDismiss: hideAvatarEditor,
                        ),
                      if (isGroupManagementVisible)
                        ManageGroupsCard(
                          user: user!,
                          onToggleGroupSelection: toggleGroup,
                          onDismiss: hideGroupManagement,
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
