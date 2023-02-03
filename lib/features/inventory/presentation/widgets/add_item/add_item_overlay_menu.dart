import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/overlay_menu/overlay_menu_item.dart';
import '../../../../core/utils/choice.dart';

class AddItemOverlayMenu extends StatelessWidget {
  const AddItemOverlayMenu({
    Key? key,
    required this.onDismiss,
    required this.toggleAddInstructionsVisibility,
    required this.pickPdfFile,
    required this.pickImage,
  }) : super(key: key);
  final Function() onDismiss;
  final Function() toggleAddInstructionsVisibility;
  final Function(BuildContext context) pickPdfFile;
  final Function(ImageSource souruce) pickImage;

  List<Choice> _addAssetsOverlayMenuItems(BuildContext context) {
    final List<Choice> choices = [
      // camera
      Choice(
        title: AppLocalizations.of(context)!.take_photo,
        icon: Icons.camera,
        onTap: () {
          pickImage(ImageSource.camera);
        },
      ),
      // gallery
      Choice(
        title: AppLocalizations.of(context)!
            .user_profile_add_user_personal_data_gallery,
        icon: Icons.photo_size_select_actual_rounded,
        onTap: () {
          pickImage(ImageSource.gallery);
        },
      ),
      // pdf
      Choice(
        title: AppLocalizations.of(context)!.asset_add_pdf,
        icon: FontAwesomeIcons.filePdf,
        onTap: () {
          pickPdfFile(context);
        },
      ),
      // instructions
      Choice(
        title: AppLocalizations.of(context)!.asset_add_instructions,
        icon: Icons.menu_book,
        onTap: toggleAddInstructionsVisibility,
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
