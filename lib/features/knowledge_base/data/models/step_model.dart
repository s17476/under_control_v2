import '../../domain/entities/step.dart';
import '../../domain/entities/content_type.dart';

class StepModel extends Step {
  const StepModel({
    required super.id,
    required super.contentType,
    super.contentSource,
    super.title,
    super.description,
  });

  StepModel copyWith({
    int? id,
    ContentType? contentType,
    String? contentSource,
    String? title,
    String? description,
  }) {
    return StepModel(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      contentSource: contentSource ?? this.contentSource,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'contentType': contentType.name});
    result.addAll({'contentSource': contentSource ?? ''});
    result.addAll({'title': title ?? ''});
    result.addAll({'description': description ?? ''});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      id: map['id']?.toInt() ?? 0,
      contentType: ContentType.fromString(map['contentType']),
      contentSource: map['contentSource'],
      title: map['title'],
      description: map['description'],
    );
  }
}
