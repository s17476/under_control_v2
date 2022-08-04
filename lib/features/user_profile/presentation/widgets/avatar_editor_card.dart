import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';

import '../../domain/entities/user_profile.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';

class AvatarEditorCard extends StatefulWidget {
  const AvatarEditorCard({
    Key? key,
    required this.user,
    required this.onDismiss,
  }) : super(key: key);

  final UserProfile user;
  final VoidCallback onDismiss;

  @override
  State<AvatarEditorCard> createState() => _AvatarEditorCardState();
}

class _AvatarEditorCardState extends State<AvatarEditorCard>
    with ResponsiveSize {
  File? userAvatar;

  void setAvatar(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 500,
        maxWidth: 500,
      );
      if (pickedFile != null) {
        setState(() {
          userAvatar = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!
                  .user_profile_add_user_image_pisker_error,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Stack(children: [
      InkWell(
        onTap: () => widget.onDismiss(),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0.0, end: 0.5),
          builder: (context, double value, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(value),
              ),
            );
          },
        ),
      ),
      TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: Center(
          child: Container(
            width: responsiveSizePct(small: 80),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // avatar
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    // indexed stack
                    child: IndexedStack(
                      index: userAvatar == null ? 0 : 1,
                      children: [
                        // original avatar
                        CachedUserAvatar(
                          size: responsiveSizePct(small: 70),
                          imageUrl: widget.user.avatarUrl,
                        ),
                        // updated avatar
                        CircleAvatar(
                          radius: responsiveSizePct(
                            small: 35,
                          ),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: userAvatar != null
                              ? FileImage(userAvatar!)
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  // camera button
                  TextButton.icon(
                    onPressed: () => setAvatar(ImageSource.camera),
                    icon: const Icon(Icons.camera),
                    label: Text(
                      AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_take_photo_btn,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // gallery button
                  TextButton.icon(
                    onPressed: () => setAvatar(ImageSource.gallery),
                    icon: const Icon(Icons.photo_size_select_actual_rounded),
                    label: Text(
                      AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_gallery,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        onPressed: () => widget.onDismiss(),
                      ),
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!
                              .user_profile_add_user_personal_data_save,
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                        onPressed: () {
                          context.read<UserManagementBloc>().add(
                                UpdateUserAvatarEvent(
                                  userProfile: widget.user,
                                  avatar: userAvatar,
                                ),
                              );
                          widget.onDismiss();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
