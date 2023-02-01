import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';

class AddTaskTemplateCard extends StatelessWidget {
  const AddTaskTemplateCard({
    Key? key,
    required this.isEditMode,
    required this.isTemplate,
    required this.titleTextEditingController,
    required this.descriptionTextEditingController,
  }) : super(key: key);

  final bool isEditMode;
  final bool isTemplate;
  final TextEditingController titleTextEditingController;
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
                          'assets/task.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          !isTemplate
                              ? AppLocalizations.of(context)!.task_templates_use
                              : isEditMode
                                  ? AppLocalizations.of(context)!
                                      .task_templates_edit
                                  : AppLocalizations.of(context)!
                                      .task_templates_add,
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
                        fieldKey: 'title',
                        controller: titleTextEditingController,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: AppLocalizations.of(context)!.title,
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
