import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/notifications/domain/entities/notification_type.dart';

class UcNotification extends Equatable {
  final String id;
  final NotificationType type;
  final String code;
  final String connectedId;
  final bool read;

  const UcNotification({
    required this.id,
    required this.type,
    required this.code,
    required this.connectedId,
    required this.read,
  });

  @override
  List<Object> get props {
    return [
      id,
      type,
      code,
      connectedId,
      read,
    ];
  }

  @override
  String toString() {
    return 'UcNotification(id: $id, type: $type, code: $code, connectedId: $connectedId, read: $read)';
  }
}
