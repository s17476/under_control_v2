import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../data/models/feature_model.dart';
import 'feature_summary_card.dart';

class AddGroupSummaryCard extends StatelessWidget {
  const AddGroupSummaryCard({
    Key? key,
    required this.pageController,
    required this.nameTexEditingController,
    required this.descriptionTexEditingController,
    required this.features,
    required this.totalSelectedLocations,
  }) : super(key: key);

  final PageController pageController;
  final TextEditingController nameTexEditingController;
  final TextEditingController descriptionTexEditingController;
  final List<FeatureModel> features;
  final List<String> totalSelectedLocations;

  @override
  Widget build(BuildContext context) {
    bool isAtLeastOneFeatureSelected = false;
    for (var feature in features) {
      if (feature.create || feature.delete || feature.edit || feature.read) {
        isAtLeastOneFeatureSelected = true;
      }
    }
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.of(context)!.summary,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    // name
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .group_management_add_card_name,
                      validator: () =>
                          nameTexEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(nameTexEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // optional description
                    if (descriptionTexEditingController.text.isNotEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .group_management_add_card_description,
                        validator: () => null,
                        child:
                            Text(descriptionTexEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 0,
                      ),

                    const SizedBox(
                      height: 8,
                    ),

                    // locations
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .group_management_add_card_selected_locations,
                      validator: () => totalSelectedLocations.isEmpty
                          ? AppLocalizations.of(context)!
                              .group_management_add_error_no_location_selected
                          : null,
                      child: Text(
                        totalSelectedLocations.length.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // premissions
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .group_management_add_card_permissions,
                      validator: () => !isAtLeastOneFeatureSelected
                          ? AppLocalizations.of(context)!
                              .group_management_add_error_no_premission_selected
                          : null,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: features.length,
                        itemBuilder: (context, index) =>
                            FeatureSummaryCard(feature: features[index]),
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 2,
                    ),
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
