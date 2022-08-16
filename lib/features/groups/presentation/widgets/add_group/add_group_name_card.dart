import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';

class AddGroupNameCard extends StatelessWidget {
  const AddGroupNameCard({
    Key? key,
    required this.isEditMode,
    required this.pageController,
    required this.nameTexEditingController,
    required this.descriptionTexEditingController,
  }) : super(key: key);

  final bool isEditMode;
  final PageController pageController;
  final TextEditingController nameTexEditingController;
  final TextEditingController descriptionTexEditingController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // workgroup image
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 48.0,
                          right: 48.0,
                          top: 48,
                        ),
                        child: Image.asset(
                          'assets/workgroup.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          isEditMode
                              ? AppLocalizations.of(context)!
                                  .group_management_edit_card_title
                              : AppLocalizations.of(context)!
                                  .group_management_add_card_title,
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline5!.fontSize,
                          ),
                        ),
                      ),
                      // name text field
                      CustomTextFormField(
                        scrollPadding: const EdgeInsets.all(100),
                        validator: (val) {
                          if (val!.length < 2) {
                            return AppLocalizations.of(context)!
                                .validation_min_two_characters;
                          }
                          return null;
                        },
                        fieldKey: 'name',
                        controller: nameTexEditingController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        labelText: AppLocalizations.of(context)!
                            .group_management_add_card_name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // description text field
                      CustomTextFormField(
                        fieldKey: 'description',
                        controller: descriptionTexEditingController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: AppLocalizations.of(context)!
                            .group_management_add_card_description,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
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
                  icon: Icons.cancel,
                  color: Theme.of(context).textTheme.headline4!.color!,
                  label: AppLocalizations.of(context)!.cancel,
                  function: () => Navigator.pop(context),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
