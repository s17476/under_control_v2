import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';

class AddItemCard extends StatelessWidget {
  const AddItemCard({
    Key? key,
    required this.isEditMode,
    required this.producerTextEditingController,
    required this.nameTextEditingController,
    required this.descriptionTextEditingController,
  }) : super(key: key);

  final bool isEditMode;
  final TextEditingController producerTextEditingController;
  final TextEditingController nameTextEditingController;
  final TextEditingController descriptionTextEditingController;

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
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                          ),
                        ),
                      ),
                      // producer text field
                      CustomTextFormField(
                        scrollPadding: const EdgeInsets.all(170),
                        validator: (val) {
                          if (val!.length < 2) {
                            return AppLocalizations.of(context)!
                                .validation_min_two_characters;
                          }
                          return null;
                        },
                        fieldKey: 'producer',
                        controller: producerTextEditingController,
                        textCapitalization: TextCapitalization.words,
                        labelText: AppLocalizations.of(context)!.item_producer,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // name text field
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
                        controller: nameTextEditingController,
                        textCapitalization: TextCapitalization.words,
                        labelText: AppLocalizations.of(context)!.item_name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // description text field
                      CustomTextFormField(
                        fieldKey: 'description',
                        controller: descriptionTextEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        labelText:
                            AppLocalizations.of(context)!.item_description,
                        scrollPadding: const EdgeInsets.only(bottom: 100),
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
