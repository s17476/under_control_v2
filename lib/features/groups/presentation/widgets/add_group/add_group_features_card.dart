import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/models/feature_model.dart';
import 'feature_card.dart';

class AddGroupFeaturesCard extends StatelessWidget {
  const AddGroupFeaturesCard({
    Key? key,
    required this.features,
  }) : super(key: key);

  final List<FeatureModel> features;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          // vertical: 4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // title
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .group_management_add_card_permissions,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    // features cards
                    for (var feature in features) FeatureCard(feature: feature),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
