import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/feature_type_helpers.dart';
import '../../../data/models/feature_model.dart';

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
                  child: Icon(getIcon(widget.feature)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(3, 3),
                        blurRadius: 6,
                        spreadRadius: 0,
                      )
                    ],
                    color: getColor(widget.feature),
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
                          getTitle(context, widget.feature),
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
                horizontal: 24,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.read,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
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
                horizontal: 24,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.create,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
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
                horizontal: 24,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.edit,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
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
                horizontal: 24,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.delete,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
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
