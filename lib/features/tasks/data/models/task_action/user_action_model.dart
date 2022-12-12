import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/user_action.dart';

class UserActionModel extends UserAction {
  const UserActionModel({
    required super.userId,
    required super.startTime,
    required super.stopTime,
  });

  Duration get totalTime => stopTime.difference(startTime);

  UserActionModel copyWith({
    String? userId,
    DateTime? startTime,
    DateTime? stopTime,
  }) {
    return UserActionModel(
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      stopTime: stopTime ?? this.stopTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'startTime': startTime});
    result.addAll({'stopTime': stopTime});

    return result;
  }

  factory UserActionModel.fromMap(Map<String, dynamic> map) {
    DateTime? startTime;
    DateTime? stopTime;
    try {
      startTime = (map['startTime'] as Timestamp).toDate();
    } catch (e) {
      startTime = DateTime.now();
    }
    try {
      stopTime = (map['stopTime'] as Timestamp).toDate();
    } catch (e) {
      stopTime = DateTime.now();
    }
    return UserActionModel(
      userId: map['userId'] ?? '',
      startTime: startTime,
      stopTime: stopTime,
    );
  }
}
