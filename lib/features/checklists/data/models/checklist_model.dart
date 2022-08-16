import '../../domain/entities/checklist.dart';
import 'checkpoint_model.dart';

class ChecklistModel extends Checklist {
  const ChecklistModel({
    required super.id,
    required super.title,
    required super.description,
    required super.allCheckpoints,
  });

  ChecklistModel copyWith({
    String? id,
    String? title,
    String? description,
    List<CheckpointModel>? allCheckpoints,
  }) {
    return ChecklistModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      allCheckpoints: allCheckpoints ?? this.allCheckpoints,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll(
        {'allCheckpoints': allCheckpoints.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ChecklistModel.fromMap(Map<String, dynamic> map, String id) {
    return ChecklistModel(
        id: id,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        allCheckpoints: List<CheckpointModel>.from(
          map['allCheckpoints']?.map(
            (x) => CheckpointModel.fromMap(x),
          ),
        )
        // ..sort(
        //     (a, b) => a.title.toLowerCase().compareTo(
        //           b.title.toLowerCase(),
        //         ),
        //   ),
        );
  }

  ChecklistModel deepCopy() {
    return copyWith(
      id: id,
      description: description,
      allCheckpoints: [...allCheckpoints],
    );
  }
}
