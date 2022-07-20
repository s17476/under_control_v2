import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSliverAppBar extends StatelessWidget {
  final int pageIndex;
  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;

  const HomeSliverAppBar(
      {Key? key,
      required this.pageIndex,
      required this.isFilterExpanded,
      required this.toggleIsFilterExpanded})
      : super(key: key);

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
          )),
        ),
        preferredSize: const Size.fromHeight(3.0),
      ),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Image.asset('assets/under_control_menu_icon.png'),
          );
        },
      ),
      title: Text(appBarTitles[pageIndex]),
      actions: [
        IconButton(
          onPressed: toggleIsFilterExpanded,
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
