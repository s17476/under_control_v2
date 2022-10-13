import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/cached_pdf_viewer.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/presentation/widgets/pdf_viewer.dart';
import '../../../../core/utils/get_file_size.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/size_config.dart';
import '../../../data/models/instruction_step_model.dart';

class PdfStep extends StatelessWidget with ResponsiveSize {
  const PdfStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStepModel step;

  final Function(InstructionStepModel) updateStep;

  void _pickPdfFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (step.file != null) {
        updateStep(
          InstructionStepModel(
            id: step.id,
            contentType: step.contentType,
            contentUrl: step.contentUrl,
            title: step.title,
            description: step.description,
            file: null,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 300));
      }
      updateStep(
        InstructionStepModel(
          id: step.id,
          contentType: step.contentType,
          contentUrl: step.contentUrl,
          title: step.title,
          description: step.description,
          file: file,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // image
          Stack(
            children: [
              if (step.file == null &&
                  (step.contentUrl == null || step.contentUrl!.isEmpty))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/pdf.png',
                    fit: BoxFit.fill,
                  ),
                ),
              if (step.file != null)
                SizedBox(
                  width: responsiveSizePct(small: 75),
                  height: responsiveSizePct(small: 100),
                  child: PdfViewer(path: step.file!.path),
                ),
              if (step.file == null &&
                  step.contentUrl != null &&
                  step.contentUrl!.isNotEmpty)
                SizedBox(
                  width: responsiveSizePct(small: 75),
                  height: responsiveSizePct(small: 100),
                  child: CachedPdfViewer(pdfUrl: step.contentUrl!),
                ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          // file size
          if (step.file != null)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(AppLocalizations.of(context)!.size)),
                    Text(getFileSize(step.file!.path, 2)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (step.file != null)
                OverlayIconButton(
                  onPressed: () => updateStep(
                    InstructionStepModel(
                      id: step.id,
                      contentType: step.contentType,
                      contentUrl: step.contentUrl,
                      title: step.title,
                      description: step.description,
                      file: null,
                    ),
                  ),
                  icon: Icons.clear,
                  title: AppLocalizations.of(context)!.reset_pdf,
                ),
              OverlayIconButton(
                onPressed: () => _pickPdfFile(context),
                icon: FontAwesomeIcons.filePdf,
                title: AppLocalizations.of(context)!.content_pdf,
              ),
            ],
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
    );
  }
}
