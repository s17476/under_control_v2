import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../utils/show_add_instruction_category_modal_bottom_sheet.dart';
import 'instruction_category_dropdown_button.dart';

class AddInstructionCard extends StatelessWidget {
  const AddInstructionCard({
    Key? key,
    required this.isEditMode,
    required this.titleTexEditingController,
    required this.descriptionTexEditingController,
    required this.setCategory,
    required this.category,
  }) : super(key: key);

  final bool isEditMode;
  final TextEditingController titleTexEditingController;
  final TextEditingController descriptionTexEditingController;
  final Function(String category) setCategory;
  final String category;

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
                      // image
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 48.0,
                          right: 48.0,
                          top: 16,
                        ),
                        child: Image.asset(
                          'assets/instruction.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          isEditMode
                              ? AppLocalizations.of(context)!.instruction_edit
                              : AppLocalizations.of(context)!
                                  .instruction_add_title,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                          ),
                        ),
                      ),
                      // title text field
                      CustomTextFormField(
                        scrollPadding: const EdgeInsets.all(170),
                        validator: (val) {
                          if (val!.length < 2) {
                            return AppLocalizations.of(context)!
                                .validation_min_two_characters;
                          }
                          return null;
                        },
                        fieldKey: 'name',
                        controller: titleTexEditingController,
                        // keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: AppLocalizations.of(context)!.title,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // description text field
                      CustomTextFormField(
                        fieldKey: 'description',
                        controller: descriptionTexEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        labelText:
                            AppLocalizations.of(context)!.description_optional,
                        scrollPadding: const EdgeInsets.only(bottom: 100),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      // category selection
                      Row(
                        children: [
                          Expanded(
                            child: InstructionCategoryDropdownButton(
                              selectedValue: category,
                              onSelected: setCategory,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: RoundedButton(
                              iconSize: 30,
                              padding: const EdgeInsets.all(9),
                              onPressed: () =>
                                  showAddInstructionCategoryModalBottomSheet(
                                context: context,
                              ),
                              icon: Icons.add,
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withAlpha(60),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
