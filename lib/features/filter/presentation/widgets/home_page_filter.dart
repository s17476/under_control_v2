import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import 'filter_groups_list.dart';
import 'filter_locations_list.dart';

class HomePageFilter extends StatefulWidget {
  const HomePageFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageFilter> createState() => _HomePageFilterState();
}

class _HomePageFilterState extends State<HomePageFilter> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
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
                // height: widget.isFilterExpanded ? null : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                    // groups title
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: IconTitleRow(
                        icon: Icons.group,
                        iconColor: Colors.grey.shade200,
                        iconBackground: Theme.of(context).primaryColor,
                        title: AppLocalizations.of(context)!
                            .home_screen_filter_select_group,
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
        });
  }
}
