import 'package:equatable/equatable.dart';

class LastEdit extends Equatable {
  final String userId;
  final DateTime dateTime;

  const LastEdit({
    required this.userId,
    required this.dateTime,
  });

  @override
  List<Object> get props => [userId, dateTime];

  @override
  String toString() => 'LastEdit(userId: $userId, dateTime: $dateTime)';
}
