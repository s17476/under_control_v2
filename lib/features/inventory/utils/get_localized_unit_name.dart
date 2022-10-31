import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domain/entities/item.dart';

String getLocalizedUnitName(BuildContext context, ItemUnit itemUnit) {
  switch (itemUnit) {
    case ItemUnit.kg:
      return AppLocalizations.of(context)!.item_unit_kg;
    case ItemUnit.pound:
      return AppLocalizations.of(context)!.item_unit_pound;
    case ItemUnit.pcs:
      return AppLocalizations.of(context)!.item_unit_pcs;
    case ItemUnit.liter:
      return AppLocalizations.of(context)!.item_unit_ltr;
    case ItemUnit.gallon:
      return AppLocalizations.of(context)!.item_unit_gallon;
    case ItemUnit.inch:
      return AppLocalizations.of(context)!.item_unit_inch;
    case ItemUnit.foot:
      return AppLocalizations.of(context)!.item_unit_foot;
    case ItemUnit.centimeter:
      return AppLocalizations.of(context)!.item_unit_centimeter;
    case ItemUnit.meter:
      return AppLocalizations.of(context)!.item_unit_meter;
    default:
      return '';
  }
}
