import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../checklists/utils/show_add_checkpoint_bottom_modal_sheet.dart';
import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/overlay_menu/overlay_menu_item.dart';
import '../../../../core/utils/choice.dart';

class AddTaskOverlayMenu extends StatelessWidget {
  const AddTaskOverlayMenu({
    Key? key,
    required this.onDismiss,
    required this.pickImage,
    required this.pickVideo,
    required this.toggleAddInstructionsVisibility,
    required this.toggleAddAssetVisibility,
    required this.toggleAddItemVisibility,
    required this.toggleAddChecklistVisibility,
    required this.addCheckpoint,
  }) : super(key: key);

  final Function() onDismiss;
  final Function(BuildContext context, ImageSource souruce) pickImage;
  final Function(BuildContext context, ImageSource souruce) pickVideo;
  final Function() toggleAddInstructionsVisibility;
  final Function() toggleAddAssetVisibility;
  final Function() toggleAddItemVisibility;
  final Function() toggleAddChecklistVisibility;
  final Function(
    CheckpointModel? oldCheckpoint,
    CheckpointModel newCheckpoint,
  ) addCheckpoint;

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
      // instructions
      Choice(
        title: AppLocalizations.of(context)!.asset_add_instructions,
        icon: Icons.menu_book,
        onTap: toggleAddInstructionsVisibility,
      ),
      // inventory
      Choice(
        title: AppLocalizations.of(context)!.bottom_bar_title_inventory,
        icon: Icons.apps,
        onTap: toggleAddItemVisibility,
      ),
      // assets
      Choice(
        title: AppLocalizations.of(context)!.bottom_bar_title_assets,
        icon: Icons.precision_manufacturing,
        onTap: toggleAddAssetVisibility,
      ),
      // checklist
      Choice(
        title: AppLocalizations.of(context)!.checklist_add_button,
        icon: Icons.checklist,
        onTap: toggleAddChecklistVisibility,
      ),
      // checkpoint
      Choice(
        title: AppLocalizations.of(context)!.checklist_add_checkpoint,
        icon: Icons.done,
        onTap: () => showAddCheckpointModalBottomSheet(
          context: context,
          onSave: addCheckpoint,
        ),
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
