import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/utils/feature_type_helpers.dart';
import '../../../data/models/feature_model.dart';

class GroupManagementFeatureCard extends StatelessWidget {
  const GroupManagementFeatureCard({
    Key? key,
    required this.feature,
  }) : super(key: key);

  final FeatureModel feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: IconTitleRow(
                    icon: getIcon(feature),
                    iconColor: Colors.white,
                    iconBackground: getColor(feature),
                    title: getTitle(context, feature),
                    titleFontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // read icon
                    Icon(
                      Icons.visibility,
                      color: feature.read
                          ? Colors.grey.shade200
                          : Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // create icon
                    Icon(
                      Icons.add,
                      color: feature.create
                          ? Colors.grey.shade200
                          : Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // edit icon
                    Icon(
                      Icons.edit,
                      color: feature.edit
                          ? Colors.grey.shade200
                          : Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // delete icon
                    Icon(
                      Icons.delete,
                      color: feature.delete
                          ? Colors.grey.shade200
                          : Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
