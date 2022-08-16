import '../../domain/entities/checkpoint.dart';

class CheckpointModel extends Checkpoint {
  const CheckpointModel({
    required super.title,
    required super.isChecked,
  });

  factory CheckpointModel.initial() => const CheckpointModel(
        title: 'title',
        isChecked: false,
      );

  CheckpointModel copyWith({
    String? title,
    bool? isChecked,
  }) {
    return CheckpointModel(
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'isChecked': isChecked});

    return result;
  }

  factory CheckpointModel.fromMap(Map<String, dynamic> map) {
    return CheckpointModel(
      title: map['title'] ?? '',
      isChecked: map['isChecked'] ?? false,
    );
  }
}
