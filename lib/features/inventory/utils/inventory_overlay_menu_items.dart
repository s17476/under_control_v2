import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/choice.dart';
import '../../core/utils/get_user_premission.dart';
import '../../core/utils/permission.dart';
import '../../groups/domain/entities/feature.dart';
import '../presentation/pages/add_item_page.dart';
import '../presentation/pages/item_category_management_page.dart';

List<Choice> inventoryOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    if (getUserPremission(
      context: context,
      featureType: FeatureType.inventory,
      premissionType: PermissionType.create,
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
