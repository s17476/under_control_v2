import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/presentation/widgets/highlighted_text.dart';

import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/checklist.dart';

class ChecklistTile extends StatelessWidget {
  const ChecklistTile({
    Key? key,
    required this.checklist,
    this.onTap,
    this.user,
    this.searchQuery = '',
  }) : super(key: key);

  final Checklist checklist;
  final UserProfile? user;
  final String searchQuery;

  final Function(Checklist checklist)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap != null) ? () => onTap!(checklist) : null,
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
                        Icons.checklist,
                        color: Theme.of(context).primaryColor,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: HighlightedText(
                          text: checklist.title,
                          query: searchQuery,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
                  if (checklist.description.isNotEmpty)
                    Text(
                      checklist.description,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
