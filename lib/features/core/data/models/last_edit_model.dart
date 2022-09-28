import '../../domain/entities/last_edit.dart';

class LastEditModel extends LastEdit {
  const LastEditModel({
    required super.userId,
    required super.dateTime,
  });

  LastEditModel copyWith({
    String? userId,
    DateTime? dateTime,
  }) {
    return LastEditModel(
      userId: userId ?? this.userId,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'dateTime': dateTime.toIso8601String()});

    return result;
  }

  factory LastEditModel.fromMap(Map<String, dynamic> map) {
    return LastEditModel(
      userId: map['userId'] ?? '',
      dateTime: DateTime.parse(map['dateTime'] ?? DateTime.now()),
    );
  }
}
