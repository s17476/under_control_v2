part of 'asset_management_bloc.dart';

abstract class AssetManagementEvent extends Equatable {
  final AssetModel asset;

  const AssetManagementEvent({
    required this.asset,
  });

  @override
  List<Object> get props => [asset];
}

class AddAssetEvent extends AssetManagementEvent {
  const AddAssetEvent({required super.asset});
}

class UpdateAssetEvent extends AssetManagementEvent {
  const UpdateAssetEvent({required super.asset});
}

class DeleteAssetEvent extends AssetManagementEvent {
  const DeleteAssetEvent({required super.asset});
}
