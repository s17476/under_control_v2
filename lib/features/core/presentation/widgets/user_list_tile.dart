import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/presentation/widgets/cached_user_avatar.dart';

import '../../../user_profile/domain/entities/user_profile.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

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
      ),
    );
  }
}
