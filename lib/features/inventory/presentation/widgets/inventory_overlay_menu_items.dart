import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/get_user_premission.dart';
import 'package:under_control_v2/features/core/utils/premission.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../core/utils/choice.dart';
import '../pages/add_item_page.dart';
import '../pages/item_category_management_page.dart';

List<Choice> inventoryOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    if (getUserPremission(
      context: context,
      featureType: FeatureType.inventory,
      premissionType: PremissionType.create,
    ))
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
