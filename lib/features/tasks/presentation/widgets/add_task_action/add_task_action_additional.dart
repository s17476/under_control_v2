import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../add_task/item_tile_with_quantity.dart';
import 'add_task_action_overlay_menu.dart';

class AddTaskActionAdditional extends StatelessWidget {
  const AddTaskActionAdditional({
    Key? key,
    required this.addImage,
    required this.removeImage,
    required this.images,
    required this.loadingImages,
    required this.toggleAddAssetVisibility,
    required this.toggleAssetSelection,
    required this.toggleReplacementAsset,
    required this.sparePartsAssets,
    required this.isAddAssetVisible,
    required this.isConnectedAssetReplaced,
    required this.replacementAsset,
    required this.addItem,
    required this.removeItem,
    required this.updateSparePartQuantity,
    required this.sparePartsItems,
    required this.isAddItemVisible,
    required this.toggleAddItemVisibility,
    required this.replaceConnectedAssets,
    required this.toggleRemovedAssets,
    required this.assetsToRemove,
    required this.connectedAssetId,
    required this.replacedAsset,
    required this.isAddAdditionalVisible,
    required this.toggleAddAdditionalVisibility,
    required this.isConnectedToAnAsset,
  }) : super(key: key);

  // images
  final Function(File) addImage;
  final Function(File) removeImage;
  final List<File> images;
  final bool loadingImages;

  // add spare parts from assets
  final Function() toggleAddAssetVisibility;
  final Function(String) toggleAssetSelection;
  final Function(AssetModel?) toggleReplacementAsset;
  final List<String> sparePartsAssets;
  final bool isAddAssetVisible;
  final bool isConnectedAssetReplaced;
  final AssetModel? replacementAsset;

  // add spare parts from inventory
  final Function(SparePartItemModel) addItem;
  final Function(SparePartItemModel) removeItem;
  final Function(SparePartItemModel) updateSparePartQuantity;
  final List<SparePartItemModel> sparePartsItems;
  final bool isAddItemVisible;
  final Function() toggleAddItemVisibility;

  // remove broken assets
  final Function(AssetModel) replaceConnectedAssets;
  final Function(AssetModel) toggleRemovedAssets;
  final List<AssetModel> assetsToRemove;
  final String connectedAssetId;
  final AssetModel? replacedAsset;

  // overlay menu
  final bool isAddAdditionalVisible;
  final Function() toggleAddAdditionalVisibility;

  final bool isConnectedToAnAsset;

  void _pickImage(BuildContext context, ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        addImage(File(pickedFile.path));
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!
            .user_profile_add_user_image_pisker_error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
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
                        AppLocalizations.of(context)!.additional,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              children: [
                                // images
                                if (images.isNotEmpty) ...[
                                  ImagesGrigViev(
                                    images: images,
                                    removeImage: removeImage,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                                // used items
                                if (sparePartsItems.isNotEmpty) ...[
                                  SparePartsItems(
                                    sparePartsItems: sparePartsItems,
                                    removeItem: removeItem,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],

                                const SizedBox(
                                  height: 150,
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
            ],
          ),
        ),
        Positioned(
          bottom: 58,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: toggleAddAdditionalVisibility,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
        if (isAddAdditionalVisible)
          AddTaskActionOverlayMenu(
            onDismiss: toggleAddAdditionalVisibility,
            pickImage: _pickImage,
            toggleAddAssetVisibility: toggleAddAssetVisibility,
            toggleAddItemVisibility: toggleAddItemVisibility,
          ),
        if (isAddItemVisible)
          OverlayInventorySelection(
            isMultiselection: true,
            spareParts: sparePartsItems.map((e) => e.itemId).toList(),
            toggleSelection: (itemId) => addItem(
              SparePartItemModel(
                itemId: itemId,
                locationId: '',
                quantity: 0,
              ),
            ),
            onDismiss: toggleAddItemVisibility,
          ),
      ],
    );
  }
}

class ImagesGrigViev extends StatelessWidget {
  const ImagesGrigViev({
    super.key,
    required this.images,
    required this.removeImage,
  });

  final List<File> images;
  final Function(File p1) removeImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.asset_add_images_added,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: images
              .map(
                (img) => InkWell(
                  key: ValueKey(img.path),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewer(
                          imageProvider: FileImage(img),
                          title: '',
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: img.path,
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: Image.file(
                            img,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                            onPressed: () => removeImage(img),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class SparePartsItems extends StatelessWidget {
  const SparePartsItems({
    Key? key,
    required this.sparePartsItems,
    required this.removeItem,
  }) : super(key: key);

  final List<SparePartItemModel> sparePartsItems;
  final Function(SparePartItemModel) removeItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoadedState) {
          final usedItems = sparePartsItems.map((usedItem) {
            final item = state.getItemById(usedItem.itemId);
            if (item != null) {
              return ItemTileWithQuantity(
                item: item,
                sparePartItemModel: usedItem,
                searchQuery: '',
                onSelected: removeItem,
                margin: const EdgeInsets.symmetric(vertical: 4),
              );
            }
            return const SizedBox();
          });
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.task_action_used_items,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              ...usedItems,
            ],
          );
        }
        return const LoadingWidget();
      },
    );
  }
}
