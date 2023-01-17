import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getLocalizedLanguageName(
  BuildContext context, [
  String? localeName,
]) {
  String langCode = '';
  if (localeName == null) {
    langCode = Platform.localeName.split('_')[0];
  } else {
    langCode = localeName.split('_')[0];
  }
  final trans = AppLocalizations.of(context)!;
  switch (langCode) {
    case 'en':
      return trans.language_en;
    case 'pl':
      return trans.language_pl;
    case 'da':
      return trans.language_dk;
    default:
      return langCode;
  }
}
