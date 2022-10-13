import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/entities/content_type.dart';

String getStepContentLocalizedName(
  BuildContext context,
  ContentType contentType,
) {
  switch (contentType) {
    case ContentType.image:
      return AppLocalizations.of(context)!.content_image;
    case ContentType.video:
      return AppLocalizations.of(context)!.content_video;
    case ContentType.youtube:
      return AppLocalizations.of(context)!.content_youtube;
    case ContentType.pdf:
      return AppLocalizations.of(context)!.content_pdf;
    case ContentType.url:
      return AppLocalizations.of(context)!.content_url;
    case ContentType.text:
      return AppLocalizations.of(context)!.content_text;
    default:
      return '';
  }
}
