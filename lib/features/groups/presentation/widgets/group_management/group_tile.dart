import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/highlighted_text.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/group.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    Key? key,
    required this.group,
    required this.onTap,
    this.isGroupMember = false,
    this.user,
    this.isSelectionTile = false,
    this.searchQuery = '',
  }) : super(key: key);

  final Group group;
  final UserProfile? user;
  final bool isSelectionTile;
  final bool isGroupMember;

  final String searchQuery;

  final Function(Group group) onTap;

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
          color: isSelectionTile
              ? Theme.of(context).cardColor
              : Theme.of(context).focusColor,
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
                          child: HighlightedText(
                        text: group.name,
                        query: searchQuery,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey.shade200,
                              fontSize: 18,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
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
            if (isSelectionTile)
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: isGroupMember,
                onChanged: (_) => onTap(group),
              ),
          ],
        ),
      ),
    );
  }
}
