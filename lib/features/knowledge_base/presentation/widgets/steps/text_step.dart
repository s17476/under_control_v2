import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';

import '../../../data/models/instruction_step_model.dart';
import '../../../domain/entities/instruction_step.dart';

class TextStep extends StatelessWidget {
  const TextStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStep step;

  final Function(InstructionStep) updateStep;

  @override
  Widget build(BuildContext context) {
    print('step');
    print(step);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            // header
            CustomTextFormField(
              initialValue: step.title,
              fieldKey: 'header',
              labelText: AppLocalizations.of(context)!.header,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.sentences,
              validator: (val) {
                if (val!.length < 2) {
                  return AppLocalizations.of(context)!
                      .validation_min_two_characters;
                }
                return null;
              },
              onChanged: (val) {
                if (val!.trim().isNotEmpty) {
                  updateStep(
                    (step as InstructionStepModel).copyWith(
                      title: val.trim(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            // description
            CustomTextFormField(
              initialValue: step.description,
              fieldKey: 'description',
              labelText: AppLocalizations.of(context)!.description,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 12,
              validator: (val) {
                if (val!.length < 2) {
                  return AppLocalizations.of(context)!
                      .validation_min_two_characters;
                }
                return null;
              },
              onChanged: (val) {
                if (val!.trim().isNotEmpty) {
                  updateStep(
                    (step as InstructionStepModel).copyWith(
                      description: val.trim(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
