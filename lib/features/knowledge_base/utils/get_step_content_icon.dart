import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../domain/entities/content_type.dart';

IconData getStepContentIcon(ContentType contentType) {
  switch (contentType) {
    case ContentType.image:
      return FontAwesomeIcons.image;
    case ContentType.video:
      return FontAwesomeIcons.play;
    case ContentType.youtube:
      return FontAwesomeIcons.youtube;
    case ContentType.pdf:
      return FontAwesomeIcons.filePdf;
    case ContentType.url:
      return Icons.web;
    case ContentType.text:
      return Icons.text_snippet_outlined;
    default:
      return Icons.question_mark;
  }
}
