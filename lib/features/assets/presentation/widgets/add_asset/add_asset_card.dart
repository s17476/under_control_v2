import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';

class AddAssetCard extends StatelessWidget {
  const AddAssetCard({
    Key? key,
    required this.isCopyMode,
    required this.isEditMode,
    required this.producerTextEditingController,
    required this.modelTextEditingController,
    required this.descriptionTextEditingController,
  }) : super(key: key);

  final bool isCopyMode;
  final bool isEditMode;
  final TextEditingController producerTextEditingController;
  final TextEditingController modelTextEditingController;
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
                      // image
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 48.0,
                          right: 48.0,
                          top: 16,
                        ),
                        child: Image.asset(
                          'assets/asset.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          isCopyMode
                              ? AppLocalizations.of(context)!.asset_copy
                              : isEditMode
                                  ? AppLocalizations.of(context)!.asset_edit
                                  : AppLocalizations.of(context)!.asset_add_new,
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
                        textCapitalization: TextCapitalization.sentences,
                        labelText: AppLocalizations.of(context)!.item_producer,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // model text field
                      CustomTextFormField(
                        scrollPadding: const EdgeInsets.all(170),
                        validator: (val) {
                          if (val!.length < 2) {
                            return AppLocalizations.of(context)!
                                .validation_min_two_characters;
                          }
                          return null;
                        },
                        fieldKey: 'model',
                        controller: modelTextEditingController,
                        textCapitalization: TextCapitalization.sentences,
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
                            AppLocalizations.of(context)!.description_optional,
                        scrollPadding: const EdgeInsets.only(bottom: 100),
                      ),

                      const SizedBox(
                        height: 8,
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
