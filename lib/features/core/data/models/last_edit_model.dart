import 'package:cloud_firestore/cloud_firestore.dart';

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
    result.addAll({'dateTime': dateTime});

    return result;
  }

  factory LastEditModel.fromMap(Map<String, dynamic> map) {
    return LastEditModel(
      userId: map['userId'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
    );
  }
}
