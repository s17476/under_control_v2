import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import 'package:under_control_v2/features/core/utils/get_file_size.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/custom_video_player.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../data/models/instruction_step_model.dart';
import '../../../domain/entities/instruction.dart';

class VideoStep extends StatefulWidget {
  const VideoStep({
    Key? key,
    required this.step,
    required this.instruction,
    required this.updateStep,
  }) : super(key: key);

  final InstructionStepModel step;
  final Instruction? instruction;

  final Function(InstructionStepModel) updateStep;

  @override
  State<VideoStep> createState() => _VideoStepState();
}

class _VideoStepState extends State<VideoStep> with ResponsiveSize {
  String _originalFileSize = '';
  String _compressedFileSize = '';
  int _videoCompressionProgress = 0;
  MediaInfo? _compressedFileInfo;
  bool _isCompressingVideoFile = false;
  String _cacheKey = '';

  // picks video from camera or gallery and compress it
  void _pickVideo(BuildContext context, ImageSource souruce) async {
    Subscription subscription;
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickVideo(
        source: souruce,
        maxDuration: const Duration(minutes: 2),
      );
      if (pickedFile != null) {
        _originalFileSize = getFileSize(pickedFile.path, 2);
        setState(() {
          _isCompressingVideoFile = true;
        });
        subscription = VideoCompress.compressProgress$.subscribe((progress) {
          setState(() {
            _videoCompressionProgress = progress.toInt();
          });
        });
        await VideoCompress.setLogLevel(0);
        final info = await VideoCompress.compressVideo(
          pickedFile.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true,
        );
        setState(() {
          _isCompressingVideoFile = false;
        });
        subscription.unsubscribe();
        _videoCompressionProgress = 0;
        _compressedFileSize = getFileSize(info!.file!.path, 2);
        _compressedFileInfo = info;
        // updates current step
        widget.updateStep(
          InstructionStepModel(
            id: widget.step.id,
            contentType: widget.step.contentType,
            contentUrl: widget.step.contentUrl,
            title: widget.step.title,
            description: widget.step.description,
            file: File(info.file!.path),
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
    if (widget.instruction != null) {
      _cacheKey = widget.instruction!
          .lastEdited[widget.instruction!.lastEdited.length - 1].dateTime
          .toIso8601String();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // video player
        Stack(
          alignment: Alignment.center,
          children: [
            if (widget.step.file != null || widget.step.contentUrl != null)
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.width,
                ),
                child: CustomVideoPlayer(
                  videoFile: widget.step.file,
                  videoUrl: widget.step.contentUrl,
                  cacheKey: _cacheKey,
                ),
              ),
            // placeholder image
            if (widget.step.file == null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Image.asset(
                  'assets/video.png',
                  fit: BoxFit.fill,
                ),
              ),
            //
            if (_isCompressingVideoFile)
              Container(
                alignment: Alignment.center,
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '${_videoCompressionProgress.toString()} %',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(AppLocalizations.of(context)!.video_compressing),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              // file size
              if (widget.step.file != null)
                Column(
                  children: [
                    // original file size
                    Row(
                      children: [
                        Expanded(
                          child: Text(AppLocalizations.of(context)!.size),
                        ),
                        Text(_originalFileSize),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // compressed file size
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.compressed_size,
                          ),
                        ),
                        Text(_compressedFileSize),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // compressed file size
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.video_size,
                          ),
                        ),
                        Text(
                            '${_compressedFileInfo!.width.toString()}x${_compressedFileInfo!.height.toString()}'),
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
                  if (widget.step.file != null)
                    OverlayIconButton(
                      onPressed: () => widget.updateStep(
                        InstructionStepModel(
                          id: widget.step.id,
                          contentType: widget.step.contentType,
                          contentUrl: widget.step.contentUrl,
                          title: widget.step.title,
                          description: widget.step.description,
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
                initialValue: widget.step.title,
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
                    widget.updateStep(
                      InstructionStepModel(
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
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 8,
                onChanged: (val) {
                  if (val!.trim().isNotEmpty) {
                    widget.updateStep(
                      InstructionStepModel(
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
