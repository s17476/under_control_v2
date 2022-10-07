import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/home_page/filter_icon.dart';

import '../../../../groups/domain/entities/feature.dart';
import '../../../utils/get_user_premission.dart';
import '../../../utils/premission.dart';
import 'app_bar_animated_icon.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    Key? key,
    required this.pageIndex,
    required this.isFilterExpanded,
    required this.toggleIsFilterExpanded,
    required this.isSearchBarExpanded,
    required this.toggleIsSearchBarExpanded,
    required this.isMenuVisible,
    required this.toggleIsMenuVisible,
  }) : super(key: key);

  final int pageIndex;
  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;
  final bool isSearchBarExpanded;
  final VoidCallback toggleIsSearchBarExpanded;
  final bool isMenuVisible;
  final VoidCallback toggleIsMenuVisible;

  @override
  Widget build(BuildContext context) {
    final List<String> _appBarTitles = [
      AppLocalizations.of(context)!.bottom_bar_title_tasks,
      AppLocalizations.of(context)!.bottom_bar_title_inventory,
      AppLocalizations.of(context)!.bottom_bar_title_dashboard,
      AppLocalizations.of(context)!.bottom_bar_title_assets,
      AppLocalizations.of(context)!.bottom_bar_title_knowledge,
    ];
    return SliverAppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      floating: true,
      pinned: true,
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
            child: const AppBarAnimatedIcon(),
          );
        },
      ),
      title: Text(
        isSearchBarExpanded
            ? AppLocalizations.of(context)!.search
            : isFilterExpanded
                ? AppLocalizations.of(context)!.filter
                : _appBarTitles[pageIndex],
      ),
      actions: [
        // search button
        if ((pageIndex == 1 &&
                getUserPremission(
                  context: context,
                  featureType: FeatureType.inventory,
                  premissionType: PremissionType.read,
                )) ||
            (pageIndex == 3 &&
                getUserPremission(
                  context: context,
                  featureType: FeatureType.assets,
                  premissionType: PremissionType.read,
                )) ||
            (pageIndex == 4 &&
                getUserPremission(
                  context: context,
                  featureType: FeatureType.knowledgeBase,
                  premissionType: PremissionType.read,
                )))
          IconButton(
            onPressed: () {
              toggleIsSearchBarExpanded();
            },
            icon: Icon(
              Icons.search,
              color: isSearchBarExpanded
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
            if (isSearchBarExpanded) {
              toggleIsSearchBarExpanded();
            }
            toggleIsFilterExpanded();
          },
          icon: FilterIcon(
            isFilterExpanded: isFilterExpanded,
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
    );
  }
}
