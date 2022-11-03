import 'package:equatable/equatable.dart';

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
    ];
  }

  @override
  String toString() {
    return 'WorkOrder(id: $id, title: $title, description: $description, date: $date, locationId: $locationId, userId: $userId, assetId: $assetId, images: $images, video: $video, priority: $priority, count: $count)';
  }
}
