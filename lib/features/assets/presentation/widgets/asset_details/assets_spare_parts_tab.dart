import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';

import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/widgets/item_tile.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../domain/entities/asset.dart';
import '../../blocs/asset/asset_bloc.dart';
import '../asset_tile.dart';

class AssetsSparePartsTab extends StatefulWidget {
  const AssetsSparePartsTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  State<AssetsSparePartsTab> createState() => _AssetsSparePartsTabState();
}

class _AssetsSparePartsTabState extends State<AssetsSparePartsTab> {
  List<Asset>? _filteredAssets;
  List<Item>? _filteredItems;

  @override
  void didChangeDependencies() {
    final assetsState = context.watch<AssetBloc>().state;
    final itemsState = context.watch<ItemsBloc>().state;

    if (assetsState is AssetLoadedState) {
      _filteredAssets = assetsState.allAssets.allAssets
          .where(
            (ast) => widget.asset.spareParts.contains(ast.id),
          )
          .toList();
    }

    if (itemsState is ItemsLoadedState) {
      _filteredItems = itemsState.allItems.allItems
          .where(
            (itm) => widget.asset.spareParts.contains(itm.id),
          )
          .toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // loading shimmer animation
    if (_filteredAssets == null || _filteredItems == null) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 2),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return const ShimmerItemTile();
        },
      );
    }

    // no spare parts added
    if (_filteredAssets!.isEmpty && _filteredItems!.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.settings_applications_sharp,
              size: 70,
              color: Theme.of(context).textTheme.caption!.color!,
            ),
            Text(
              AppLocalizations.of(context)!.details_no_spare_parts,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }

    // spare parts loaded and not empty
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // assets
          if (_filteredAssets!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.bottom_bar_title_assets,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),
              ),
            ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredAssets!.length,
            itemBuilder: (context, index) {
              return AssetTile(
                asset: _filteredAssets![index],
                searchQuery: '',
              );
            },
          ),

          // items
          if (_filteredItems!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.bottom_bar_title_inventory,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),
              ),
            ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredItems!.length,
            itemBuilder: (context, index) {
              return ItemTile(
                item: _filteredItems![index],
                searchQuery: '',
              );
            },
          ),
        ],
      ),
    );
  }
}
