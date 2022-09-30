import 'dart:io';

import 'package:equatable/equatable.dart';

import 'content_type.dart';

class InstructionStep extends Equatable {
  final int id;
  final ContentType contentType;
  final File? file;
  final String? contentUrl;
  final String? title;
  final String? description;

  const InstructionStep({
    required this.id,
    required this.contentType,
    this.file,
    this.contentUrl,
    this.title,
    this.description,
  });

  @override
  List<Object> get props {
    return [
      id,
      contentType,
      contentUrl ?? '',
      title ?? '',
      description ?? '',
    ];
  }

  @override
  String toString() {
    return 'Step(id: $id, contentType: $contentType, file: $file, contentUrl: $contentUrl, title: $title, description: $description)';
  }
}
