import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/size_config.dart';

class AvatarCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        // avatar
                        Padding(
                          padding: EdgeInsets.only(
                            left: 48.0,
                            right: 48.0,
                            top: ResponsiveValue(
                              context,
                              defaultValue: 48,
                              valueWhen: [
                                const Condition.largerThan(
                                  name: TABLET,
                                  value: 16,
                                ),
                              ],
                            ).value!.toDouble(),
                          ),
                          child: CircleAvatar(
                            radius: 200,
                            backgroundColor: Theme.of(context).cardColor,
                            backgroundImage: image != null
                                ? (kIsWeb
                                    ? NetworkImage(image!.path)
                                    : FileImage(image!)) as ImageProvider
                                : null,
                            child: image == null
                                ? Text(
                                    '?',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .color,
                                      fontSize: 100,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (!kIsWeb)
                          ElevatedButton.icon(
                            onPressed: () {
                              setAvatar(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera),
                            label: Text(
                              AppLocalizations.of(context)!
                                  .user_profile_add_user_personal_data_take_photo_btn,
                            ),
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setAvatar(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.photo_size_select_actual_rounded,
                          ),
                          label: kIsWeb
                              ? Text(AppLocalizations.of(context)!.pick_image)
                              : Text(
                                  AppLocalizations.of(context)!
                                      .user_profile_add_user_personal_data_gallery,
                                ),
                        ),
                        const SizedBox(
                          height: kIsWeb ? 170 : 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
