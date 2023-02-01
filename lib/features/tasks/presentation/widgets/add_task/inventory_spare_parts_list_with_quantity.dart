import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../inventory/domain/entities/item.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import 'item_tile_with_quantity.dart';

class InventorySparePartsListWithQuantity extends StatelessWidget {
  const InventorySparePartsListWithQuantity({
    Key? key,
    required this.items,
    this.onSelected,
    this.updateSparePartQuantity,
    this.showTitle = true,
  }) : super(key: key);

  final List<SparePartItemModel> items;
  final Function(SparePartItemModel)? onSelected;
  final Function(String, double)? updateSparePartQuantity;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (items.isNotEmpty)
          BlocBuilder<ItemsBloc, ItemsState>(
            builder: (context, state) {
              if (state is ItemsLoadedState) {
                if (state.allItems.allItems.isEmpty) {
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
                List<Item> filteredItems = [];
                for (var item in items) {
                  final index = state.allItems.allItems
                      .indexWhere((itm) => itm.id == item.itemId);
                  if (index >= 0) {
                    filteredItems.add(state.allItems.allItems[index]);
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredItems.isNotEmpty && showTitle)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .bottom_bar_title_inventory,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 2),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ItemTileWithQuantity(
                          key: ValueKey(filteredItems[index].id),
                          item: filteredItems[index],
                          sparePartItemModel: items[index],
                          searchQuery: '',
                          onSelected: onSelected,
                          updateSparePartQuantity: updateSparePartQuantity,
                        );
                      },
                    ),
                  ],
                );
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
