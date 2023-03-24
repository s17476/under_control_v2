import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../notifications/domain/entities/uc_notification.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import 'cached_user_avatar.dart';
import 'highlighted_text.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    this.isSelectionTile = false,
    this.isGroupAdministrator = false,
    this.isGroupMember = false,
    this.showAdmin = true,
    this.notification,
    this.avatarSize = 60,
    this.nameSize = 18,
    this.searchQuery = '',
    required this.user,
    required this.onTap,
  }) : super(key: key);

  final bool isSelectionTile;
  final bool isGroupAdministrator;
  final bool isGroupMember;
  final bool showAdmin;
  final UcNotification? notification;

  final double avatarSize;
  final double nameSize;

  final String searchQuery;

  final UserProfile user;

  final Function(UserProfile userProfile) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (notification != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: notification!.read
                  ? Colors.black
                  : Theme.of(context).primaryColor.withAlpha(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_add, size: 16),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  AppLocalizations.of(context)!.user_new_user,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        Material(
          color: notification == null ? Colors.transparent : null,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          child: InkWell(
            onTap: () => onTap(user),
            borderRadius: BorderRadius.circular(15),
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
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        if (!user.administrator && isGroupAdministrator)
                          Text(
                            AppLocalizations.of(context)!
                                .user_details_group_admin,
                            style: Theme.of(context).textTheme.bodySmall,
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
          ),
        ),
      ],
    );
  }
}
