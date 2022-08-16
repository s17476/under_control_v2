import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../data/models/feature_model.dart';
import 'feature_card.dart';

class AddGroupFeaturesCard extends StatelessWidget {
  const AddGroupFeaturesCard({
    Key? key,
    required this.pageController,
    required this.features,
  }) : super(key: key);

  final PageController pageController;

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
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.of(context)!
                            .group_management_add_card_permissions,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    // features cards
                    for (var feature in features) FeatureCard(feature: feature)
                  ],
                ),
              ),
            ),
            // bottom navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackwardTextButton(
                    icon: Icons.arrow_back_ios_new,
                    color: Theme.of(context).textTheme.headline5!.color!,
                    label: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_back,
                    function: () => pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                  ForwardTextButton(
                    color: Theme.of(context).textTheme.headline5!.color!,
                    label: AppLocalizations.of(context)!
                        .user_profile_add_user_next,
                    function: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    icon: Icons.arrow_forward_ios_outlined,
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
