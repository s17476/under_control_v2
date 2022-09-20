import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSliverAppBar extends StatelessWidget {
  final int pageIndex;
  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;
  final bool isMenuVisible;
  final VoidCallback toggleIsMenuVisible;

  const HomeSliverAppBar({
    Key? key,
    required this.pageIndex,
    required this.isFilterExpanded,
    required this.toggleIsFilterExpanded,
    required this.isMenuVisible,
    required this.toggleIsMenuVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> appBarTitles = [
      AppLocalizations.of(context)!.bottom_bar_title_tasks,
      AppLocalizations.of(context)!.bottom_bar_title_inventory,
      AppLocalizations.of(context)!.bottom_bar_title_dashboard,
      AppLocalizations.of(context)!.bottom_bar_title_assets,
      AppLocalizations.of(context)!.bottom_bar_title_knowledge,
    ];
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      floating: true,
      pinned: false,
      snap: true,
      bottom: PreferredSize(
        child: Container(
          height: 3.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey.shade700,
                Colors.transparent,
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(3.0),
      ),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              if (isFilterExpanded) {
                toggleIsFilterExpanded();
              }
              if (isMenuVisible) {
                toggleIsMenuVisible();
              }
              Scaffold.of(context).openDrawer();
            },
            child: Image.asset('assets/under_control_menu_icon.png'),
          );
        },
      ),
      title: Text(appBarTitles[pageIndex]),
      actions: [
        // search button
        if (pageIndex == 1)
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: isFilterExpanded
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
          ),
        // filter
        IconButton(
          onPressed: () {
            if (isMenuVisible) {
              toggleIsMenuVisible();
            }
            toggleIsFilterExpanded();
          },
          icon: Icon(
            Icons.tune,
            color: isFilterExpanded
                ? Theme.of(context).primaryColor
                : Theme.of(context).iconTheme.color,
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
    );
  }
}
