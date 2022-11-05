import 'package:equatable/equatable.dart';

import '../../../../assets/utils/asset_status.dart';
import '../task_priority.dart';

class WorkOrder extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String locationId;
  final String userId;
  final String assetId;
  final List<String> images;
  final String video;
  final TaskPriority priority;
  final int count;
  final String taskId;
  final AssetStatus assetStatus;
  final bool cancelled;

  const WorkOrder({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.locationId,
    required this.userId,
    required this.assetId,
    required this.images,
    required this.video,
    required this.priority,
    required this.count,
    required this.taskId,
    required this.assetStatus,
    required this.cancelled,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      date,
      locationId,
      userId,
      assetId,
      images,
      video,
      priority,
      count,
      taskId,
      assetStatus,
      cancelled,
    ];
  }

  @override
  String toString() {
    return 'WorkOrder(id: $id, title: $title, description: $description, date: $date, locationId: $locationId, userId: $userId, assetId: $assetId, images: $images, video: $video, priority: $priority, count: $count, taskId: $taskId, assetStatus: $assetStatus, cancelled: $cancelled)';
  }
}
