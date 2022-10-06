import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/entities/content_type.dart';
import '../domain/entities/instruction_step.dart';

bool urlValidation(String url) {
  final urlRegex = RegExp(
    r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)',
    caseSensitive: false,
  );
  return urlRegex.hasMatch(url);
}

String? validateStep(BuildContext context, InstructionStep step) {
  // unknown content
  if (step.contentType == ContentType.unknown) {
    return AppLocalizations.of(context)!.content_type_not_selected;
    // text content
  } else if (step.contentType == ContentType.text) {
    // title
    if (step.title == null || step.title!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.header} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      // description
    } else if (step.description == null ||
        step.description!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.description} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
    }
    // image content
  } else if (step.contentType == ContentType.image) {
    if (step.title == null || step.title!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} - ${AppLocalizations.of(context)!.header} -  ${AppLocalizations.of(context)!.validation_min_two_characters}';
    } else if ((step.contentUrl == null || step.contentUrl!.isEmpty) &&
        step.file == null) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} -  ${AppLocalizations.of(context)!.content_image_not_added}';
    }
    // video content
  } else if (step.contentType == ContentType.video) {
    if (step.title == null || step.title!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} - ${AppLocalizations.of(context)!.header} -  ${AppLocalizations.of(context)!.validation_min_two_characters}';
    } else if ((step.contentUrl == null || step.contentUrl!.isEmpty) &&
        step.file == null) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} -  ${AppLocalizations.of(context)!.content_video_not_added}';
    }
    // pdf content
  } else if (step.contentType == ContentType.pdf) {
    if (step.title == null || step.title!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} - ${AppLocalizations.of(context)!.header} -  ${AppLocalizations.of(context)!.validation_min_two_characters}';
    } else if ((step.contentUrl == null || step.contentUrl!.isEmpty) &&
        step.file == null) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} -  ${AppLocalizations.of(context)!.content_pdf_not_added}';
    }
    // youtube video content
  } else if (step.contentType == ContentType.youtube) {
    if (step.title == null || step.title!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} - ${AppLocalizations.of(context)!.header} -  ${AppLocalizations.of(context)!.validation_min_two_characters}';
    } else if (step.contentUrl == null || step.contentUrl!.isEmpty) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} -  ${AppLocalizations.of(context)!.content_youtube_not_added}';
    }
    // url content
  } else if (step.contentType == ContentType.url) {
    if (step.title == null || step.title!.trim().length < 2) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} - ${AppLocalizations.of(context)!.header} -  ${AppLocalizations.of(context)!.validation_min_two_characters}';
    } else if (step.contentUrl == null || step.contentUrl!.isEmpty) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} -  ${AppLocalizations.of(context)!.content_url_not_added}';
    } else if (!urlValidation(step.contentUrl!)) {
      return '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1} -  ${AppLocalizations.of(context)!.content_url_404}';
    }
  }
  return null;
}
