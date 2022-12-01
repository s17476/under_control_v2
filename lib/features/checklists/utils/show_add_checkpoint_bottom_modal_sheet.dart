import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/presentation/widgets/custom_text_form_field.dart';
import '../data/models/checkpoint_model.dart';

Future<void> showAddCheckpointModalBottomSheet({
  required BuildContext context,
  CheckpointModel? currentCheckpoint,
  required Function(
          CheckpointModel? oldCheckpoint, CheckpointModel newCheckpoint)
      onSave,
}) {
  final GlobalKey<FormState> formKey = GlobalKey();

  CheckpointModel checkpoint = currentCheckpoint ??
      const CheckpointModel(
        title: '',
        isChecked: false,
      );

  return showModalBottomSheet<void>(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 4,
                ),
                child: Text(
                  //
                  //
                  AppLocalizations.of(context)!.checklist_add_checkpoint,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              // parent name
                              CustomTextFormField(
                                autofocus: true,
                                fieldKey: 'title',
                                labelText: AppLocalizations.of(context)!
                                    .checklist_checkpoint_title,
                                initialValue: checkpoint.title,
                                prefixIcon:
                                    const Icon(Icons.check_circle_outline),
                                validator: (value) {
                                  if (value!.trim().isEmpty ||
                                      value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .validation_min_two_characters;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  checkpoint = CheckpointModel(
                                    title: value!.trim(),
                                    isChecked: false,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          currentCheckpoint != null
                              ? AppLocalizations.of(context)!.update
                              : AppLocalizations.of(context)!.add,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          formKey.currentState!.save();

                          onSave(currentCheckpoint, checkpoint);

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
