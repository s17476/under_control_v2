import 'package:flutter/material.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_tile.dart';

import '../../../domain/entities/asset.dart';

class AssetChildrenTab extends StatelessWidget {
  const AssetChildrenTab({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Asset> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 4),
      children: children
          .map(
            (asset) => AssetTile(
              asset: asset,
              searchQuery: '',
            ),
          )
          .toList(),
    );
  }
}
