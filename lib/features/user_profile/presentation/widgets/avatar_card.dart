import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({
    Key? key,
    this.image,
    required this.setAvatar,
  }) : super(key: key);

  final File? image;

  final Function(
    ImageSource souruce,
  ) setAvatar;

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> with ResponsiveSize {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: responsiveSizeVerticalPct(
                                  small: 12, medium: 5),
                            ),
                            // avatar
                            SizedBox(
                              height: responsiveSizePct(small: 70, medium: 20),
                              width: responsiveSizePct(small: 70, medium: 20),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // shows avatar background only in portrait mode
                                  if (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                    Image.asset(
                                      'assets/undercontrol-without-frame.png',
                                      fit: BoxFit.fill,
                                    ),
                                  CircleAvatar(
                                    radius: responsiveSizePct(small: 22.5),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  CircleAvatar(
                                    radius: responsiveSizePct(
                                        small: 22, medium: 15),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    backgroundImage: widget.image != null
                                        ? FileImage(widget.image!)
                                        : null,
                                    child: widget.image == null
                                        ? Text(
                                            '?',
                                            style: TextStyle(
                                              fontSize: responsiveSizePct(
                                                  small: 20, medium: 10),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: responsiveSizePct(small: 15, medium: 3),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                widget.setAvatar(ImageSource.camera);
                              },
                              icon: const Icon(Icons.camera),
                              label: Text(
                                AppLocalizations.of(context)!
                                    .user_profile_add_user_personal_data_take_photo_btn,
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      responsiveSizePx(small: double.infinity),
                                      40)),
                            ),
                            SizedBox(
                              height: responsiveSizePx(small: 16, medium: 4),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                widget.setAvatar(ImageSource.gallery);
                              },
                              icon: const Icon(
                                Icons.photo_size_select_actual_rounded,
                              ),
                              label: Text(
                                AppLocalizations.of(context)!
                                    .user_profile_add_user_personal_data_gallery,
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      responsiveSizePx(small: double.infinity),
                                      40)),
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
        ),
      ),
    );
  }
}
