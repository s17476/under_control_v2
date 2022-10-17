import 'package:equatable/equatable.dart';

import 'asset_action.dart';

class AssetActionsList extends Equatable {
  final List<AssetAction> allAssetActions;

  const AssetActionsList({
    required this.allAssetActions,
  });

  @override
  List<Object> get props => [allAssetActions];

  @override
  String toString() => 'AssetActionsList(allAssetActions: $allAssetActions)';
}
