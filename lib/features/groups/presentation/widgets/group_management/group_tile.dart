import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_management/user_management_bloc.dart';
import '../../../domain/entities/group.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    Key? key,
    required this.group,
    required this.onTap,
    this.isGroupMember = false,
    this.user,
    this.isSelectionTile = false,
  }) : super(key: key);

  final Group group;
  final UserProfile? user;
  final bool isSelectionTile;
  final bool isGroupMember;

  final Function(Group group) onTap;

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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(group),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).focusColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title row
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: Theme.of(context).primaryColor,
                        size: 24,
                      ),
                      // shows icon if user is group administrator
                      //and is not an company administrator
                      if (user != null &&
                          group.groupAdministrators.contains(user!.id))
                        Icon(
                          Icons.gpp_good,
                          color: Theme.of(context).primaryColor,
                        ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          group.name,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey.shade200,
                                    fontSize: 18,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // description
                  if (group.description.isNotEmpty)
                    Text(
                      group.description,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                ],
              ),
            ),
            if (isSelectionTile && !isGroupMember)
              Icon(
                Icons.add,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            if (isSelectionTile && isGroupMember)
              Icon(
                Icons.remove,
                size: 40,
                color: Theme.of(context).errorColor,
              ),
          ],
        ),
      ),
    );
  }
}
