import 'package:flutter/cupertino.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getLocalizedUnitName(BuildContext context, ItemUnit itemUnit) {
  switch (itemUnit) {
    case ItemUnit.kg:
      return AppLocalizations.of(context)!.item_unit_kg;
    case ItemUnit.pcs:
      return AppLocalizations.of(context)!.item_unit_pcs;
    case ItemUnit.liter:
      return AppLocalizations.of(context)!.item_unit_ltr;
    default:
      return '';
  }
}
