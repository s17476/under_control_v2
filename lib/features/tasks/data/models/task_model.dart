import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task.dart';

import '../../../assets/utils/asset_status.dart';
import '../../../core/utils/duration_unit.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/entities/task_type.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.parentId,
    required super.count,
    required super.date,
    required super.executionDate,
    required super.title,
    required super.description,
    required super.locationId,
    required super.userId,
    required super.assetId,
    required super.workOrderId,
    required super.images,
    required super.instructions,
    required super.video,
    required super.priority,
    required super.type,
    required super.assetStatus,
    required super.isFinished,
    required super.isCancelled,
    required super.isSuccessful,
    required super.isInProgress,
    required super.isCyclictask,
    required super.durationUnit,
    required super.duration,
    required super.actions,
    required super.assignedGroups,
    required super.assignedUsers,
  });

  TaskModel copyWith({
    String? id,
    String? parentId,
    int? count,
    DateTime? date,
    DateTime? executionDate,
    String? title,
    String? description,
    String? locationId,
    String? userId,
    String? assetId,
    String? workOrderId,
    List<String>? images,
    List<String>? instructions,
    String? video,
    TaskPriority? priority,
    TaskType? type,
    AssetStatus? assetStatus,
    bool? isFinished,
    bool? isCancelled,
    bool? isSuccessful,
    bool? isInProgress,
    bool? isCyclictask,
    DurationUnit? durationUnit,
    int? duration,
    List<String>? actions,
    List<String>? assignedGroups,
    List<String>? assignedUsers,
  }) {
    return TaskModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      count: count ?? this.count,
      date: date ?? this.date,
      executionDate: executionDate ?? this.executionDate,
      title: title ?? this.title,
      description: description ?? this.description,
      locationId: locationId ?? this.locationId,
      userId: userId ?? this.userId,
      assetId: assetId ?? this.assetId,
      workOrderId: workOrderId ?? this.workOrderId,
      images: images ?? this.images,
      instructions: instructions ?? this.instructions,
      video: video ?? this.video,
      priority: priority ?? this.priority,
      type: type ?? this.type,
      assetStatus: assetStatus ?? this.assetStatus,
      isFinished: isFinished ?? this.isFinished,
      isCancelled: isCancelled ?? this.isCancelled,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      isInProgress: isInProgress ?? this.isInProgress,
      isCyclictask: isCyclictask ?? this.isCyclictask,
      durationUnit: durationUnit ?? this.durationUnit,
      duration: duration ?? this.duration,
      actions: actions ?? this.actions,
      assignedGroups: assignedGroups ?? this.assignedGroups,
      assignedUsers: assignedUsers ?? this.assignedUsers,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'parentId': parentId});
    result.addAll({'count': count});
    result.addAll({'date': date});
    result.addAll({'executionDate': executionDate});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'locationId': locationId});
    result.addAll({'userId': userId});
    result.addAll({'assetId': assetId});
    result.addAll({'workOrderId': workOrderId});
    result.addAll({'images': images});
    result.addAll({'instructions': instructions});
    result.addAll({'video': video});
    result.addAll({'priority': priority.name});
    result.addAll({'type': type.name});
    result.addAll({'assetStatus': assetStatus.name});
    result.addAll({'isFinished': isFinished});
    result.addAll({'isCancelled': isCancelled});
    result.addAll({'isSuccessful': isSuccessful});
    result.addAll({'isInProgress': isInProgress});
    result.addAll({'isCyclictask': isCyclictask});
    result.addAll({'durationUnit': durationUnit.name});
    result.addAll({'duration': duration});
    result.addAll({'actions': actions});
    result.addAll({'assignedGroups': assignedGroups});
    result.addAll({'assignedUsers': assignedUsers});

    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime? date;
    DateTime? executionDate;
    try {
      date = (map['date'] as Timestamp).toDate();
    } catch (e) {
      date = DateTime.now();
    }
    try {
      executionDate = (map['executionDate'] as Timestamp).toDate();
    } catch (e) {
      executionDate = DateTime.now();
    }
    return TaskModel(
      id: map['id'] ?? '',
      parentId: map['parentId'] ?? '',
      count: map['count']?.toInt() ?? 0,
      date: date,
      executionDate: executionDate,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      locationId: map['locationId'] ?? '',
      userId: map['userId'] ?? '',
      assetId: map['assetId'] ?? '',
      workOrderId: map['workOrderId'] ?? '',
      images: List<String>.from(map['images']),
      instructions: List<String>.from(map['instructions']),
      video: map['video'] ?? '',
      priority: TaskPriority.fromString(map['priority'] ?? ''),
      type: TaskType.fromString(map['type'] ?? ''),
      assetStatus: AssetStatus.fromString(map['assetStatus'] ?? ''),
      isFinished: map['isFinished'] ?? false,
      isCancelled: map['isCancelled'] ?? false,
      isSuccessful: map['isSuccessful'] ?? false,
      isInProgress: map['isInProgress'] ?? false,
      isCyclictask: map['isCyclictask'] ?? false,
      durationUnit: DurationUnit.fromString(map['durationUnit'] ?? ''),
      duration: map['duration']?.toInt() ?? 0,
      actions: List<String>.from(map['actions']),
      assignedGroups: List<String>.from(map['assignedGroups']),
      assignedUsers: List<String>.from(map['assignedUsers']),
    );
  }

  TaskModel deepCopy() {
    return copyWith(
      actions: [...actions],
      assignedGroups: [...assignedGroups],
      assignedUsers: [...assignedUsers],
      images: [...images],
      instructions: [...instructions],
    );
  }

  factory TaskModel.fromTask(Task task) => TaskModel(
        id: task.id,
        parentId: task.parentId,
        count: task.count,
        date: task.date,
        executionDate: task.executionDate,
        title: task.title,
        description: task.description,
        locationId: task.locationId,
        userId: task.userId,
        assetId: task.assetId,
        workOrderId: task.workOrderId,
        images: task.images,
        instructions: task.instructions,
        video: task.video,
        priority: task.priority,
        type: task.type,
        assetStatus: task.assetStatus,
        isFinished: task.isFinished,
        isCancelled: task.isCancelled,
        isSuccessful: task.isSuccessful,
        isInProgress: task.isInProgress,
        isCyclictask: task.isCyclictask,
        durationUnit: task.durationUnit,
        duration: task.duration,
        actions: task.actions,
        assignedGroups: task.assignedGroups,
        assignedUsers: task.assignedUsers,
      );
}
