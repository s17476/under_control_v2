import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/notifications/domain/entities/uc_notification.dart';

import '../../domain/entities/notification_type.dart';

class UcNotificationModel extends UcNotification {
  const UcNotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.date,
  });

  UcNotification copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? body,
    DateTime? date,
  }) {
    return UcNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type.name});
    result.addAll({'title': title});
    result.addAll({'body': body});
    result.addAll({'date': date});

    return result;
  }

  factory UcNotificationModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime? date;
    try {
      date = (map['date'] as Timestamp).toDate();
    } catch (e) {
      date = DateTime.now();
    }
    return UcNotificationModel(
      id: id,
      type: NotificationType.fromString(map['type'] ?? ''),
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      date: date,
    );
  }
}
