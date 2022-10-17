import 'package:equatable/equatable.dart';

import 'asset.dart';

class AssetsList extends Equatable {
  final List<Asset> allAssets;

  const AssetsList({
    required this.allAssets,
  });

  @override
  List<Object> get props => [allAssets];

  @override
  String toString() => 'AssetsList(allAssets: $allAssets)';
}
