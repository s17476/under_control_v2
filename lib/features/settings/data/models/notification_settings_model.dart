import '../../domain/entities/notification_settings.dart';

class NotificationSettingsModel extends NotificationSettings {
  const NotificationSettingsModel({
    required super.lastNotificationId,
    required super.assets,
    required super.items,
    required super.tasks,
    required super.workRequests,
  });

  NotificationSettings copyWith({
    String? lastNotificationId,
    bool? assets,
    bool? items,
    bool? tasks,
    bool? workRequests,
  }) {
    return NotificationSettings(
      lastNotificationId: lastNotificationId ?? this.lastNotificationId,
      assets: assets ?? this.assets,
      items: items ?? this.items,
      tasks: tasks ?? this.tasks,
      workRequests: workRequests ?? this.workRequests,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'lastNotificationId': lastNotificationId});
    result.addAll({'assets': assets});
    result.addAll({'items': items});
    result.addAll({'tasks': tasks});
    result.addAll({'workRequests': workRequests});

    return result;
  }

  factory NotificationSettingsModel.fromMap(Map<String, dynamic> map) {
    return NotificationSettingsModel(
      lastNotificationId: map['lastNotificationId'] ?? '',
      assets: map['assets'] ?? true,
      items: map['items'] ?? true,
      tasks: map['tasks'] ?? true,
      workRequests: map['workRequests'] ?? true,
    );
  }

  factory NotificationSettingsModel.initial() {
    return const NotificationSettingsModel(
      lastNotificationId: '',
      assets: true,
      items: true,
      tasks: true,
      workRequests: true,
    );
  }

  factory NotificationSettingsModel.fromDomain(NotificationSettings settings) {
    return NotificationSettingsModel(
      lastNotificationId: settings.lastNotificationId,
      assets: settings.assets,
      items: settings.items,
      tasks: settings.tasks,
      workRequests: settings.workRequests,
    );
  }
}
