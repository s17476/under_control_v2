import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../core/utils/choice.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../pages/add_asset_page.dart';
import '../pages/asset_category_management_page.dart';

List<Choice> assetsOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    if (getUserPermission(
      context: context,
      featureType: FeatureType.assets,
      permissionType: PermissionType.create,
    ))
      Choice(
        title: AppLocalizations.of(context)!.asset_add_new,
        icon: Icons.add,
        onTap: () {
          Navigator.pushNamed(
            context,
            AddAssetPage.routeName,
          );
        },
      ),
    Choice(
      title: AppLocalizations.of(context)!.item_category_title,
      icon: Icons.category,
      onTap: () {
        Navigator.pushNamed(
          context,
          AssetCategoryManagementPage.routeName,
        );
      },
    ),
  ];
  return choices;
}

List<SpeedDialChild> assetsOverlayMenuSpeedDialItems(BuildContext context) {
  final List<SpeedDialChild> choices = [
    SpeedDialChild(
      label: AppLocalizations.of(context)!.item_category_title,
      child: const Icon(Icons.category),
      onTap: () {
        Navigator.pushNamed(
          context,
          AssetCategoryManagementPage.routeName,
        );
      },
      shape: const StadiumBorder(),
    ),
    if (getUserPermission(
      context: context,
      featureType: FeatureType.assets,
      permissionType: PermissionType.create,
    ))
      SpeedDialChild(
        label: AppLocalizations.of(context)!.asset_add_new,
        child: const Icon(Icons.add),
        onTap: () {
          Navigator.pushNamed(
            context,
            AddAssetPage.routeName,
          );
        },
        backgroundColor: Colors.blue,
        shape: const StadiumBorder(),
      ),
  ];
  return choices;
}
