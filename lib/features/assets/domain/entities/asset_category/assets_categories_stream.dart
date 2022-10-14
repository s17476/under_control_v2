import 'package:equatable/equatable.dart';

class AssetsCategoriesStream extends Equatable {
  final Stream allAssetsCategories;

  const AssetsCategoriesStream({
    required this.allAssetsCategories,
  });

  @override
  List<Object> get props => [allAssetsCategories];

  @override
  String toString() =>
      'AssetsCategoriesStream(allAssetsCategories: $allAssetsCategories)';
}
