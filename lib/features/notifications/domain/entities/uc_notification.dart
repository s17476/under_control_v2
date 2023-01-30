import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/notifications/domain/entities/notification_type.dart';

class UcNotification extends Equatable {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime date;

  const UcNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.date,
  });

  @override
  List<Object> get props {
    return [
      id,
      type,
      title,
      body,
      date,
    ];
  }

  @override
  String toString() {
    return 'UcNotification(id: $id, type: $type, title: $title, body: $body, date: $date)';
  }
}
