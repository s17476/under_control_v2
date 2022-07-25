import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_details.dart';
import 'package:under_control_v2/features/groups/presentation/widgets/group_management/group_management_feature_card.dart';

import '../../../domain/entities/group.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        GroupDetailsPage.routeName,
        arguments: group,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).focusColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title row
            Row(
              children: [
                Icon(
                  Icons.group,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  group.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.grey.shade200),
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
    );
  }
}
