import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../add_task/item_tile_with_quantity.dart';

class AddTaskActionSparePartCard extends StatelessWidget {
  const AddTaskActionSparePartCard({
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
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
                              itemCount: sparePartsItems.length,
                              itemBuilder: (context, index) {
                                final item = state
                                    .getItemById(sparePartsItems[index].itemId);
                                if (item != null) {
                                  return ItemTileWithQuantity(
                                    item: item,
                                    sparePartItemModel: sparePartsItems[index],
                                    searchQuery: '',
                                    onSelected: removeItem,
                                  );
                                }
                                return const SizedBox();
                              },
                            );
                          }
                          return const LoadingWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.orange.shade700,
              onPressed: () {},
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
                    AppLocalizations.of(context)!
                        .asset_add_spare_parts_inventory,
                  ),
                ],
              ),
            ),
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
      ),
    );
  }
}
