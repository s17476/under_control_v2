import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/glass_layer.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import 'filter_groups_list.dart';
import 'filter_locations_list.dart';

class HomePageFilter extends StatelessWidget {
  const HomePageFilter({
    Key? key,
    required this.isFilterExpanded,
    required this.onDismiss,
  }) : super(key: key);

  final bool isFilterExpanded;
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    if (!isFilterExpanded) {
      return const SizedBox();
    } else {
      return GlassLayer(
        onDismiss: onDismiss,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ),
          builder: (context, Offset offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0.5),
                        color: Colors.grey.shade700,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // locations title
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 12,
                          bottom: 8,
                        ),
                        child: IconTitleRow(
                          icon: Icons.location_on,
                          iconColor: Colors.grey.shade200,
                          iconBackground: Theme.of(context).primaryColor,
                          title: AppLocalizations.of(context)!
                              .home_screen_filter_select_locations,
                        ),
                      ),
                      // locations list
                      const FilterLocationsList(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          thickness: 1.5,
                        ),
                      ),

                      // groups list
                      const FilterGroupsList(),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
