import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
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
    required this.addNewGroup,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController nameTexEditingController;
  final TextEditingController descriptionTexEditingController;

  final List<FeatureModel> features;

  final List<String> totalSelectedLocations;

  final Function(BuildContext context) addNewGroup;

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
                    InkWell(
                      onTap: () async => pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              validator: (val) {
                                if (val!.length < 2) {
                                  return AppLocalizations.of(context)!
                                      .validation_min_two_characters;
                                }
                                return null;
                              },
                              controller: nameTexEditingController,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(color: Colors.red),
                                labelText: AppLocalizations.of(context)!
                                    .group_management_add_card_name,
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                  color:
                                      nameTexEditingController.text.length < 2
                                          ? Colors.red
                                          : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          nameTexEditingController.text.length < 2
                              ? const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.done,
                                  color: Colors.grey.shade100,
                                ),
                        ],
                      ),
                    ),
                    // optional description
                    if (descriptionTexEditingController.text.isNotEmpty)
                      InkWell(
                        onTap: () async => pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                controller: descriptionTexEditingController,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .group_management_add_card_description,
                                  border: InputBorder.none,
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.done,
                              color: Colors.grey.shade100,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    // locations
                    InkWell(
                      onTap: () => pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .group_management_add_card_selected_locations,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: totalSelectedLocations.isEmpty
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                            ),
                          ),
                          totalSelectedLocations.isEmpty
                              ? const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.done,
                                  color: Colors.grey.shade100,
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () => pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Text(
                        totalSelectedLocations.length.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // premissions
                    InkWell(
                      onTap: () => pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .group_management_add_card_permissions,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: !isAtLeastOneFeatureSelected
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                            ),
                          ),
                          !isAtLeastOneFeatureSelected
                              ? const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.done,
                                  color: Colors.grey.shade100,
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),

                    for (var feature in features)
                      InkWell(
                        onTap: () => pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: FeatureSummaryCard(feature: feature),
                      )
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
                        .user_profile_add_user_personal_data_save,
                    function: () {
                      addNewGroup(context);
                    },
                    icon: Icons.save,
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
