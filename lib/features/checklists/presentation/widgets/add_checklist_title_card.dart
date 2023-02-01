import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/custom_text_form_field.dart';

class AddChecklistTitleCard extends StatelessWidget {
  const AddChecklistTitleCard({
    Key? key,
    required this.isEditMode,
    required this.titleTexEditingController,
    required this.descriptionTexEditingController,
  }) : super(key: key);

  final bool isEditMode;
  final TextEditingController titleTexEditingController;
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
                          'assets/check-list.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          isEditMode
                              ? AppLocalizations.of(context)!
                                  .checklist_edit_card_title
                              : AppLocalizations.of(context)!
                                  .checklist_add_card_title,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
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
                        fieldKey: 'title',
                        controller: titleTexEditingController,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: AppLocalizations.of(context)!.checklist_name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // description text field
                      CustomTextFormField(
                        fieldKey: 'description',
                        controller: descriptionTexEditingController,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        labelText:
                            AppLocalizations.of(context)!.checklist_description,
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
