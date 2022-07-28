import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/groups/presentation/pages/add_group_page.dart';

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
  bool isAdministrator = false;

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

  @override
  void didChangeDependencies() {
    isAdministrator = (context.read<UserProfileBloc>().state as Approved)
        .userProfile
        .administrator;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // gets group data
    final group = ModalRoute.of(context)!.settings.arguments as Group;

    return WillPopScope(
      onWillPop: () async {
        if (isUserInfoCardVisible) {
          hideUserInfoCard();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(group.name),
          centerTitle: true,
          actions: [
            // edit button
            if (isAdministrator)
              IconButton(
                onPressed: () async {
                  hideUserInfoCard();
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
                        // description
                        if (group.description.isNotEmpty)
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
                                    Icons.text_snippet,
                                    size: 20,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  group.description,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.grey.shade200,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (group.description.isNotEmpty)
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
                if (isUserInfoCardVisible)
                  UserInfoCard(
                    onDismiss: hideUserInfoCard,
                    user: userProfile!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
