import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

LocaleType getLocaleType(BuildContext context) {
  switch (AppLocalizations.of(context)!.localeName) {
    case 'en':
      return LocaleType.en;
    case 'pl':
      return LocaleType.pl;
    case 'da':
      return LocaleType.da;

    default:
      return LocaleType.en;
  }
}
