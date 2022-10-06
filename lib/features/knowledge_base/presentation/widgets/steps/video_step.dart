import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:under_control_v2/features/core/utils/get_file_size.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/custom_video_player.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../domain/entities/instruction_step.dart';

class VideoStep extends StatelessWidget {
  const VideoStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStep step;

  final Function(InstructionStep) updateStep;

  // picks video from camera or gallery
  void _pickVideo(BuildContext context, ImageSource souruce) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickVideo(
        source: souruce,
        maxDuration: const Duration(minutes: 2),
      );
      // updates current step
      if (pickedFile != null) {
        updateStep(
          InstructionStep(
            id: step.id,
            contentType: step.contentType,
            contentUrl: step.contentUrl,
            title: step.title,
            description: step.description,
            file: File(pickedFile.path),
          ),
        );
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!
            .user_profile_add_user_image_pisker_error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // video player
        if (step.file != null || step.contentUrl != null)
          CustomVideoPlayer(
            videoFile: step.file,
            videoUrl: step.contentUrl,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              // placeholder image
              if (step.file == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/video.png',
                    fit: BoxFit.fill,
                  ),
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
                        Expanded(
                            child: Text(AppLocalizations.of(context)!.size)),
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
                  // camera button
                  OverlayIconButton(
                    onPressed: () => _pickVideo(context, ImageSource.camera),
                    icon: Icons.camera,
                    title: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_take_photo_btn,
                  ),
                  if (step.file != null)
                    OverlayIconButton(
                      onPressed: () => updateStep(
                        InstructionStep(
                          id: step.id,
                          contentType: step.contentType,
                          contentUrl: step.contentUrl,
                          title: step.title,
                          description: step.description,
                          file: null,
                        ),
                      ),
                      icon: Icons.clear,
                      title: AppLocalizations.of(context)!.reset_video,
                    ),
                  OverlayIconButton(
                    onPressed: () => _pickVideo(context, ImageSource.gallery),
                    icon: Icons.photo_size_select_actual_rounded,
                    title: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_gallery,
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
