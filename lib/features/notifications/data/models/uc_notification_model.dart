import '../../domain/entities/uc_notification.dart';
import '../../domain/entities/notification_type.dart';

class UcNotificationModel extends UcNotification {
  const UcNotificationModel({
    required super.id,
    required super.type,
    required super.code,
    required super.connectedId,
    required super.read,
  });

  UcNotification copyWith({
    String? id,
    NotificationType? type,
    String? code,
    String? connectedId,
    bool? read,
  }) {
    return UcNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      code: code ?? this.code,
      connectedId: connectedId ?? this.connectedId,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type.name});
    result.addAll({'code': code});
    result.addAll({'connectedId': connectedId});
    result.addAll({'read': read});

    return result;
  }

  factory UcNotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return UcNotificationModel(
      id: id,
      type: NotificationType.fromString(map['type'] ?? ''),
      code: map['code'] ?? '',
      connectedId: map['connectedId'] ?? '',
      read: map['read'] ?? false,
    );
  }
}
