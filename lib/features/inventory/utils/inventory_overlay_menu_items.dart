import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../core/utils/choice.dart';
import '../../core/utils/get_user_permission.dart';
import '../../core/utils/permission.dart';
import '../../groups/domain/entities/feature.dart';
import '../presentation/pages/add_item_page.dart';
import '../presentation/pages/item_category_management_page.dart';

List<Choice> inventoryOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    if (getUserPermission(
      context: context,
      featureType: FeatureType.inventory,
      permissionType: PermissionType.create,
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

List<SpeedDialChild> inventoryOverlayMenuSpeedDialItems(BuildContext context) {
  final List<SpeedDialChild> choices = [
    SpeedDialChild(
      label: AppLocalizations.of(context)!.item_category_title,
      child: const Icon(Icons.category),
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemCategoryManagementPage.routeName,
        );
      },
      shape: const StadiumBorder(),
    ),
    if (getUserPermission(
      context: context,
      featureType: FeatureType.inventory,
      permissionType: PermissionType.create,
    ))
      SpeedDialChild(
        label: AppLocalizations.of(context)!.item_add,
        child: const Icon(Icons.add),
        onTap: () {
          Navigator.pushNamed(
            context,
            AddItemPage.routeName,
          );
        },
        shape: const StadiumBorder(),
        backgroundColor: Colors.orange,
      ),
  ];
  return choices;
}
