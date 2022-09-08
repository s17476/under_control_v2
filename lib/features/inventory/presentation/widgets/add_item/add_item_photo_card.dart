import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddItemPhotoCard extends StatefulWidget {
  const AddItemPhotoCard({
    Key? key,
    required this.pageController,
    this.image,
    this.imageUrl,
    required this.setImage,
    required this.deleteImage,
  }) : super(key: key);

  final PageController pageController;

  final File? image;

  final String? imageUrl;

  final Function(
    ImageSource souruce,
  ) setImage;

  final Function() deleteImage;

  @override
  State<AddItemPhotoCard> createState() => _AddItemPhotoCardState();
}

class _AddItemPhotoCardState extends State<AddItemPhotoCard>
    with ResponsiveSize {
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
                      if (widget.imageUrl != null)
                        SizedBox(
                          width: responsiveSizePct(small: 100),
                          height: responsiveSizePct(small: 100),
                          child: CachedNetworkImage(
                            imageUrl: widget.imageUrl!,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (widget.image != null)
                        SizedBox(
                          width: responsiveSizePct(small: 100),
                          height: responsiveSizePct(small: 100),
                          child: Image.file(
                            widget.image!,
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
                        onPressed: () => widget.setImage(ImageSource.camera),
                        icon: Icons.camera,
                        title: AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_take_photo_btn,
                      ),
                      // reset image button
                      if (widget.image != null)
                        OverlayIconButton(
                          onPressed: () => widget.deleteImage(),
                          icon: Icons.cancel,
                          title: AppLocalizations.of(context)!.reset_image,
                        ),
                      // gallery button
                      OverlayIconButton(
                        onPressed: () => widget.setImage(ImageSource.gallery),
                        icon: Icons.photo_size_select_actual_rounded,
                        title: AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_gallery,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.arrow_back_ios_new,
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  function: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
