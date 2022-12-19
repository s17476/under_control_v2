import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/assets/utils/asset_status.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../../../data/models/task_action/user_action_model.dart';

class TaskAction extends Equatable {
  final String id;
  final String taskId;
  final String comment;
  final AssetStatus replacedAssetStatus;
  final String replacedAssetLocationId;
  final String replacementAssetId;
  final DateTime startTime;
  final DateTime stopTime;
  final List<String> images;
  final List<AssetModel> removedPartsAssets;
  final List<String> addedPartsAssets;
  final List<SparePartItemModel> sparePartsItems;
  final List<UserActionModel> usersActions;

  const TaskAction({
    required this.id,
    required this.taskId,
    required this.replacedAssetStatus,
    required this.replacedAssetLocationId,
    required this.replacementAssetId,
    required this.comment,
    required this.startTime,
    required this.stopTime,
    required this.images,
    required this.removedPartsAssets,
    required this.addedPartsAssets,
    required this.sparePartsItems,
    required this.usersActions,
  });

  @override
  List<Object> get props {
    return [
      id,
      taskId,
      comment,
      replacedAssetStatus,
      replacedAssetLocationId,
      replacementAssetId,
      startTime,
      stopTime,
      images,
      removedPartsAssets,
      addedPartsAssets,
      sparePartsItems,
      usersActions,
    ];
  }

  @override
  String toString() {
    return 'TaskAction(id: $id, taskId: $taskId, comment: $comment, replacedAssetStatus: $replacedAssetStatus, replacedAssetLocationId: $replacedAssetLocationId, replacementAssetId: $replacementAssetId, startTime: $startTime, stopTime: $stopTime, images: $images, removedPartsAssets: $removedPartsAssets, addedPartsAssets: $addedPartsAssets, sparePartsItems: $sparePartsItems, usersActions: $usersActions)';
  }
}
