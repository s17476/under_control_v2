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
      onTap: () => Navigator.pushNamed(context, GroupDetailsPage.routeName),
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
                  color: Colors.grey.shade200,
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
            const Divider(
              thickness: 1.5,
              height: 3,
            ),
            // description
            if (group.description.isNotEmpty)
              Text(
                group.description,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            const SizedBox(
              height: 4,
            ),
            // features
            for (var feature in group.features)
              GroupManagementFeatureCard(feature: feature),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 4,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 20,
                      // color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.group_management_add_card_selected_locations} : ${group.locations.length}',
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                    ),
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
