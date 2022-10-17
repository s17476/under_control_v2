part of 'asset_action_management_bloc.dart';

abstract class AssetActionManagementEvent extends Equatable {
  final AssetModel asset;
  final AssetActionModel assetAction;
  final AssetActionModel? oldAssetAction;
  const AssetActionManagementEvent({
    required this.asset,
    required this.assetAction,
    this.oldAssetAction,
  });

  @override
  List<Object> get props => [asset, assetAction];
}

class AddAssetActionEvent extends AssetActionManagementEvent {
  const AddAssetActionEvent({
    required super.asset,
    required super.assetAction,
  });
}

class UpdateAssetActionEvent extends AssetActionManagementEvent {
  const UpdateAssetActionEvent({
    required super.asset,
    required super.assetAction,
    required super.oldAssetAction,
  });
}

class DeleteAssetActionEvent extends AssetActionManagementEvent {
  const DeleteAssetActionEvent({
    required super.asset,
    required super.assetAction,
  });
}
