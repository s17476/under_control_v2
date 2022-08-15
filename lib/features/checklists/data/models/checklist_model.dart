import '../../domain/entities/checklist.dart';
import 'checkpoint_model.dart';

class ChecklistModel extends Checklist {
  const ChecklistModel({
    required super.id,
    required super.title,
    required super.allCheckpoints,
  });

  ChecklistModel copyWith({
    String? id,
    String? title,
    List<CheckpointModel>? allCheckPoints,
  }) {
    return ChecklistModel(
      id: id ?? this.id,
      title: title ?? this.title,
      allCheckpoints: allCheckPoints ?? this.allCheckpoints,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll(
        {'allCheckpoints': allCheckpoints.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ChecklistModel.fromMap(Map<String, dynamic> map, String id) {
    return ChecklistModel(
      id: id,
      title: map['title'] ?? '',
      allCheckpoints: List<CheckpointModel>.from(
        map['allCheckpoints']?.map(
          (x) => CheckpointModel.fromMap(x),
        ),
      ),
    );
  }
}
