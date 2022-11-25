import 'package:equatable/equatable.dart';

class UserAction extends Equatable {
  final String userId;
  final DateTime startTime;
  final DateTime stopTime;

  const UserAction({
    required this.userId,
    required this.startTime,
    required this.stopTime,
  });

  @override
  List<Object> get props => [userId, startTime, stopTime];

  @override
  String toString() =>
      'UserAction(userId: $userId, startTime: $startTime, stopTime: $stopTime)';
}
