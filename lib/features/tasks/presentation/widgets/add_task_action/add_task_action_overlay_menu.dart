import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/overlay_menu/overlay_menu_item.dart';
import '../../../../core/utils/choice.dart';

class AddTaskActionOverlayMenu extends StatelessWidget {
  const AddTaskActionOverlayMenu({
    Key? key,
    required this.onDismiss,
    required this.toggleAddAssetVisibility,
    required this.toggleAddItemVisibility,
    required this.pickImage,
  }) : super(key: key);

  final Function() onDismiss;
  final Function() toggleAddAssetVisibility;
  final Function() toggleAddItemVisibility;
  final Function(BuildContext context, ImageSource souruce) pickImage;

  List<Choice> _addTaskActionOverlayMenuItems(BuildContext context) {
    final List<Choice> choices = [
      // camera
      Choice(
        title: AppLocalizations.of(context)!.take_photo,
        icon: Icons.camera,
        onTap: () {
          pickImage(context, ImageSource.camera);
        },
      ),
      // gallery
      Choice(
        title: AppLocalizations.of(context)!
            .user_profile_add_user_personal_data_gallery,
        icon: Icons.photo_size_select_actual_rounded,
        onTap: () {
          pickImage(context, ImageSource.gallery);
        },
      ),

      // inventory
      Choice(
        title: AppLocalizations.of(context)!.task_action_used_items,
        icon: Icons.apps,
        onTap: toggleAddItemVisibility,
      ),
      // // assets
      // Choice(
      //   title: AppLocalizations.of(context)!.bottom_bar_title_assets,
      //   icon: Icons.precision_manufacturing,
      //   onTap: toggleAddAssetVisibility,
      // ),
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
            ..._addTaskActionOverlayMenuItems(context)
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
