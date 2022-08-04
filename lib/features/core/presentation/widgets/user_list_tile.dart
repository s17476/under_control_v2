import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../user_profile/domain/entities/user_profile.dart';
import 'cached_user_avatar.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    this.isSelectionTile = false,
    this.isGroupAdministrator = false,
    this.isGroupMember = false,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  final bool isSelectionTile;
  final bool isGroupAdministrator;
  final bool isGroupMember;

  final UserProfile user;

  final Function(UserProfile userProfile) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(user),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            CachedUserAvatar(
              size: 60,
              imageUrl: user.avatarUrl,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        user.firstName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        user.lastName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                  if (user.administrator)
                    Text(
                      AppLocalizations.of(context)!.user_details_admin,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  if (!user.administrator && isGroupAdministrator)
                    Text(
                      AppLocalizations.of(context)!.user_details_group_admin,
                      style: Theme.of(context).textTheme.caption,
                    ),
                ],
              ),
            ),
            if (isSelectionTile && isGroupMember)
              SizedBox(
                width: 50,
                child: Icon(
                  Icons.remove,
                  size: 40,
                  color: Theme.of(context).errorColor,
                ),
              ),
            if (isSelectionTile && !isGroupMember)
              Icon(
                Icons.add,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
