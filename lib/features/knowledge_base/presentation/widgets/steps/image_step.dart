import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/get_file_size.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../domain/entities/instruction_step.dart';

class ImageStep extends StatelessWidget with ResponsiveSize {
  const ImageStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStepModel step;

  final Function(InstructionStepModel) updateStep;

  void _setImage(BuildContext context, ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        updateStep(
          InstructionStepModel(
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
    SizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          // image
          Stack(
            children: [
              if (step.file == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/photo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              if (step.contentUrl != null)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewer(
                          imageProvider:
                              CachedNetworkImageProvider(step.contentUrl!),
                          heroTag: step.contentUrl!,
                          title: '',
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: responsiveSizePct(small: 100),
                    height: responsiveSizePct(small: 100),
                    child: CachedNetworkImage(
                      imageUrl: step.contentUrl!,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (step.file != null)
                SizedBox(
                  width: responsiveSizePct(small: 100),
                  height: responsiveSizePct(small: 100),
                  child: Image.file(
                    step.file!,
                    fit: BoxFit.fitWidth,
                  ),
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
              // camera button
              OverlayIconButton(
                onPressed: () => _setImage(context, ImageSource.camera),
                icon: Icons.camera,
                title: AppLocalizations.of(context)!
                    .user_profile_add_user_personal_data_take_photo_btn,
              ),
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
                  title: AppLocalizations.of(context)!.reset_image,
                ),
              OverlayIconButton(
                onPressed: () => _setImage(context, ImageSource.gallery),
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
            keyboardType: TextInputType.name,
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
