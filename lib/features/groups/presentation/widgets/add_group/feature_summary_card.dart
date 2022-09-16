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
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                // title
                Text(
                  getTitle(context, feature),
                  style: const TextStyle(fontSize: 16),
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
                  style: getActiveStyle(feature.read),
                ),
                Text(
                  AppLocalizations.of(context)!.create,
                  style: getActiveStyle(feature.create),
                ),
                Text(
                  AppLocalizations.of(context)!.edit,
                  style: getActiveStyle(feature.edit),
                ),
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: getActiveStyle(feature.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
