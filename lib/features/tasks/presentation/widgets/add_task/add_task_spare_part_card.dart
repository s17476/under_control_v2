import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../assets/presentation/widgets/asset_selection/overlay_asset_selection.dart';
import '../../../../assets/presentation/widgets/assets_spare_parts_list.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import 'inventory_spare_parts_list_with_quantity.dart';

class AddTaskSparePartCard extends StatefulWidget {
  const AddTaskSparePartCard({
    Key? key,
    required this.toggleAssetSelection,
    required this.toggleItemSelection,
    required this.updateSparePartQuantity,
    required this.toggleAddAssetVisibility,
    required this.toggleAddItemVisibility,
    required this.sparePartsAssets,
    required this.sparePartsItems,
    required this.isAddAssetVisible,
    required this.isAddItemVisible,
  }) : super(key: key);

  final Function(String) toggleAssetSelection;
  final Function(SparePartItemModel) toggleItemSelection;
  final Function(String, double) updateSparePartQuantity;
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
    with ResponsiveSize, WidgetsBindingObserver {
  // bool _isVisible = true;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeMetrics() {
  //   final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
  //   final newValue = bottomInset == 0.0;
  //   if (newValue != _isVisible) {
  //     setState(() {
  //       _isVisible = newValue;
  //     });
  //   }
  //   if (_isVisible && mounted) {
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

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
                              updateSparePartQuantity:
                                  widget.updateSparePartQuantity,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
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
          child: FloatingActionButton.extended(
            backgroundColor: Colors.orange.shade700,
            onPressed: widget.toggleAddItemVisibility,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.apps,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.bottom_bar_title_inventory,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 58,
          left: 16,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            onPressed: widget.toggleAddAssetVisibility,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.precision_manufacturing,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.bottom_bar_title_assets,
                ),
              ],
            ),
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
                locationId: '',
                quantity: 0,
              ),
            ),
            onDismiss: widget.toggleAddItemVisibility,
          ),
      ],
    );
  }
}
