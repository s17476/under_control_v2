import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import 'asset_selection/overlay_asset_selection.dart';

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
                            if (widget.spareParts.isNotEmpty)
                              BlocBuilder<ItemsBloc, ItemsState>(
                                builder: (context, state) {
                                  if (state is ItemsLoadedState) {
                                    if (state.allItems.allItems.isEmpty) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: responsiveSizeVerticalPct(
                                                small: 40),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .item_no_items,
                                          ),
                                        ],
                                      );
                                    }
                                    final filteredItems =
                                        state.allItems.allItems
                                            .where(
                                              (asset) => widget.spareParts
                                                  .contains(asset.id),
                                            )
                                            .toList();
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: filteredItems.length,
                                          itemBuilder: (context, index) {
                                            return ItemTile(
                                              item: filteredItems[index],
                                              searchQuery: '',
                                              onSelected: (_) {},
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 6,
                                      itemBuilder: (context, index) {
                                        return const ShimmerItemTile();
                                      },
                                    );
                                  }
                                },
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
                          backgroundColor: Colors.blue,
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
                          backgroundColor: Colors.orange,
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
            addAsset: widget.toggleSelection,
            removeAsset: widget.toggleSelection,
            onDismiss: widget.toggleAddAssetVisibility,
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
