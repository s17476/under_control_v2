import 'package:equatable/equatable.dart';

import '../../../utils/asset_status.dart';

class AssetAction extends Equatable {
  final String id;
  final String assetId;
  final DateTime dateTime;
  final String userId;
  final String locationId;
  final bool isAssetInUse;
  final bool isCreate;
  final AssetStatus assetStatus;
  final String connectedTask;

  const AssetAction({
    required this.id,
    required this.assetId,
    required this.dateTime,
    required this.userId,
    required this.locationId,
    required this.isAssetInUse,
    required this.isCreate,
    required this.assetStatus,
    required this.connectedTask,
  });

  @override
  List<Object> get props {
    return [
      id,
      assetId,
      dateTime,
      userId,
      locationId,
      isAssetInUse,
      isCreate,
      assetStatus,
      connectedTask,
    ];
  }

  @override
  String toString() {
    return 'AssetAction(id: $id, assetId: $assetId, dateTime: $dateTime, userId: $userId, locationId: $locationId, isAssetInUse: $isAssetInUse, isCreate: $isCreate, assetStatus: $assetStatus, connectedTask: $connectedTask)';
  }
}
