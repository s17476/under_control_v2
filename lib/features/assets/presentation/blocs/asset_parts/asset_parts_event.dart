part of 'asset_parts_bloc.dart';

abstract class AssetPartsEvent extends Equatable {
  final List properties;

  const AssetPartsEvent({required this.properties});

  @override
  List<Object> get props => [properties];
}

class GetAssetsForParentEvent extends AssetPartsEvent {
  final String parentAssetId;
  GetAssetsForParentEvent({
    required this.parentAssetId,
  }) : super(properties: [parentAssetId]);
}

class UpdateAssetPartsListEvent extends AssetPartsEvent {
  final QuerySnapshot<Object?> snapshot;
  final String parentAssetId;

  UpdateAssetPartsListEvent({
    required this.snapshot,
    required this.parentAssetId,
  }) : super(properties: [snapshot, parentAssetId]);
}

class ResetEvent extends AssetPartsEvent {
  const ResetEvent({super.properties = const []});
}
