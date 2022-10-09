import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddItemPhotoCard extends StatelessWidget with ResponsiveSize {
  const AddItemPhotoCard({
    Key? key,
    this.image,
    this.imageUrl,
    required this.setImage,
    required this.deleteImage,
  }) : super(key: key);

  final File? image;

  final String? imageUrl;

  final Function(
    ImageSource souruce,
  ) setImage;

  final Function() deleteImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                      AppLocalizations.of(context)!.item_photo,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/photo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      if (imageUrl != null)
                        SizedBox(
                          width: responsiveSizePct(small: 100),
                          height: responsiveSizePct(small: 100),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (image != null)
                        SizedBox(
                          width: responsiveSizePct(small: 100),
                          height: responsiveSizePct(small: 100),
                          child: Image.file(
                            image!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // camera button
                      OverlayIconButton(
                        onPressed: () => setImage(ImageSource.camera),
                        icon: Icons.camera,
                        title: AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_take_photo_btn,
                      ),
                      // reset image button
                      if (image != null)
                        OverlayIconButton(
                          onPressed: () => deleteImage(),
                          icon: Icons.cancel,
                          title: AppLocalizations.of(context)!.reset_image,
                        ),
                      // gallery button
                      OverlayIconButton(
                        onPressed: () => setImage(ImageSource.gallery),
                        icon: Icons.photo_size_select_actual_rounded,
                        title: AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_gallery,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
