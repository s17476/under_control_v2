import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../data/models/feature_model.dart';

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
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
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
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize,
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
                            child: TextFormField(
                              enabled: false,
                              validator: (val) {
                                if (val!.length < 2) {
                                  return AppLocalizations.of(context)!
                                      .add_company_intro_card_to_short;
                                }
                                return null;
                              },
                              controller: nameTexEditingController,
                              decoration: InputDecoration(
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
                          // optional description
                          if (descriptionTexEditingController.text.isNotEmpty)
                            InkWell(
                              onTap: () async => pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
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
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
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
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            totalSelectedLocations.length.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
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
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            isAtLeastOneFeatureSelected.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // bottom navigation
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
          ),
        ),
      ),
    );
  }
}
