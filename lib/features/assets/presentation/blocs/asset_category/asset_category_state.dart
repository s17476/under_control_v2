part of 'asset_category_bloc.dart';

abstract class AssetCategoryState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const AssetCategoryState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetCategoryEmptyState extends AssetCategoryState {}

class AssetCategoryLoadingState extends AssetCategoryState {}

class AssetCategoryErrorState extends AssetCategoryState {
  const AssetCategoryErrorState({
    super.message,
    super.error = true,
  });
}

class AssetCategoryLoadedState extends AssetCategoryState {
  final AssetsCategoriesListModel allAssetsCategories;
  AssetCategoryLoadedState({
    required this.allAssetsCategories,
  }) : super(properties: [allAssetsCategories]);

  AssetCategory? getAssetCategoryById(String id) {
    final categoryIdex = allAssetsCategories.allAssetsCategories
        .indexWhere((cat) => cat.id == id);
    if (categoryIdex >= 0) {
      return allAssetsCategories.allAssetsCategories[categoryIdex];
    }
    return null;
  }
}
