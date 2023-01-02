import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';

class AddTaskActionCard extends StatelessWidget {
  const AddTaskActionCard({
    Key? key,
    required this.isEditMode,
    required this.descriptionTextEditingController,
  }) : super(key: key);

  final bool isEditMode;
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
                          'assets/task_action.png',
                        ),
                      ),
                      // title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          isEditMode
                              ? AppLocalizations.of(context)!.task_action_edit
                              : AppLocalizations.of(context)!.task_action_new,
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline5!.fontSize,
                          ),
                        ),
                      ),

                      // description text field
                      CustomTextFormField(
                        fieldKey: 'description',
                        controller: descriptionTextEditingController,
                        keyboardType: TextInputType.multiline,
                        // maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: AppLocalizations.of(context)!.description,
                        scrollPadding: const EdgeInsets.only(bottom: 100),
                        validator: (value) {
                          if (value!.length < 2) {
                            return AppLocalizations.of(context)!
                                .validation_min_two_characters;
                          }
                          return null;
                        },
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
