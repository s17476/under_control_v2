import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/models/feature_model.dart';
import '../../../domain/entities/feature.dart';

class FeatureCard extends StatefulWidget {
  const FeatureCard({
    Key? key,
    required this.feature,
  }) : super(key: key);

  final FeatureModel feature;

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  IconData getIcon() {
    switch (widget.feature.type) {
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

  Color getColor() {
    switch (widget.feature.type) {
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

  String getTitle() {
    switch (widget.feature.type) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).focusColor,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // colored icon container
                Container(
                  width: 50,
                  height: 50,
                  child: Icon(getIcon()),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(3, 3),
                        blurRadius: 6,
                        spreadRadius: 0,
                      )
                    ],
                    color: getColor(),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 4,
                        ),
                        child: Text(
                          getTitle(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const Divider(
                        thickness: 1.5,
                        height: 5,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // read premission
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.read,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: widget.feature.read,
                    onChanged: (_) {
                      setState(() {
                        widget.feature.toggleRead();
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor:
                        Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ],
              ),
            ),

            // create premission
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.create,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: widget.feature.create,
                    onChanged: (_) {
                      setState(() {
                        widget.feature.toggleCreate();
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor:
                        Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ],
              ),
            ),

            // edit premission
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.edit,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: widget.feature.edit,
                    onChanged: (_) {
                      setState(() {
                        widget.feature.toggleEdit();
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor:
                        Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ],
              ),
            ),

            // delete premission
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.delete,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: widget.feature.delete,
                    onChanged: (_) {
                      setState(() {
                        widget.feature.toggleDelete();
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor:
                        Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
