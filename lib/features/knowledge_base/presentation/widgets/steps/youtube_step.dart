import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/custom_youtube_player.dart';
import '../../../../core/utils/extract_youtube_id.dart';
import '../../../data/models/instruction_step_model.dart';

class YoutubeStep extends StatelessWidget {
  const YoutubeStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStepModel step;

  final Function(InstructionStepModel) updateStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (step.contentUrl != null)
          CustomYoutubePlayer(
            contentUrl: step.contentUrl!,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              // placeholder image
              if (step.contentUrl == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/youtube.png',
                    fit: BoxFit.fill,
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              // youtube link
              CustomTextFormField(
                initialValue: step.contentUrl,
                fieldKey: 'youtube-link',
                labelText:
                    AppLocalizations.of(context)!.content_youtube_paste_here,
                textCapitalization: TextCapitalization.none,
                validator: (val) {
                  if (val!.length < 2) {
                    return AppLocalizations.of(context)!
                        .validation_min_two_characters;
                  }
                  return null;
                },
                onChanged: (val) {
                  if (val!.trim().isNotEmpty) {
                    final result = extractYoutubeId(val.trim());
                    if (result.isNotEmpty) {
                      updateStep(
                        InstructionStepModel(
                          id: step.id,
                          contentType: step.contentType,
                          contentUrl: result,
                          description: step.description,
                          file: step.file,
                          title: step.title,
                        ),
                      );
                    }
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              // header
              CustomTextFormField(
                initialValue: step.title,
                fieldKey: 'header',
                labelText: AppLocalizations.of(context)!.header,
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
                      InstructionStepModel(
                        id: step.id,
                        contentType: step.contentType,
                        contentUrl: step.contentUrl,
                        description: step.description,
                        file: step.file,
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
                labelText: AppLocalizations.of(context)!.description_optional,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 8,
                onChanged: (val) {
                  if (val!.trim().isNotEmpty) {
                    updateStep(
                      InstructionStepModel(
                        id: step.id,
                        contentType: step.contentType,
                        contentUrl: step.contentUrl,
                        description: val.trim(),
                        file: step.file,
                        title: step.title,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
