part of 'asset_category_bloc.dart';

abstract class AssetCategoryEvent extends Equatable {
  final List properties;

  const AssetCategoryEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetAllAssetsCategoriesEvent extends AssetCategoryEvent {}

class ResetEvent extends AssetCategoryEvent {}

class UpdateAssetsCategoriesListEvent extends AssetCategoryEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateAssetsCategoriesListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
