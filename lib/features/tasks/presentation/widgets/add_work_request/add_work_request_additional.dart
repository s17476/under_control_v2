import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../core/presentation/widgets/custom_video_player.dart';
import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/utils/get_file_size.dart';
import '../../../../core/utils/show_snack_bar.dart';

class AddWorkRequestAdditional extends StatefulWidget {
  const AddWorkRequestAdditional({
    Key? key,
    required this.addImage,
    required this.removeImage,
    required this.toggleAddAdditionalVisibility,
    required this.images,
    required this.isAddAdditionalVisible,
    required this.loadingImages,
    this.videoFile,
    this.videoUrl,
    required this.updateVideo,
  }) : super(key: key);

  final Function(File) addImage;
  final Function(File) removeImage;
  final Function() toggleAddAdditionalVisibility;
  final List<File> images;
  final bool isAddAdditionalVisible;
  final bool loadingImages;
  final File? videoFile;
  final String? videoUrl;
  final Function(File?) updateVideo;

  @override
  State<AddWorkRequestAdditional> createState() =>
      _AddWorkRequestAdditionalState();
}

class _AddWorkRequestAdditionalState extends State<AddWorkRequestAdditional> {
  String _originalFileSize = '';
  String _compressedFileSize = '';
  int _videoCompressionProgress = 0;
  MediaInfo? _compressedFileInfo;
  bool _isCompressingVideoFile = false;

  void _pickImage(BuildContext context, ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        widget.addImage(File(pickedFile.path));
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!
            .user_profile_add_user_image_pisker_error,
      );
    }
  }

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

  List<SpeedDialChild> _addWorkRequestOverlayMenuItems(BuildContext context) {
    final List<SpeedDialChild> choices = [
      // video camera
      SpeedDialChild(
        label:
            '${AppLocalizations.of(context)!.content_video} - ${AppLocalizations.of(context)!.take_photo}',
        child: const Icon(Icons.camera),
        onTap: () {
          _pickVideo(context, ImageSource.camera);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // video gallery
      SpeedDialChild(
        label:
            '${AppLocalizations.of(context)!.content_video} - ${AppLocalizations.of(context)!.user_profile_add_user_personal_data_gallery}',
        child: const Icon(Icons.photo_size_select_actual_rounded),
        onTap: () {
          _pickVideo(context, ImageSource.gallery);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // images camera
      SpeedDialChild(
        label:
            '${AppLocalizations.of(context)!.content_image} - ${AppLocalizations.of(context)!.take_photo}',
        child: const Icon(Icons.camera),
        onTap: () {
          _pickImage(context, ImageSource.camera);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // images gallery
      SpeedDialChild(
        label:
            '${AppLocalizations.of(context)!.content_image} - ${AppLocalizations.of(context)!.user_profile_add_user_personal_data_gallery}',
        child: const Icon(Icons.photo_size_select_actual_rounded),
        onTap: () {
          _pickImage(context, ImageSource.gallery);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    ];
    return choices.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
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
                        AppLocalizations.of(context)!.additional,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // video
                                if (widget.videoFile != null ||
                                    widget.videoUrl != null ||
                                    _isCompressingVideoFile) ...[
                                  Text(
                                    AppLocalizations.of(context)!.content_video,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if ((widget.videoFile != null ||
                                          widget.videoUrl != null))
                                        Container(
                                          constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          child: CustomVideoPlayer(
                                            videoFile: widget.videoFile,
                                            videoUrl: widget.videoUrl,
                                          ),
                                        ),
                                      //
                                      if (_isCompressingVideoFile)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 16),
                                              alignment: Alignment.center,
                                              height: 170,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black
                                                    .withOpacity(0.7),
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .video_compressing),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (widget.videoFile != null)
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: IconButton(
                                            onPressed: () =>
                                                widget.updateVideo(null),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  // file size
                                  if (widget.videoFile != null)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        // original file size
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .size),
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
                                                AppLocalizations.of(context)!
                                                    .compressed_size,
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
                                                AppLocalizations.of(context)!
                                                    .video_size,
                                              ),
                                            ),
                                            Text(
                                                '${_compressedFileInfo!.width.toString()}x${_compressedFileInfo!.height.toString()}'),
                                          ],
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                ],
                                // images
                                if (widget.images.isNotEmpty) ...[
                                  ImagesGrigViev(
                                    images: widget.images,
                                    removeImage: widget.removeImage,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],

                                const SizedBox(
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 70,
          right: 16,
          child: SpeedDial(
            icon: Icons.add,
            iconTheme: const IconThemeData(size: 36),
            activeIcon: Icons.close,
            overlayOpacity: 0.85,
            spacing: 3,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            backgroundColor: Theme.of(context).primaryColor,
            buttonSize: const Size(50, 50),
            // renderOverlay: true,
            activeBackgroundColor: Colors.black,
            elevation: 8.0,
            animationCurve: Curves.elasticInOut,
            isOpenOnStart: false,
            children: _addWorkRequestOverlayMenuItems(context),
            childrenButtonSize: const Size(60, 60),
            childMargin: const EdgeInsets.only(right: 0),
            animationDuration: const Duration(milliseconds: 300),
          ),
        ),
        // Positioned(
        //   bottom: 58,
        //   right: 16,
        //   child: FloatingActionButton(
        //     backgroundColor: Theme.of(context).primaryColor,
        //     onPressed: widget.toggleAddAdditionalVisibility,
        //     child: const Icon(
        //       Icons.add,
        //       size: 40,
        //     ),
        //   ),
        // ),
        // if (widget.isAddAdditionalVisible)
        //   AddWorkRequestOverlayMenu(
        //     onDismiss: widget.toggleAddAdditionalVisibility,
        //     pickImage: _pickImage,
        //     pickVideo: _pickVideo,
        //   ),
      ],
    );
  }
}

class ImagesGrigViev extends StatelessWidget {
  const ImagesGrigViev({
    super.key,
    required this.images,
    required this.removeImage,
  });

  final List<File> images;
  final Function(File p1) removeImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.asset_add_images_added,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: images
              .map(
                (img) => InkWell(
                  key: ValueKey(img.path),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewer(
                          imageProvider: FileImage(img),
                          title: '',
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: img.path,
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: Image.file(
                            img,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                            onPressed: () => removeImage(img),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
