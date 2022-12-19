import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';

import '../../../domain/entities/task_action/task_action.dart';
import '../task/spare_part_item_model.dart';
import 'user_action_model.dart';

class TaskActionModel extends TaskAction {
  const TaskActionModel({
    required super.id,
    required super.taskId,
    required super.replacementAssetId,
    required super.comment,
    required super.startTime,
    required super.stopTime,
    required super.images,
    required super.removedPartsAssets,
    required super.addedPartsAssets,
    required super.sparePartsItems,
    required super.usersActions,
  });

  TaskActionModel copyWith({
    String? id,
    String? taskId,
    String? replacementAssetId,
    String? comment,
    DateTime? startTime,
    DateTime? stopTime,
    List<String>? images,
    List<AssetModel>? removedPartsAssets,
    List<String>? addedPartsAssets,
    List<SparePartItemModel>? sparePartsItems,
    List<UserActionModel>? usersActions,
  }) {
    return TaskActionModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      replacementAssetId: replacementAssetId ?? this.replacementAssetId,
      comment: comment ?? this.comment,
      startTime: startTime ?? this.startTime,
      stopTime: stopTime ?? this.stopTime,
      images: images ?? this.images,
      removedPartsAssets: removedPartsAssets ?? this.removedPartsAssets,
      addedPartsAssets: addedPartsAssets ?? this.addedPartsAssets,
      sparePartsItems: sparePartsItems ?? this.sparePartsItems,
      usersActions: usersActions ?? this.usersActions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'taskId': taskId});
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
      replacementAssetId: taskAction.replacementAssetId,
      usersActions: taskAction.usersActions,
    );
  }
}
