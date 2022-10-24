import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../domain/entities/asset.dart';
import '../blocs/asset/asset_bloc.dart';
import 'asset_tile.dart';

class AssetsSparePartsTab extends StatelessWidget {
  const AssetsSparePartsTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // assets
          BlocBuilder<AssetBloc, AssetState>(
            builder: (context, state) {
              if (state is AssetLoadedState) {
                final filteredAssets = state.allAssets.allAssets
                    .where(
                      (ast) => asset.spareParts.contains(ast.id),
                    )
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredAssets.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.bottom_bar_title_assets,
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
                      itemCount: filteredAssets.length,
                      itemBuilder: (context, index) {
                        return AssetTile(
                          asset: filteredAssets[index],
                          searchQuery: '',
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
          // items
          BlocBuilder<ItemsBloc, ItemsState>(
            builder: (context, state) {
              if (state is ItemsLoadedState) {
                final filteredAssets = state.allItems.allItems
                    .where(
                      (itm) => asset.spareParts.contains(itm.id),
                    )
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredAssets.isNotEmpty)
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
                      itemCount: filteredAssets.length,
                      itemBuilder: (context, index) {
                        return ItemTile(
                          item: filteredAssets[index],
                          searchQuery: '',
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
      ),
    );
  }
}
