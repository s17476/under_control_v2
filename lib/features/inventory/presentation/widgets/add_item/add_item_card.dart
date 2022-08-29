import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import 'category_dropdown_button.dart';
import 'item_unit_dropdown_button.dart';

class AddItemCard extends StatelessWidget {
  const AddItemCard({
    Key? key,
    required this.isEditMode,
    required this.pageController,
    required this.nameTexEditingController,
    required this.descriptionTexEditingController,
    required this.setCategory,
    required this.setItemUnit,
    required this.category,
    required this.itemUnit,
  }) : super(key: key);

  final bool isEditMode;
  final PageController pageController;
  final TextEditingController nameTexEditingController;
  final TextEditingController descriptionTexEditingController;
  final Function(String category) setCategory;
  final Function(String category) setItemUnit;
  final String category;
  final String itemUnit;

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
                          top: 16,
                        ),
                        child: Image.asset(
                          'assets/new_item.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          isEditMode
                              ? AppLocalizations.of(context)!
                                  .item_edit_card_title
                              : AppLocalizations.of(context)!
                                  .item_add_card_title,
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
                        labelText: AppLocalizations.of(context)!.item_name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // description text field
                      CustomTextFormField(
                        fieldKey: 'description',
                        controller: descriptionTexEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textCapitalization: TextCapitalization.sentences,
                        labelText:
                            AppLocalizations.of(context)!.item_description,
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      // category selection
                      CategoryDropdownButton(
                        selectedValue: category,
                        onSelected: setCategory,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ItemUnitDropdownButton(
                        selectedUnit: itemUnit,
                        onSelected: setItemUnit,
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
