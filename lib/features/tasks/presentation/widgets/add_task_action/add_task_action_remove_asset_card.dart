import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../add_task/item_tile_with_quantity.dart';

class AddTaskActionRemoveAssetCard extends StatefulWidget {
  const AddTaskActionRemoveAssetCard({
    Key? key,
    required this.addItem,
    required this.removeItem,
    required this.updateSparePartQuantity,
    required this.sparePartsItems,
    required this.toggleAddItemVisibility,
    required this.isAddItemVisible,
  }) : super(key: key);

  final Function(SparePartItemModel) addItem;
  final Function(SparePartItemModel) removeItem;
  final Function(SparePartItemModel) updateSparePartQuantity;
  final List<SparePartItemModel> sparePartsItems;
  final Function() toggleAddItemVisibility;
  final bool isAddItemVisible;

  @override
  State<AddTaskActionRemoveAssetCard> createState() =>
      _AddTaskActionRemoveAssetCardState();
}

class _AddTaskActionRemoveAssetCardState
    extends State<AddTaskActionRemoveAssetCard>
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
  //     // FocusScope.of(context).unfocus();
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
                      child: BlocBuilder<ItemsBloc, ItemsState>(
                        builder: (context, state) {
                          if (state is ItemsLoadedState) {
                            return ListView.builder(
                              itemCount: widget.sparePartsItems.length,
                              itemBuilder: (context, index) {
                                final item = state.getItemById(
                                    widget.sparePartsItems[index].itemId);
                                if (item != null) {
                                  return ItemTileWithQuantity(
                                    item: item,
                                    sparePartItemModel:
                                        widget.sparePartsItems[index],
                                    searchQuery: '',
                                    onSelected: widget.removeItem,
                                  );
                                }
                                return const SizedBox();
                              },
                            );
                          }
                          return const LoadingWidget();
                        },
                      ),
                      //     SingleChildScrollView(
                      //   child: InventorySparePartsListWithQuantity(
                      //     items: widget.sparePartsItems,
                      //     onSelected: widget.removeItem,
                      //   ),
                      // ),
                    ),

                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        // height: _isVisible ? null : 0,
                        child: Column(
                          children: [
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.isAddItemVisible)
          OverlayInventorySelection(
            isMultiselection: true,
            spareParts: widget.sparePartsItems.map((e) => e.itemId).toList(),
            toggleSelection: (itemId) => widget.addItem(
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
