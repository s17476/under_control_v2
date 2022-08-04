import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/group.dart';

class GroupMembers extends StatefulWidget {
  const GroupMembers({
    Key? key,
    required this.group,
    required this.onTap,
  }) : super(key: key);

  final Group group;

  final Function(UserProfile userProfile) onTap;

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  bool isExpanded = false;

  void toggleIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // gets company profile state
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      // gets group members
      final companyMembers = companyState.companyUsers.allUsers;
      List<UserProfile> groupMembers = companyMembers
          .where((element) => element.userGroups.contains(widget.group.id))
          .toList();
      // sorts list by last name
      groupMembers = groupMembers
        ..sort(
          (a, b) => a.lastName.compareTo(b.lastName),
        );
      // gets current user
      final currentUser =
          (context.read<UserProfileBloc>().state as Approved).userProfile;
      return Column(
        children: [
          // title
          InkWell(
            onTap: toggleIsExpanded,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 4,
                right: 4,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!.group_members}: ${groupMembers.length}',
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          // members list
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Container(
              height: isExpanded ? null : 0,
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groupMembers.length,
                itemBuilder: (context, index) => UserListTile(
                  key: ValueKey(groupMembers[index].id),
                  user: groupMembers[index],
                  onTap: currentUser.id == groupMembers[index].id
                      ? (UserProfile _) {}
                      : widget.onTap,
                  isGroupAdministrator: widget.group.groupAdministrators
                      .contains(groupMembers[index].id),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
