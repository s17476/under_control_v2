import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/presentation/pages/item_category_management_page.dart';

import '../../../core/utils/choice.dart';
import '../pages/add_item_page.dart';

List<Choice> inventoryOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    Choice(
      title: AppLocalizations.of(context)!.item_add,
      icon: Icons.add,
      onTap: () {
        Navigator.pushNamed(
          context,
          AddItemPage.routeName,
        );
      },
    ),
    Choice(
      title: AppLocalizations.of(context)!.item_category_title,
      icon: Icons.category,
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemCategoryManagementPage.routeName,
        );
      },
    ),
  ];
  return choices;
}
