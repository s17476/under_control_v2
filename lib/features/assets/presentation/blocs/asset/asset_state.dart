part of 'asset_bloc.dart';

abstract class AssetState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const AssetState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetEmptyState extends AssetState {}

class AssetLoadingState extends AssetState {}

class AssetErrorState extends AssetState {
  const AssetErrorState({
    super.message,
    super.error = true,
  });
}

class AssetLoadedState extends AssetState {
  final AssetsListModel allAssets;

  AssetLoadedState({
    required this.allAssets,
  }) : super(properties: [allAssets]);

  Asset? getAssetById(String id) {
    final index = allAssets.allAssets.indexWhere((asset) => asset.id == id);
    if (index >= 0) {
      return allAssets.allAssets[index];
    }
    return null;
  }
}
