import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    required this.toggleRemoveAssetVisibility,
    required this.pickImage,
    required this.isConnectedToAnAsset,
    required this.showOnlySubAssets,
  }) : super(key: key);

  final Function() onDismiss;
  final Function() toggleAddAssetVisibility;
  final Function() toggleAddItemVisibility;
  final Function() toggleRemoveAssetVisibility;
  final Function(BuildContext context, ImageSource souruce) pickImage;
  final bool isConnectedToAnAsset;
  final ValueNotifier<bool> showOnlySubAssets;

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
      // assets
      if (isConnectedToAnAsset)
        Choice(
          title: AppLocalizations.of(context)!.task_action_add_assets,
          icon: Icons.precision_manufacturing,
          onTap: () {
            showOnlySubAssets.value = true;
            toggleAddAssetVisibility();
          },
        ),
      // remove broken assets
      if (isConnectedToAnAsset)
        Choice(
          title: AppLocalizations.of(context)!.task_action_remove_assets,
          icon: Icons.clear,
          onTap: () => toggleRemoveAssetVisibility(),
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
