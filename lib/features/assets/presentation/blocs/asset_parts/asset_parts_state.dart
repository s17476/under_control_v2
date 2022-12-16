part of 'asset_parts_bloc.dart';

abstract class AssetPartsState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const AssetPartsState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetPartsEmptyState extends AssetPartsState {}

class AssetPartsLoadingState extends AssetPartsState {}

class AssetPartsErrorState extends AssetPartsState {
  const AssetPartsErrorState({
    super.message,
    super.error = true,
  });
}

class AssetPartsLoadedState extends AssetPartsState {
  final AssetsListModel allAssetParts;
  final String parentId;

  AssetPartsLoadedState({
    required this.allAssetParts,
    required this.parentId,
  }) : super(properties: [
          allAssetParts,
          parentId,
        ]);
}
