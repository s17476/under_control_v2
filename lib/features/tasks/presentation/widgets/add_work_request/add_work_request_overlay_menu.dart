import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/overlay_menu/overlay_menu_item.dart';
import '../../../../core/utils/choice.dart';

class AddWorkRequestOverlayMenu extends StatelessWidget {
  const AddWorkRequestOverlayMenu({
    Key? key,
    required this.onDismiss,
    required this.pickImage,
    required this.pickVideo,
  }) : super(key: key);

  final Function() onDismiss;
  final Function(BuildContext context, ImageSource souruce) pickImage;
  final Function(BuildContext context, ImageSource souruce) pickVideo;

  List<Choice> _addAssetsOverlayMenuItems(BuildContext context) {
    final List<Choice> choices = [
      // video camera
      Choice(
        title:
            '${AppLocalizations.of(context)!.content_video} - ${AppLocalizations.of(context)!.take_photo}',
        icon: Icons.camera,
        onTap: () {
          pickVideo(context, ImageSource.camera);
        },
      ),
      // video gallery
      Choice(
        title:
            '${AppLocalizations.of(context)!.content_video} - ${AppLocalizations.of(context)!.user_profile_add_user_personal_data_gallery}',
        icon: Icons.photo_size_select_actual_rounded,
        onTap: () {
          pickVideo(context, ImageSource.gallery);
        },
      ),
      // images camera
      Choice(
        title:
            '${AppLocalizations.of(context)!.content_image} - ${AppLocalizations.of(context)!.take_photo}',
        icon: Icons.camera,
        onTap: () {
          pickImage(context, ImageSource.camera);
        },
      ),
      // images gallery
      Choice(
        title:
            '${AppLocalizations.of(context)!.content_image} - ${AppLocalizations.of(context)!.user_profile_add_user_personal_data_gallery}',
        icon: Icons.photo_size_select_actual_rounded,
        onTap: () {
          pickImage(context, ImageSource.gallery);
        },
      ),
    ];
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return GlassLayer(
      onDismiss: onDismiss,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._addAssetsOverlayMenuItems(context)
                .map(
                  (chice) => OverlayMenuItem(
                    choice: chice,
                    onDissmis: onDismiss,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
