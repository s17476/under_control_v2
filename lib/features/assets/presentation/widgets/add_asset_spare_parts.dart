import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../inventory/presentation/widgets/inventory_spare_parts_list.dart';
import 'asset_selection/overlay_asset_selection.dart';
import 'assets_spare_parts_list.dart';

class AddAssetSparePartCard extends StatefulWidget {
  const AddAssetSparePartCard({
    Key? key,
    required this.toggleSelection,
    required this.toggleAddAssetVisibility,
    required this.toggleAddInventoryVisibility,
    required this.spareParts,
    required this.isAddAssetVisible,
    required this.isAddInventoryVisible,
  }) : super(key: key);

  final Function(String) toggleSelection;
  final Function() toggleAddAssetVisibility;
  final Function() toggleAddInventoryVisibility;
  final List<String> spareParts;
  final bool isAddAssetVisible;
  final bool isAddInventoryVisible;

  @override
  State<AddAssetSparePartCard> createState() => _AddAssetSparePartCardState();
}

class _AddAssetSparePartCardState extends State<AddAssetSparePartCard>
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
                              items: widget.spareParts,
                              onSelected: widget.toggleSelection,
                            ),
                            // inventory
                            InventorySparePartsList(
                              items: widget.spareParts,
                              onSelected: widget.toggleSelection,
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
                        onPressed: widget.toggleAddInventoryVisibility,
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
            spareParts: widget.spareParts,
            toggleSelection: widget.toggleSelection,
            onDismiss: widget.toggleAddInventoryVisibility,
          ),
        if (widget.isAddInventoryVisible)
          OverlayInventorySelection(
            spareParts: widget.spareParts,
            toggleSelection: widget.toggleSelection,
            onDismiss: widget.toggleAddInventoryVisibility,
          ),
      ],
    );
  }
}
