import 'package:equatable/equatable.dart';

import 'asset_category.dart';

class AssetsCategoriesList extends Equatable {
  final List<AssetCategory> allAssetsCategories;
  const AssetsCategoriesList({
    required this.allAssetsCategories,
  });

  @override
  List<Object> get props => [allAssetsCategories];

  @override
  String toString() =>
      'AssetsCategoriesList(allAssetsCategories: $allAssetsCategories)';
}
