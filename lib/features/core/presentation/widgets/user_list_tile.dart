import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../user_profile/domain/entities/user_profile.dart';
import 'cached_user_avatar.dart';
import 'highlighted_text.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    this.isSelectionTile = false,
    this.isGroupAdministrator = false,
    this.isGroupMember = false,
    this.avatarSize = 60,
    this.nameSize = 18,
    this.showAdmin = true,
    required this.user,
    required this.onTap,
    this.searchQuery = '',
  }) : super(key: key);

  final bool isSelectionTile;
  final bool isGroupAdministrator;
  final bool isGroupMember;
  final bool showAdmin;

  final double avatarSize;
  final double nameSize;

  final String searchQuery;

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
              size: avatarSize,
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
                      HighlightedText(
                        text: user.firstName,
                        query: searchQuery,
                        style: TextStyle(
                          fontSize: nameSize,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      HighlightedText(
                        text: user.lastName,
                        query: searchQuery,
                        style: TextStyle(
                          fontSize: nameSize,
                        ),
                      ),
                    ],
                  ),
                  if (showAdmin && user.administrator)
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
            if (isSelectionTile)
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: isGroupMember,
                onChanged: (_) => onTap(user),
              ),
          ],
        ),
      ),
    );
  }
}
