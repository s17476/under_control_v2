import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/utils/show_spare_part_asset_delete_dialog.dart';

import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../blocs/asset/asset_bloc.dart';
import 'asset_tile.dart';

class AssetsSparePartsList extends StatelessWidget {
  const AssetsSparePartsList({
    Key? key,
    required this.items,
    this.onSelected,
  }) : super(key: key);

  final List<String> items;
  final Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (items.isNotEmpty)
          BlocBuilder<AssetBloc, AssetState>(
            builder: (context, state) {
              if (state is AssetLoadedState) {
                if (state.allAssets.allAssets.isEmpty) {
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
                final filteredAssets = state.allAssets.allAssets
                    .where(
                      (asset) => items.contains(asset.id),
                    )
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredAssets.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          onSelected: onSelected != null
                              ? (assetId) => showSparePartAssetDeleteDialog(
                                    context: context,
                                    asset: filteredAssets[index],
                                    onDelete: () => onSelected!(assetId),
                                  )
                              : null,
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
