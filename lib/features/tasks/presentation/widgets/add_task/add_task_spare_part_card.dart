import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/inventory_spare_parts_list_with_quantity.dart';

import '../../../../assets/presentation/widgets/asset_selection/overlay_asset_selection.dart';
import '../../../../assets/presentation/widgets/assets_spare_parts_list.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../../inventory/presentation/widgets/inventory_spare_parts_list.dart';

class AddTaskSparePartCard extends StatefulWidget {
  const AddTaskSparePartCard({
    Key? key,
    required this.toggleAssetSelection,
    required this.toggleItemSelection,
    required this.toggleAddAssetVisibility,
    required this.toggleAddItemVisibility,
    required this.sparePartsAssets,
    required this.sparePartsItems,
    required this.isAddAssetVisible,
    required this.isAddItemVisible,
  }) : super(key: key);

  final Function(String) toggleAssetSelection;
  final Function(SparePartItemModel) toggleItemSelection;
  final Function() toggleAddAssetVisibility;
  final Function() toggleAddItemVisibility;
  final List<String> sparePartsAssets;
  final List<SparePartItemModel> sparePartsItems;
  final bool isAddAssetVisible;
  final bool isAddItemVisible;

  @override
  State<AddTaskSparePartCard> createState() => _AddTaskSparePartCardState();
}

class _AddTaskSparePartCardState extends State<AddTaskSparePartCard>
    with ResponsiveSize {
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
                        AppLocalizations.of(context)!.asset_add_spare_parts,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // assets
                            AssetsSparePartsList(
                              items: widget.sparePartsAssets,
                              onSelected: widget.toggleAssetSelection,
                            ),
                            // // inventory
                            InventorySparePartsListWithQuantity(
                              items: widget.sparePartsItems,
                              onSelected: widget.toggleItemSelection,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // add spareparts from assets button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                        ),
                        onPressed: widget.toggleAddAssetVisibility,
                        icon: SizedBox(
                          height: 30,
                          width: 30,
                          child: Stack(
                            children: const [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Icon(
                                  Icons.precision_manufacturing,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        label: Text(
                          AppLocalizations.of(context)!
                              .asset_add_spare_parts_assets,
                        ),
                      ),
                    ),
                    // add spareparts from inventory button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade700,
                        ),
                        onPressed: widget.toggleAddItemVisibility,
                        icon: SizedBox(
                          height: 30,
                          width: 30,
                          child: Stack(
                            children: const [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Icon(
                                  Icons.apps,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        label: Text(
                          AppLocalizations.of(context)!
                              .asset_add_spare_parts_inventory,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.isAddAssetVisible)
          OverlayAssetSelection(
            spareParts: widget.sparePartsAssets,
            toggleSelection: widget.toggleAssetSelection,
            onDismiss: widget.toggleAddAssetVisibility,
          ),
        if (widget.isAddItemVisible)
          OverlayInventorySelection(
            spareParts: widget.sparePartsItems.map((e) => e.itemId).toList(),
            toggleSelection: (itemId) => widget.toggleItemSelection(
              SparePartItemModel(
                itemId: itemId,
                quantity: 0,
              ),
            ),
            onDismiss: widget.toggleAddItemVisibility,
          ),
      ],
    );
  }
}
