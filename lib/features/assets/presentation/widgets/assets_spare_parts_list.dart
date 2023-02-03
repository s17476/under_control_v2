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
    this.padding,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
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
                if (filteredAssets.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: padding ?? const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.bottom_bar_title_assets,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.only(top: 4),
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
                            margin: const EdgeInsets.symmetric(vertical: 4),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox();
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
