import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_selection/overlay_asset_selection.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../assets/utils/show_spare_part_asset_delete_dialog.dart';
import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../add_task/item_tile_with_quantity.dart';
import 'add_task_action_overlay_menu.dart';
import 'add_task_action_remove_asset_card.dart';
import 'add_task_action_remove_assets_overlay.dart';

class AddTaskActionAdditional extends HookWidget {
  const AddTaskActionAdditional({
    Key? key,
    required this.addImage,
    required this.removeImage,
    required this.images,
    required this.loadingImages,
    required this.toggleAssetSelection,
    required this.toggleReplacementAsset,
    required this.sparePartsAssets,
    required this.toggleAddAssetVisibility,
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
    required this.toggleRemoveAssetVisibility,
    required this.isRemoveAssetVisible,
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
  final Function(String) toggleAssetSelection;
  final Function(AssetModel?) toggleReplacementAsset;
  final List<String> sparePartsAssets;
  final Function() toggleAddAssetVisibility;
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
  final Function() toggleRemoveAssetVisibility;
  final bool isRemoveAssetVisible;

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

  void toggleAsset(BuildContext context, String assetId) {
    if (replacementAsset != null) {
      toggleReplacementAsset(null);
    } else {
      final assetState = context.read<AssetBloc>().state;
      if (assetState is AssetLoadedState) {
        final asset = assetState.getAssetById(assetId);
        if (asset != null) {
          final assetModel = AssetModel.fromAsset(asset);
          toggleReplacementAsset(assetModel);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showOnlySubAssets = useState(true);
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
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                ],
                                // assets
                                ...[
                                  SparePartsAssets(
                                    isConnectedAssetReplaced:
                                        isConnectedAssetReplaced,
                                    toggleAsset: toggleAsset,
                                    showOnlySubAssets: showOnlySubAssets,
                                    toggleAddAssetVisibility:
                                        toggleAddAssetVisibility,
                                    sparePartsAssets: sparePartsAssets,
                                    toggleAssetSelection: toggleAssetSelection,
                                    replacementAsset: replacementAsset,
                                    connectedAssetId: connectedAssetId,
                                    replaceConnectedAssets:
                                        replaceConnectedAssets,
                                    replacedAsset: replacedAsset,
                                    assetsToRemove: assetsToRemove,
                                    toggleRemovedAssets: toggleRemovedAssets,
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
            isConnectedToAnAsset: isConnectedToAnAsset,
            showOnlySubAssets: showOnlySubAssets,
            toggleRemoveAssetVisibility: toggleRemoveAssetVisibility,
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
        if (isRemoveAssetVisible)
          AddTaskActionRemoveAssetOverlay(
            assetsToRemove: assetsToRemove,
            connectedAssetId: connectedAssetId,
            onDismiss: toggleRemoveAssetVisibility,
            replaceConnectedAssets: replaceConnectedAssets,
            toggleRemovedAssets: toggleRemovedAssets,
            replacedAsset: replacedAsset,
          ),
        if (isAddAssetVisible)
          OverlayAssetSelection(
            spareParts: replacementAsset != null
                ? [...sparePartsAssets, replacementAsset!.id]
                : sparePartsAssets,
            toggleSelection: showOnlySubAssets.value
                ? (assetId) {
                    if (replacementAsset != null &&
                        replacementAsset!.id == assetId) {
                      showSnackBar(
                        context: context,
                        message: AppLocalizations.of(context)!
                            .task_action_asset_already_in_use_err_msg,
                        isErrorMessage: true,
                      );
                    } else {
                      toggleAssetSelection(assetId);
                    }
                  }
                : (assetId) {
                    if (sparePartsAssets.contains(assetId)) {
                      showSnackBar(
                        context: context,
                        message: AppLocalizations.of(context)!
                            .task_action_asset_already_in_use_err_msg,
                        isErrorMessage: true,
                      );
                    } else {
                      toggleAsset(context, assetId);
                      toggleAddAssetVisibility();
                    }
                  },
            onDismiss: toggleAddAssetVisibility,
            allUnusedAssets: !showOnlySubAssets.value,
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

class SparePartsAssets extends StatelessWidget {
  const SparePartsAssets({
    Key? key,
    required this.isConnectedAssetReplaced,
    this.replacementAsset,
    required this.toggleAsset,
    required this.showOnlySubAssets,
    required this.toggleAddAssetVisibility,
    required this.sparePartsAssets,
    required this.toggleAssetSelection,
    required this.connectedAssetId,
    this.replacedAsset,
    required this.replaceConnectedAssets,
    required this.toggleRemovedAssets,
    required this.assetsToRemove,
  }) : super(key: key);

  final bool isConnectedAssetReplaced;
  final AssetModel? replacementAsset;
  final Function(BuildContext, String) toggleAsset;
  final ValueNotifier<bool> showOnlySubAssets;
  final Function() toggleAddAssetVisibility;
  final List<String> sparePartsAssets;
  final Function(String) toggleAssetSelection;
  final String connectedAssetId;
  final AssetModel? replacedAsset;
  final Function(AssetModel) replaceConnectedAssets;
  final Function(AssetModel) toggleRemovedAssets;
  final List<AssetModel> assetsToRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isConnectedAssetReplaced) ...[
          Text(
            AppLocalizations.of(context)!.task_connected_asset,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          BlocBuilder<AssetBloc, AssetState>(
            builder: (context, state) {
              if (state is AssetLoadedState) {
                final asset = state.getAssetById(connectedAssetId);

                return AssetToRemoveTile(
                  asset: AssetModel.fromAsset(asset!),
                  toggleRemovedAssets: replaceConnectedAssets,
                  isRemoved: replacedAsset != null,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                );
              } else {
                return const ShimmerItemTile();
              }
            },
          ),
          if (replacementAsset != null)
            AssetTile(
              asset: replacementAsset!,
              searchQuery: '',
              onSelected: (assetId) => toggleAsset(context, assetId),
              isSelected: true,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
          if (replacementAsset == null)
            AddReplacementAssetButton(
              showOnlySubAssets: showOnlySubAssets,
              toggleAddAssetVisibility: toggleAddAssetVisibility,
            ),
        ],
        // removed assets
        if (assetsToRemove.isNotEmpty) ...[
          Text(
            AppLocalizations.of(context)!.asset_removed,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          ...assetsToRemove.map((asset) => AssetToRemoveTile(
                asset: AssetModel.fromAsset(asset),
                toggleRemovedAssets: toggleRemovedAssets,
                isRemoved: true,
                margin: const EdgeInsets.symmetric(vertical: 4),
              )),
        ],

        // added assets
        SparePartsAssetsList(
          items: sparePartsAssets,
          onSelected: toggleAssetSelection,
        ),
      ],
    );
  }
}

class AddReplacementAssetButton extends StatelessWidget {
  const AddReplacementAssetButton({
    Key? key,
    required this.showOnlySubAssets,
    required this.toggleAddAssetVisibility,
  }) : super(key: key);

  final ValueNotifier<bool> showOnlySubAssets;
  final Function() toggleAddAssetVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              showOnlySubAssets.value = false;
              toggleAddAssetVisibility();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 36,
                    color: Theme.of(context).highlightColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .task_action_add_replacement_asset,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SparePartsAssetsList extends StatelessWidget {
  const SparePartsAssetsList({
    Key? key,
    required this.items,
    this.onSelected,
    this.padding,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final List<String> items;
  final Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (items.isNotEmpty)
          BlocBuilder<AssetBloc, AssetState>(
            builder: (context, state) {
              if (state is AssetLoadedState) {
                if (state.allAssets.allAssets.isEmpty) {
                  return Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        AppLocalizations.of(context)!.item_no_items,
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  );
                }
                final filteredAssets = state.allAssets.allAssets
                    .where(
                      (asset) => items.contains(asset.id),
                    )
                    .toList();
                if (filteredAssets.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.task_action_add_assets,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredAssets.length,
                        itemBuilder: (context, index) {
                          return AssetTile(
                            asset: filteredAssets[index],
                            searchQuery: '',
                            onSelected: onSelected != null
                                ? (assetId) => showSparePartAssetDeleteDialog(
                                      context: context,
                                      asset: filteredAssets[index],
                                      onDelete: () => onSelected!(assetId),
                                    )
                                : null,
                            isSelected: true,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox();
              } else {
                // loading shimmer animation
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 2),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const ShimmerItemTile();
                  },
                );
              }
            },
          ),
      ],
    );
  }
}
