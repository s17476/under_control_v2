import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../domain/entities/instruction_step.dart';

class VideoStep extends StatefulWidget {
  const VideoStep({
    Key? key,
    required this.step,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStep step;

  final Function(InstructionStep) updateStep;

  @override
  State<VideoStep> createState() => _VideoStepState();
}

class _VideoStepState extends State<VideoStep> with ResponsiveSize {
  VideoPlayerController? _videoController;

  void _setVideo(BuildContext context, ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickVideo(
        source: souruce,
        maxDuration: const Duration(minutes: 2),
      );
      if (pickedFile != null) {
        widget.updateStep(
          InstructionStep(
            id: widget.step.id,
            contentType: widget.step.contentType,
            contentUrl: widget.step.contentUrl,
            title: widget.step.title,
            description: widget.step.description,
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
  void initState() {
    _videoController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      children: [
        Stack(
          children: [
            // player
            if (_videoController != null &&
                _videoController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),

            // button
            if (_videoController != null &&
                _videoController!.value.isInitialized)
              FloatingActionButton(
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    // If the video is playing, pause it.
                    if (_videoController!.value.isPlaying) {
                      _videoController!.pause();
                    } else {
                      // If the video is paused, play it.
                      _videoController!.play();
                    }
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(
                  _videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              ),

            // progress bar
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: VideoProgressIndicator(
                _videoController!,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  backgroundColor: Colors.blueGrey,
                  bufferedColor: Colors.blueGrey,
                  playedColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // camera button
                  OverlayIconButton(
                    onPressed: () => _setVideo(context, ImageSource.camera),
                    icon: Icons.camera,
                    title: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_take_photo_btn,
                  ),
                  OverlayIconButton(
                    onPressed: () => _setVideo(context, ImageSource.gallery),
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
                initialValue: widget.step.title,
                fieldKey: 'header',
                labelText: AppLocalizations.of(context)!.header_optional,
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
                    widget.updateStep(
                      InstructionStep(
                        id: widget.step.id,
                        contentType: widget.step.contentType,
                        contentUrl: widget.step.contentUrl,
                        description: widget.step.description,
                        file: widget.step.file,
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
                initialValue: widget.step.description,
                fieldKey: 'description',
                labelText: AppLocalizations.of(context)!.description_optional,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 8,
                validator: (val) {
                  if (val!.length < 2) {
                    return AppLocalizations.of(context)!
                        .validation_min_two_characters;
                  }
                  return null;
                },
                onChanged: (val) {
                  if (val!.trim().isNotEmpty) {
                    widget.updateStep(
                      InstructionStep(
                        id: widget.step.id,
                        contentType: widget.step.contentType,
                        contentUrl: widget.step.contentUrl,
                        description: val.trim(),
                        file: widget.step.file,
                        title: widget.step.title,
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
