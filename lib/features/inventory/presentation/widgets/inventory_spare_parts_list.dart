import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/items/items_bloc.dart';
import 'item_tile.dart';
import 'shimmer_item_tile.dart';

class InventorySparePartsList extends StatelessWidget {
  const InventorySparePartsList({
    Key? key,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  final List<String> items;
  final Function(String) onSelected;

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
                      (item) => items.contains(item.id),
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
                        return ItemTile(
                          item: filteredItems[index],
                          searchQuery: '',
                          onSelected: onSelected,
                          isSelected: true,
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
