import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/assets/utils/asset_status.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../../../data/models/task_action/user_action_model.dart';

class TaskAction extends Equatable {
  final String id;
  final String taskId;
  final String locationId;
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
  final List<CheckpointModel> checklist;

  const TaskAction({
    required this.id,
    required this.taskId,
    required this.locationId,
    required this.comment,
    required this.replacedAssetStatus,
    required this.replacedAssetLocationId,
    required this.replacementAssetId,
    required this.startTime,
    required this.stopTime,
    required this.images,
    required this.removedPartsAssets,
    required this.addedPartsAssets,
    required this.sparePartsItems,
    required this.usersActions,
    required this.checklist,
  });

  @override
  List<Object> get props {
    return [
      id,
      taskId,
      locationId,
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
      checklist,
    ];
  }

  @override
  String toString() {
    return 'TaskAction(id: $id, taskId: $taskId, locationId: $locationId, comment: $comment, replacedAssetStatus: $replacedAssetStatus, replacedAssetLocationId: $replacedAssetLocationId, replacementAssetId: $replacementAssetId, startTime: $startTime, stopTime: $stopTime, images: $images, removedPartsAssets: $removedPartsAssets, addedPartsAssets: $addedPartsAssets, sparePartsItems: $sparePartsItems, usersActions: $usersActions, checklist: $checklist)';
  }
}
