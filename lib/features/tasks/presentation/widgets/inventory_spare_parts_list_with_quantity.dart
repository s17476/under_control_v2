import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/item_tile_with_quantity.dart';

import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';

class InventorySparePartsListWithQuantity extends StatelessWidget {
  const InventorySparePartsListWithQuantity({
    Key? key,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  final List<SparePartItemModel> items;
  final Function(SparePartItemModel) onSelected;

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
                final filteredItems = state.allItems.allItems
                    .where(
                      (item) => items.map((e) => e.itemId).contains(item.id),
                    )
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredItems.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .bottom_bar_title_inventory,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
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
                          sparePartItemModel: items.firstWhere(
                              (i) => i.itemId == filteredItems[index].id),
                          searchQuery: '',
                          onSelected: onSelected,
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
