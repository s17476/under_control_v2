import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/asset_action/asset_action.dart';
import '../../../utils/asset_status.dart';

class AssetActionModel extends AssetAction {
  const AssetActionModel({
    required super.id,
    required super.assetId,
    required super.dateTime,
    required super.userId,
    required super.locationId,
    required super.isAssetInUse,
    required super.isCreate,
    required super.assetStatus,
    required super.connectedTask,
    required super.connectedWorkRequest,
  });

  AssetActionModel copyWith({
    String? id,
    String? assetId,
    DateTime? dateTime,
    String? userId,
    String? locationId,
    bool? isAssetInUse,
    bool? isCreate,
    AssetStatus? assetStatus,
    String? connectedTask,
    String? connectedWorkRequest,
  }) {
    return AssetActionModel(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      dateTime: dateTime ?? this.dateTime,
      userId: userId ?? this.userId,
      locationId: locationId ?? this.locationId,
      isAssetInUse: isAssetInUse ?? this.isAssetInUse,
      isCreate: isCreate ?? this.isCreate,
      assetStatus: assetStatus ?? this.assetStatus,
      connectedTask: connectedTask ?? this.connectedTask,
      connectedWorkRequest: connectedWorkRequest ?? this.connectedWorkRequest,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'assetId': assetId});
    result.addAll({'dateTime': dateTime});
    result.addAll({'userId': userId});
    result.addAll({'locationId': locationId});
    result.addAll({'isAssetInUse': isAssetInUse});
    result.addAll({'isCreate': isCreate});
    result.addAll({'assetStatus': assetStatus.name});
    result.addAll({'connectedTask': connectedTask});
    result.addAll({'connectedWorkRequest': connectedWorkRequest});

    return result;
  }

  factory AssetActionModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    DateTime? date;
    try {
      date = (map['dateTime'] as Timestamp).toDate();
    } catch (e) {
      date = DateTime.now();
    }
    return AssetActionModel(
      id: id,
      assetId: map['assetId'] ?? '',
      dateTime: date,
      userId: map['userId'] ?? '',
      locationId: map['locationId'] ?? '',
      isAssetInUse: map['isAssetInUse'] ?? false,
      isCreate: map['isCreate'] ?? false,
      assetStatus: AssetStatus.fromString(map['assetStatus']),
      connectedTask: map['connectedTask'] ?? '',
      connectedWorkRequest: map['connectedWorkRequest'] ?? '',
    );
  }
}
