part of 'asset_category_management_bloc.dart';

abstract class AssetCategoryManagementEvent extends Equatable {
  final AssetCategory assetCategory;
  const AssetCategoryManagementEvent({
    required this.assetCategory,
  });

  @override
  List<Object> get props => [assetCategory];
}

class AddAssetCategoryEvent extends AssetCategoryManagementEvent {
  const AddAssetCategoryEvent({required super.assetCategory});
}

class UpdateAssetCategoryEvent extends AssetCategoryManagementEvent {
  const UpdateAssetCategoryEvent({required super.assetCategory});
}

class DeleteAssetCategoryEvent extends AssetCategoryManagementEvent {
  const DeleteAssetCategoryEvent({required super.assetCategory});
}
