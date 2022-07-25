import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/feature_type_helpers.dart';
import '../../../data/models/feature_model.dart';

class FeatureSummaryCard extends StatelessWidget {
  const FeatureSummaryCard({
    Key? key,
    required this.feature,
  }) : super(key: key);

  final FeatureModel feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                // icon
                Icon(
                  getIcon(feature),
                  size: 20,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(
                  width: 8,
                ),
                // title
                Text(
                  getTitle(context, feature),
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context)!.read,
                  style: TextStyle(
                    color: feature.read
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.create,
                  style: TextStyle(
                    color: feature.create
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.edit,
                  style: TextStyle(
                    color: feature.edit
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(
                    color: feature.delete
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
