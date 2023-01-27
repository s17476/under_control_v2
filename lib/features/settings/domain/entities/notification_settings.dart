import 'package:equatable/equatable.dart';

class NotificationSettings extends Equatable {
  final String lastNotificationId;
  final bool assets;
  final bool items;
  final bool tasks;
  final bool workRequests;

  const NotificationSettings({
    required this.lastNotificationId,
    required this.assets,
    required this.items,
    required this.tasks,
    required this.workRequests,
  });

  @override
  List<Object> get props {
    return [
      lastNotificationId,
      assets,
      items,
      tasks,
      workRequests,
    ];
  }

  @override
  String toString() {
    return 'NotificationSettings(lastRead: $lastNotificationId, assets: $assets, items: $items, tasks: $tasks, workRequests: $workRequests)';
  }
}
