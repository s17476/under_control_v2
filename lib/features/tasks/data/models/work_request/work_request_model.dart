import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';

import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/work_request/work_request.dart';

class WorkRequestModel extends WorkRequest {
  const WorkRequestModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.locationId,
    required super.userId,
    required super.assetId,
    required super.images,
    required super.video,
    required super.priority,
    required super.count,
    required super.taskId,
    required super.assetStatus,
    required super.cancelled,
  });

  WorkRequestModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? locationId,
    String? userId,
    String? assetId,
    List<String>? images,
    String? video,
    TaskPriority? priority,
    int? count,
    String? taskId,
    AssetStatus? assetStatus,
    bool? cancelled,
  }) {
    return WorkRequestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      locationId: locationId ?? this.locationId,
      userId: userId ?? this.userId,
      assetId: assetId ?? this.assetId,
      images: images ?? this.images,
      video: video ?? this.video,
      priority: priority ?? this.priority,
      count: count ?? this.count,
      taskId: taskId ?? this.taskId,
      assetStatus: assetStatus ?? this.assetStatus,
      cancelled: cancelled ?? this.cancelled,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'date': date});
    result.addAll({'locationId': locationId});
    result.addAll({'userId': userId});
    result.addAll({'assetId': assetId});
    result.addAll({'images': images});
    result.addAll({'video': video});
    result.addAll({'priority': priority.name});
    result.addAll({'count': count});
    result.addAll({'taskId': taskId});
    result.addAll({'assetStatus': assetStatus.name});
    result.addAll({'cancelled': cancelled});

    return result;
  }

  factory WorkRequestModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime? date;
    try {
      date = (map['date'] as Timestamp).toDate();
    } catch (e) {
      date = DateTime.now();
    }
    return WorkRequestModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: date,
      locationId: map['locationId'] ?? '',
      userId: map['userId'] ?? '',
      assetId: map['assetId'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      video: map['video'] ?? '',
      priority: TaskPriority.fromString(map['priority'] ?? ''),
      count: map['count'] ?? 0,
      taskId: map['taskId'] ?? '',
      assetStatus: AssetStatus.fromString(map['assetStatus'] ?? ''),
      cancelled: map['cancelled'] ?? false,
    );
  }

  WorkRequestModel deepCopy() {
    return copyWith(
      images: [...images],
    );
  }

  factory WorkRequestModel.fromWorkRequest(WorkRequest workRequest) =>
      WorkRequestModel(
        id: workRequest.id,
        title: workRequest.title,
        description: workRequest.description,
        date: workRequest.date,
        locationId: workRequest.locationId,
        userId: workRequest.userId,
        assetId: workRequest.assetId,
        images: workRequest.images,
        video: workRequest.video,
        priority: workRequest.priority,
        count: workRequest.count,
        taskId: workRequest.taskId,
        assetStatus: workRequest.assetStatus,
        cancelled: workRequest.cancelled,
      );
}
