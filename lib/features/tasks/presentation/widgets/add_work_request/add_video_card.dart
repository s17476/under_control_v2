import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../core/presentation/widgets/custom_video_player.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/get_file_size.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';

class AddVideoCard extends StatefulWidget {
  const AddVideoCard({
    Key? key,
    required this.videoFile,
    required this.videoUrl,
    required this.updateVideo,
  }) : super(key: key);

  final File? videoFile;
  final String? videoUrl;
  final Function(File?) updateVideo;

  @override
  State<AddVideoCard> createState() => _AddVideoCardState();
}

class _AddVideoCardState extends State<AddVideoCard> with ResponsiveSize {
  String _originalFileSize = '';
  String _compressedFileSize = '';
  int _videoCompressionProgress = 0;
  MediaInfo? _compressedFileInfo;
  bool _isCompressingVideoFile = false;

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
        widget.updateVideo(File(info.file!.path));
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
    return SafeArea(
      child: Column(
        children: [
          // title
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: 8,
              right: 8,
            ),
            child: Text(
              AppLocalizations.of(context)!.task_add_video,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          // video player
          SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if ((widget.videoFile != null || widget.videoUrl != null))
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width,
                    ),
                    child: CustomVideoPlayer(
                      videoFile: widget.videoFile,
                      videoUrl: widget.videoUrl,
                    ),
                  ),
                // placeholder image
                if (widget.videoFile == null &&
                    (widget.videoUrl == null || widget.videoUrl!.isEmpty))
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
                if (widget.videoFile != null)
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
                    // reset
                    if (widget.videoFile != null)
                      OverlayIconButton(
                        onPressed: () => widget.updateVideo(null),
                        icon: Icons.clear,
                        title: AppLocalizations.of(context)!.reset_video,
                      ),
                    // gallery
                    OverlayIconButton(
                      onPressed: () => _pickVideo(context, ImageSource.gallery),
                      icon: Icons.photo_size_select_actual_rounded,
                      title: AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_gallery,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
