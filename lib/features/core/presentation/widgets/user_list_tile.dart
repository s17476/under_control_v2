import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            ClipOval(
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.fitWidth,
                imageUrl: user.avatarUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported_rounded),
              ),
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
