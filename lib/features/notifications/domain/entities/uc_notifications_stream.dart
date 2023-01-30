import 'package:equatable/equatable.dart';

class UcNotificationsStream extends Equatable {
  final Stream allNotifications;

  const UcNotificationsStream({
    required this.allNotifications,
  });

  @override
  List<Object> get props => [allNotifications];

  @override
  String toString() =>
      'UcNotificationsStream(allNotifications: $allNotifications)';
}
