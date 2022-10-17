import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/assets/utils/asset_status.dart';

class AssetAction extends Equatable {
  final String id;
  final String assetId;
  final DateTime dateTime;
  final String description;
  final bool isAssetInUse;
  final AssetStatus assetStatus;
  final String connectedTask;

  const AssetAction({
    required this.id,
    required this.assetId,
    required this.dateTime,
    required this.description,
    required this.isAssetInUse,
    required this.assetStatus,
    required this.connectedTask,
  });

  @override
  List<Object> get props {
    return [
      id,
      assetId,
      dateTime,
      description,
      isAssetInUse,
      assetStatus,
      connectedTask,
    ];
  }

  @override
  String toString() {
    return 'AssetAction(id: $id, assetId: $assetId, dateTime: $dateTime, description: $description, isAssetInUse: $isAssetInUse, assetStatus: $assetStatus, connectedTask: $connectedTask)';
  }
}
