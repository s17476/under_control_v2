import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/choice.dart';
import '../../core/utils/get_user_permission.dart';
import '../../core/utils/permission.dart';
import '../../groups/domain/entities/feature.dart';
import '../presentation/pages/add_instruction_page.dart';
import '../presentation/pages/instruction_category_management_page.dart';

List<Choice> knowledgeBaseOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    if (getUserPermission(
      context: context,
      featureType: FeatureType.knowledgeBase,
      permissionType: PermissionType.create,
    ))
      Choice(
        title: AppLocalizations.of(context)!.instruction_add,
        icon: Icons.add,
        onTap: () {
          Navigator.pushNamed(
            context,
            AddInstructionPage.routeName,
          );
        },
      ),
    Choice(
      title: AppLocalizations.of(context)!.item_category_title,
      icon: Icons.category,
      onTap: () {
        Navigator.pushNamed(
          context,
          InstructionCategoryManagementPage.routeName,
        );
      },
    ),
  ];
  return choices;
}
