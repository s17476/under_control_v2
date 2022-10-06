import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/url_preview.dart';
import '../../../domain/entities/instruction_step.dart';
import '../../../utils/steps_validation.dart';

class UrlStep extends StatelessWidget {
  const UrlStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStep step;

  final Function(InstructionStep) updateStep;

  void _setUrl(String url) async {
    if (url != step.contentUrl && url.isNotEmpty) {
      updateStep(
        InstructionStep(
          id: step.id,
          contentType: step.contentType,
          contentUrl: url,
          title: step.title,
          description: step.description,
          file: step.file,
        ),
      );
    } else if (url.isEmpty) {
      updateStep(
        InstructionStep(
          id: step.id,
          contentType: step.contentType,
          contentUrl: null,
          title: step.title,
          description: step.description,
          file: step.file,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // url preview
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Stack(
            children: [
              // placeholder image
              if (step.contentUrl == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/website.png',
                    fit: BoxFit.fill,
                  ),
                ),
              if (step.contentUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: FutureBuilder(
                          future: getPreviewData(step.contentUrl ?? ''),
                          builder: (context, snapshot) {
                            return Stack(
                              children: [
                                // preview loaded
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    step.contentUrl != null &&
                                    (snapshot.data as PreviewData).title !=
                                        null)
                                  UrlPreview(url: step.contentUrl!),
                                // preview loading
                                if (snapshot.connectionState !=
                                    ConnectionState.done)
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                // page not found
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    step.contentUrl != null &&
                                    (snapshot.data as PreviewData).title ==
                                        null)
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .content_url_404,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),

              // www link
              CustomTextFormField(
                initialValue: step.contentUrl,
                fieldKey: 'www-link',
                labelText: AppLocalizations.of(context)!.content_url_paste_here,
                keyboardType: TextInputType.url,
                textCapitalization: TextCapitalization.none,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppLocalizations.of(context)!.content_url_not_added;
                  } else if (!urlValidation(step.contentUrl!)) {
                    return AppLocalizations.of(context)!.content_url_404;
                  }
                  return null;
                },
                onChanged: (val) {
                  if (val != null) {
                    _setUrl(val.trim());
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
                      InstructionStep(
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
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 8,
                onChanged: (val) {
                  if (val!.trim().isNotEmpty) {
                    updateStep(
                      InstructionStep(
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
