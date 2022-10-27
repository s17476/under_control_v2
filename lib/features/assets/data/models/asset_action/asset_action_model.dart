import '../../../domain/entities/asset_action/asset_action.dart';
import '../../../utils/asset_status.dart';

class AssetActionModel extends AssetAction {
  const AssetActionModel({
    required super.id,
    required super.assetId,
    required super.dateTime,
    required super.userId,
    required super.isAssetInUse,
    required super.assetStatus,
    required super.connectedTask,
  });

  AssetActionModel copyWith({
    String? id,
    String? assetId,
    DateTime? dateTime,
    String? userId,
    bool? isAssetInUse,
    AssetStatus? assetStatus,
    String? connectedTask,
  }) {
    return AssetActionModel(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      dateTime: dateTime ?? this.dateTime,
      userId: userId ?? this.userId,
      isAssetInUse: isAssetInUse ?? this.isAssetInUse,
      assetStatus: assetStatus ?? this.assetStatus,
      connectedTask: connectedTask ?? this.connectedTask,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'assetId': assetId});
    result.addAll({'dateTime': dateTime.toIso8601String()});
    result.addAll({'userId': userId});
    result.addAll({'isAssetInUse': isAssetInUse});
    result.addAll({'assetStatus': assetStatus.name});
    result.addAll({'connectedTask': connectedTask});

    return result;
  }

  factory AssetActionModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return AssetActionModel(
      id: id,
      assetId: map['assetId'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
      userId: map['userId'] ?? '',
      isAssetInUse: map['isAssetInUse'] ?? false,
      assetStatus: AssetStatus.fromString(map['assetStatus']),
      connectedTask: map['connectedTask'] ?? '',
    );
  }
}
