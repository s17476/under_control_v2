import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';
import '../../../core/presentation/widgets/summary_card.dart';
import '../../data/models/checkpoint_model.dart';

class AddChecklistSummaryCard extends StatelessWidget {
  const AddChecklistSummaryCard({
    Key? key,
    required this.pageController,
    required this.titleTexEditingController,
    required this.descriptionTexEditingController,
    required this.checkpoints,
    required this.addNewChecklist,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController titleTexEditingController;
  final TextEditingController descriptionTexEditingController;

  final List<CheckpointModel> checkpoints;

  final Function(BuildContext context) addNewChecklist;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
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
                    // checklist name
                    SummaryCard(
                      title: AppLocalizations.of(context)!.checklist_name,
                      validator: () =>
                          titleTexEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(titleTexEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // optional description
                    if (descriptionTexEditingController.text.isNotEmpty)
                      SummaryCard(
                        title:
                            AppLocalizations.of(context)!.checklist_description,
                        validator: () => null,
                        child:
                            Text(descriptionTexEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 0,
                      ),

                    const SizedBox(
                      height: 8,
                    ),

                    // checkpoints
                    SummaryCard(
                      title:
                          '${AppLocalizations.of(context)!.checklist_add_checkpoints_title}: ${checkpoints.length}',
                      validator: () => checkpoints.isEmpty
                          ? AppLocalizations.of(context)!
                              .checklist_add_checkpoints_empty
                          : null,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: checkpoints.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_outline),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    checkpoints[index].title,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),
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
                      addNewChecklist(context);
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
