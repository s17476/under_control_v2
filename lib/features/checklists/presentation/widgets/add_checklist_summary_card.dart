import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';

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
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    // title
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
                              controller: titleTexEditingController,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(color: Colors.red),
                                labelText: AppLocalizations.of(context)!
                                    .checklist_name,
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                  color:
                                      titleTexEditingController.text.length < 2
                                          ? Colors.red
                                          : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          titleTexEditingController.text.length < 2
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
                                      .checklist_description,
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
                    // checkpoints
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
                              '${AppLocalizations.of(context)!.checklist_add_checkpoints_title}: ${checkpoints.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: checkpoints.isEmpty
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                            ),
                          ),
                          checkpoints.isEmpty
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
                    ListView.builder(
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
