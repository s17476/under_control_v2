import 'package:equatable/equatable.dart';

import 'content_type.dart';

class Step extends Equatable {
  final int id;
  final ContentType contentType;
  final String? contentSource;
  final String? title;
  final String? description;

  const Step({
    required this.id,
    required this.contentType,
    this.contentSource,
    this.title,
    this.description,
  });

  @override
  List<Object> get props {
    return [
      id,
      contentType,
      contentSource ?? '',
      title ?? '',
      description ?? '',
    ];
  }

  @override
  String toString() {
    return 'Step(id: $id, contentType: $contentType, contentSource: $contentSource, title: $title, description: $description)';
  }
}
