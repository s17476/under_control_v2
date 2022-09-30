import 'dart:io';

import '../../domain/entities/instruction_step.dart';
import '../../domain/entities/content_type.dart';

class InstructionStepModel extends InstructionStep {
  const InstructionStepModel({
    required super.id,
    required super.contentType,
    super.file,
    super.contentUrl,
    super.title,
    super.description,
  });

  factory InstructionStepModel.initial() => const InstructionStepModel(
        id: 0,
        contentType: ContentType.unknown,
      );

  InstructionStepModel copyWith({
    int? id,
    ContentType? contentType,
    File? file,
    String? contentUrl,
    String? title,
    String? description,
  }) {
    return InstructionStepModel(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      file: file ?? this.file,
      contentUrl: contentUrl ?? this.contentUrl,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'contentType': contentType.name});
    result.addAll({'contentUrl': contentUrl ?? ''});
    result.addAll({'title': title ?? ''});
    result.addAll({'description': description ?? ''});

    return result;
  }

  factory InstructionStepModel.fromMap(Map<String, dynamic> map) {
    return InstructionStepModel(
      id: map['id']?.toInt() ?? 0,
      contentType: ContentType.fromString(map['contentType']),
      contentUrl: map['contentUrl'],
      title: map['title'],
      description: map['description'],
    );
  }
}
