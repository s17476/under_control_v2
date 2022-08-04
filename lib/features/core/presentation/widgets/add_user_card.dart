import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../utils/responsive_size.dart';
import '../../utils/size_config.dart';
import 'user_list_tile.dart';

class AddUserCard extends StatefulWidget {
  const AddUserCard({
    Key? key,
    required this.group,
    required this.onToggleUserSelection,
    required this.onDismiss,
  }) : super(key: key);

  final Group group;
  final VoidCallback onDismiss;
  final Function(BuildContext context, Group group, UserProfile user)
      onToggleUserSelection;

  @override
  State<AddUserCard> createState() => _AddUserCardState();
}

class _AddUserCardState extends State<AddUserCard> with ResponsiveSize {
  List<UserProfile> allUsers = [];
  late UserProfile currentUser;

  void toggleUser(UserProfile user) {
    widget.onToggleUserSelection(context, widget.group, user);
  }

  @override
  void didChangeDependencies() {
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      allUsers = companyState.companyUsers.allUsers;
    }
    currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Stack(children: [
      InkWell(
        onTap: () => widget.onDismiss(),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0.0, end: 0.5),
          builder: (context, double value, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(value),
              ),
            );
          },
        ),
      ),
      TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // title
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .group_toggle_group_members,
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const Divider(thickness: 1.5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allUsers.length,
                        itemBuilder: (context, index) {
                          return UserListTile(
                            user: allUsers[index],
                            onTap: currentUser.administrator
                                ? toggleUser
                                : currentUser.id == allUsers[index].id
                                    ? (UserProfile _) {}
                                    : toggleUser,
                            isSelectionTile:
                                (allUsers[index].id != currentUser.id) ||
                                    currentUser.administrator,
                            isGroupMember: allUsers[index]
                                .userGroups
                                .contains(widget.group.id),
                            isGroupAdministrator: widget
                                .group.groupAdministrators
                                .contains(allUsers[index].id),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
