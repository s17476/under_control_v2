import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/group.dart';
import '../widgets/group_management/group_management_feature_card.dart';

class GroupDetailsPage extends StatelessWidget {
  const GroupDetailsPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/groups/group-details';

  @override
  Widget build(BuildContext context) {
    // gets group data
    final group = ModalRoute.of(context)!.settings.arguments as Group;

    return Scaffold(
        appBar: AppBar(
          title: Text(group.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // description
                if (group.description.isNotEmpty)
                  Text(
                    group.description,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                    ),
                  ),
                if (group.description.isNotEmpty) const Divider(thickness: 1.5),
                // features
                Text(
                  AppLocalizations.of(context)!
                      .group_management_add_card_permissions,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                for (var feature in group.features)
                  GroupManagementFeatureCard(feature: feature),
                const Divider(thickness: 1.5),
                // locations
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
        ));
  }
}
