import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../groups/domain/entities/feature.dart';

IconData getIcon(Feature feature) {
  switch (feature.type) {
    case FeatureType.tasks:
      return Icons.task_alt;
    case FeatureType.inventory:
      return Icons.auto_awesome_mosaic_outlined;
    case FeatureType.assets:
      return Icons.precision_manufacturing_outlined;
    case FeatureType.knowledgeBase:
      return Icons.menu_book_outlined;
    case FeatureType.unknown:
      return Icons.abc;
  }
}

Color getColor(Feature feature) {
  switch (feature.type) {
    case FeatureType.tasks:
      return Colors.red;
    case FeatureType.inventory:
      return Colors.orange;
    case FeatureType.assets:
      return Colors.blue;
    case FeatureType.knowledgeBase:
      return Colors.deepPurple;
    case FeatureType.unknown:
      return Colors.pink;
  }
}

String getTitle(BuildContext context, Feature feature) {
  switch (feature.type) {
    case FeatureType.tasks:
      return AppLocalizations.of(context)!.bottom_bar_title_tasks;
    case FeatureType.inventory:
      return AppLocalizations.of(context)!.bottom_bar_title_inventory;
    case FeatureType.assets:
      return AppLocalizations.of(context)!.bottom_bar_title_assets;
    case FeatureType.knowledgeBase:
      return AppLocalizations.of(context)!.bottom_bar_title_knowledge;
    case FeatureType.unknown:
      return 'Unknown';
  }
}
