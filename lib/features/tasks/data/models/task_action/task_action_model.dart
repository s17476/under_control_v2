import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/utils/duration_apis.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../domain/entities/task_action/task_action.dart';
import '../task/spare_part_item_model.dart';
import 'user_action_model.dart';

class TaskActionModel extends TaskAction {
  const TaskActionModel({
    required super.id,
    required super.taskId,
    required super.locationId,
    required super.replacedAssetStatus,
    required super.replacedAssetLocationId,
    required super.replacementAssetId,
    required super.comment,
    required super.startTime,
    required super.stopTime,
    required super.images,
    required super.removedPartsAssets,
    required super.addedPartsAssets,
    required super.sparePartsItems,
    required super.usersActions,
    required super.checklist,
  });

  TaskActionModel copyWith({
    String? id,
    String? taskId,
    String? locationId,
    AssetStatus? replacedAssetStatus,
    String? replacedAssetLocationId,
    String? replacementAssetId,
    String? comment,
    DateTime? startTime,
    DateTime? stopTime,
    List<String>? images,
    List<AssetModel>? removedPartsAssets,
    List<String>? addedPartsAssets,
    List<SparePartItemModel>? sparePartsItems,
    List<UserActionModel>? usersActions,
    List<CheckpointModel>? checklist,
  }) {
    return TaskActionModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      locationId: locationId ?? this.locationId,
      replacedAssetStatus: replacedAssetStatus ?? this.replacedAssetStatus,
      replacedAssetLocationId:
          replacedAssetLocationId ?? this.replacedAssetLocationId,
      replacementAssetId: replacementAssetId ?? this.replacementAssetId,
      comment: comment ?? this.comment,
      startTime: startTime ?? this.startTime,
      stopTime: stopTime ?? this.stopTime,
      images: images ?? this.images,
      removedPartsAssets: removedPartsAssets ?? this.removedPartsAssets,
      addedPartsAssets: addedPartsAssets ?? this.addedPartsAssets,
      sparePartsItems: sparePartsItems ?? this.sparePartsItems,
      usersActions: usersActions ?? this.usersActions,
      checklist: checklist ?? this.checklist,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'taskId': taskId});
    result.addAll({'locationId': locationId});
    result.addAll({'replacedAssetStatus': replacedAssetStatus.name});
    result.addAll({'replacedAssetLocationId': replacedAssetLocationId});
    result.addAll({'replacementAssetId': replacementAssetId});
    result.addAll({'comment': comment});
    result.addAll({'startTime': startTime});
    result.addAll({'stopTime': stopTime});
    result.addAll({'images': images});
    result.addAll({
      'removedPartsAssets': removedPartsAssets
          .map((x) => x.toMap()..addAll({'id': x.id}))
          .toList()
    });
    result.addAll({'addedPartsAssets': addedPartsAssets});
    result.addAll(
        {'sparePartsItems': sparePartsItems.map((x) => x.toMap()).toList()});
    result
        .addAll({'usersActions': usersActions.map((x) => x.toMap()).toList()});
    result.addAll({'checklist': checklist.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TaskActionModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime? startTime;
    DateTime? stopTime;
    try {
      startTime = (map['startTime'] as Timestamp).toDate();
    } catch (e) {
      startTime = DateTime.now();
    }
    try {
      stopTime = (map['stopTime'] as Timestamp).toDate();
    } catch (e) {
      stopTime = DateTime.now();
    }
    return TaskActionModel(
      id: id,
      taskId: map['taskId'] ?? '',
      locationId: map['locationId'] ?? '',
      replacedAssetStatus:
          AssetStatus.fromString(map['replacedAssetStatus'] ?? ''),
      replacedAssetLocationId: map['replacedAssetLocationId'] ?? '',
      replacementAssetId: map['replacementAssetId'] ?? '',
      comment: map['comment'] ?? '',
      startTime: startTime,
      stopTime: stopTime,
      images: List<String>.from(map['images']),
      removedPartsAssets: List<AssetModel>.from(
        map['removedPartsAssets']?.map(
          (x) => AssetModel.fromMap(
            x,
            x['id'],
          ),
        ),
      ),
      addedPartsAssets: List<String>.from(map['addedPartsAssets']),
      sparePartsItems: List<SparePartItemModel>.from(
        map['sparePartsItems']?.map(
          (x) => SparePartItemModel.fromMap(x),
        ),
      ),
      usersActions: List<UserActionModel>.from(
        map['usersActions']?.map(
          (x) => UserActionModel.fromMap(x),
        ),
      ),
      checklist: List<CheckpointModel>.from(
        map['checklist']?.map(
              (x) => CheckpointModel.fromMap(x),
            ) ??
            [],
      ),
    );
  }

  factory TaskActionModel.fromTaskAction(TaskAction taskAction) {
    return TaskActionModel(
      id: taskAction.id,
      startTime: taskAction.startTime,
      stopTime: taskAction.stopTime,
      addedPartsAssets: taskAction.addedPartsAssets,
      comment: taskAction.comment,
      images: taskAction.images,
      removedPartsAssets: taskAction.removedPartsAssets,
      sparePartsItems: taskAction.sparePartsItems,
      taskId: taskAction.taskId,
      locationId: taskAction.locationId,
      replacementAssetId: taskAction.replacementAssetId,
      replacedAssetLocationId: taskAction.replacedAssetLocationId,
      replacedAssetStatus: taskAction.replacedAssetStatus,
      usersActions: taskAction.usersActions,
      checklist: taskAction.checklist,
    );
  }

  TaskActionModel deepCopy() {
    return copyWith(
      images: [...images],
      removedPartsAssets: [...removedPartsAssets],
      addedPartsAssets: [...addedPartsAssets],
      sparePartsItems: [...sparePartsItems],
      usersActions: [...usersActions],
      checklist: [...checklist],
    );
  }

  String get getTotalDuration {
    Duration totalDuration = const Duration();
    for (var participant in usersActions) {
      totalDuration += participant.totalTime;
    }
    return totalDuration.toFormatedString();
  }
}
