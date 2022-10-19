import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/duration_unit.dart';

String getLocalizedDurationUnitName(
    BuildContext context, DurationUnit durationUnit) {
  switch (durationUnit) {
    case DurationUnit.hour:
      return AppLocalizations.of(context)!.duration_unit_hour;
    case DurationUnit.day:
      return AppLocalizations.of(context)!.duration_unit_day;
    case DurationUnit.week:
      return AppLocalizations.of(context)!.duration_unit_week;
    case DurationUnit.month:
      return AppLocalizations.of(context)!.duration_unit_month;
    case DurationUnit.year:
      return AppLocalizations.of(context)!.duration_unit_year;
    default:
      return '';
  }
}
