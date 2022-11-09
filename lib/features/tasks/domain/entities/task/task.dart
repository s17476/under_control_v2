import 'package:equatable/equatable.dart';

import '../../../../assets/utils/asset_status.dart';
import '../../../../core/utils/duration_unit.dart';
import '../task_priority.dart';
import '../task_type.dart';

class Task extends Equatable {
  final String id;
  final String parentId;
  final int count;
  final DateTime date;
  final DateTime executionDate;
  final String title;
  final String description;
  final String locationId;
  final String userId;
  final String assetId;
  final String workOrderId;
  final List<String> images;
  final List<String> instructions;
  final String video;
  final TaskPriority priority;
  final TaskType type;
  final AssetStatus assetStatus;
  final bool isFinished;
  final bool isCancelled;
  final bool isSuccessful;
  final bool isInProgress;
  final bool isCyclictask;
  final DurationUnit durationUnit;
  final int duration;
  final List<String> actions;
  final List<String> assignedGroups;
  final List<String> assignedUsers;

  const Task({
    required this.id,
    required this.parentId,
    required this.count,
    required this.date,
    required this.executionDate,
    required this.title,
    required this.description,
    required this.locationId,
    required this.userId,
    required this.assetId,
    required this.workOrderId,
    required this.images,
    required this.instructions,
    required this.video,
    required this.priority,
    required this.type,
    required this.assetStatus,
    required this.isFinished,
    required this.isCancelled,
    required this.isSuccessful,
    required this.isInProgress,
    required this.isCyclictask,
    required this.durationUnit,
    required this.duration,
    required this.actions,
    required this.assignedGroups,
    required this.assignedUsers,
  });

  @override
  List<Object> get props {
    return [
      id,
      parentId,
      count,
      date,
      executionDate,
      title,
      description,
      locationId,
      userId,
      assetId,
      workOrderId,
      images,
      instructions,
      video,
      priority,
      type,
      assetStatus,
      isFinished,
      isCancelled,
      isSuccessful,
      isInProgress,
      isCyclictask,
      durationUnit,
      duration,
      actions,
      assignedGroups,
      assignedUsers,
    ];
  }

  @override
  String toString() {
    return 'Task(id: $id, parentId: $parentId, count: $count, date: $date, executionDate: $executionDate, title: $title, description: $description, locationId: $locationId, userId: $userId, assetId: $assetId, workOrderId: $workOrderId, images: $images, instructions: $instructions, video: $video, priority: $priority, type: $type, assetStatus: $assetStatus, isFinished: $isFinished, isCancelled: $isCancelled, isSuccessful: $isSuccessful, isInProgress: $isInProgress, isCyclictask: $isCyclictask, durationUnit: $durationUnit, duration: $duration, actions: $actions, assignedGroups: $assignedGroups, assignedUsers: $assignedUsers)';
  }
}
