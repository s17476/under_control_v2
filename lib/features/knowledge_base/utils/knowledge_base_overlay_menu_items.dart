import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/choice.dart';
import '../presentation/pages/instruction_category_management_page.dart';

List<Choice> knowledgeBaseOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    // if (getUserPremission(
    //   context: context,
    //   featureType: FeatureType.knowledgeBase,
    //   premissionType: PremissionType.create,
    // ))
    //   Choice(
    //     title: AppLocalizations.of(context)!.item_add,
    //     icon: Icons.add,
    //     onTap: () {
    //       Navigator.pushNamed(
    //         context,
    //         AddItemPage.routeName,
    //       );
    //     },
    //   ),
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
