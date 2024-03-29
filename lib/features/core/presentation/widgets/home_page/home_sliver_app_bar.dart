import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../groups/domain/entities/feature.dart';
import '../../../../tasks/presentation/blocs/task_filter/task_filter_bloc.dart';
import '../../../utils/get_user_permission.dart';
import '../../../utils/permission.dart';
import 'app_bar_animated_icon.dart';
import 'calendar_button.dart';
import 'filter_button.dart';
import 'notifications_button.dart';
import 'search_button.dart';
import 'task_filter_button.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    Key? key,
    required this.pageIndex,
    required this.isFilterExpanded,
    required this.toggleIsFilterExpanded,
    required this.isNotificationsExpanded,
    required this.toggleIsNotificationsExpanded,
    required this.isSearchBarExpanded,
    required this.toggleIsSearchBarExpanded,
    required this.isMenuVisible,
    required this.toggleIsMenuVisible,
    required this.isTaskFilterVisible,
    required this.toggleIsCalendarVisible,
    required this.isCalendarVisible,
    required this.toggleShowcaseBarierInteraction,
    required this.menuKey,
    required this.notificationsKey,
    required this.filterKey,
  }) : super(key: key);

  final int pageIndex;
  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;
  final bool isNotificationsExpanded;
  final VoidCallback toggleIsNotificationsExpanded;
  final bool isSearchBarExpanded;
  final VoidCallback toggleIsSearchBarExpanded;
  final bool isMenuVisible;
  final VoidCallback toggleIsMenuVisible;
  final bool isTaskFilterVisible;
  final VoidCallback toggleIsCalendarVisible;
  final bool isCalendarVisible;
  final VoidCallback toggleShowcaseBarierInteraction;
  final GlobalKey menuKey;
  final GlobalKey notificationsKey;
  final GlobalKey filterKey;

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
      scrolledUnderElevation: 0,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
      // ),
      floating: true,
      pinned: true,
      snap: true,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3.0),
        child: Container(
          height: 1.0,
          color: Colors.grey.shade700,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              if (isFilterExpanded) {
                toggleIsFilterExpanded();
              }
              if (isNotificationsExpanded) {
                toggleIsNotificationsExpanded();
              }
              if (isTaskFilterVisible) {
                context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
              }
              if (isMenuVisible) {
                toggleIsMenuVisible();
              }
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Showcase(
                key: menuKey,
                title: AppLocalizations.of(context)!.showcase_menu,
                description:
                    AppLocalizations.of(context)!.showcase_menu_description,
                targetShapeBorder: const CircleBorder(),
                tooltipBackgroundColor: Theme.of(context).primaryColor,
                titleTextStyle: Theme.of(context).textTheme.headlineSmall,
                descTextStyle: Theme.of(context).textTheme.bodyLarge,
                onTargetClick: () async {
                  Scaffold.of(context).openDrawer();

                  Future.delayed(const Duration(milliseconds: 400), () {
                    ShowCaseWidget.of(context).next();
                  });
                },
                disposeOnTap: false,
                child: const AppBarAnimatedIcon(),
              ),
            ),
          );
        },
      ),
      title: Text(
        isSearchBarExpanded
            ? AppLocalizations.of(context)!.search
            : isFilterExpanded
                ? AppLocalizations.of(context)!.filter
                : appBarTitles[pageIndex],
      ),
      actions: [
        // tasks and work requests filter
        if (pageIndex == 0 &&
            !isCalendarVisible &&
            getUserPermission(
              context: context,
              featureType: FeatureType.tasks,
              permissionType: PermissionType.read,
            ))
          TaskFilterButton(
            isTaskFilterVisible: isTaskFilterVisible,
          ),

        // calendar
        if (pageIndex == 0 &&
            getUserPermission(
              context: context,
              featureType: FeatureType.tasks,
              permissionType: PermissionType.read,
            ))
          CalendarButton(
            isCalendarVisible: isCalendarVisible,
            toggleCalendarButton: toggleIsCalendarVisible,
          ),

        // search button
        if ((pageIndex == 1 &&
                getUserPermission(
                  context: context,
                  featureType: FeatureType.inventory,
                  permissionType: PermissionType.read,
                )) ||
            (pageIndex == 3 &&
                getUserPermission(
                  context: context,
                  featureType: FeatureType.assets,
                  permissionType: PermissionType.read,
                )) ||
            (pageIndex == 4 &&
                getUserPermission(
                  context: context,
                  featureType: FeatureType.knowledgeBase,
                  permissionType: PermissionType.read,
                )))
          SearchButton(
            isSearchBarExpanded: isSearchBarExpanded,
            toggleIsSearchBarExpanded: toggleIsSearchBarExpanded,
          ),
        // notifications
        Showcase(
          key: notificationsKey,
          title: AppLocalizations.of(context)!.notifications,
          description:
              AppLocalizations.of(context)!.showcase_notifications_description,
          targetShapeBorder: const CircleBorder(),
          targetPadding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
          tooltipBackgroundColor: Theme.of(context).primaryColor,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          descTextStyle: Theme.of(context).textTheme.bodyLarge,
          child: NotificationsButton(
            isNotificationsExpanded: isNotificationsExpanded,
            toggleIsNotificationsExpanded: toggleIsNotificationsExpanded,
            isFilterExpanded: isFilterExpanded,
            toggleIsFilterExpanded: toggleIsFilterExpanded,
            isSearchBarExpanded: isSearchBarExpanded,
            toggleIsSearchBarExpanded: toggleIsSearchBarExpanded,
            isMenuVisible: isMenuVisible,
            toggleIsMenuVisible: toggleIsMenuVisible,
          ),
        ),
        // filter
        Showcase(
          key: filterKey,
          title: AppLocalizations.of(context)!.filter,
          description:
              AppLocalizations.of(context)!.showcase_filter_description,
          targetShapeBorder: const CircleBorder(),
          targetPadding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
          tooltipBackgroundColor: Theme.of(context).primaryColor,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          descTextStyle: Theme.of(context).textTheme.bodyLarge,
          child: FilterButton(
            isNotificationsExpanded: isNotificationsExpanded,
            toggleIsNotificationsExpanded: toggleIsNotificationsExpanded,
            isFilterExpanded: isFilterExpanded,
            toggleIsFilterExpanded: toggleIsFilterExpanded,
            isSearchBarExpanded: isSearchBarExpanded,
            toggleIsSearchBarExpanded: toggleIsSearchBarExpanded,
            isMenuVisible: isMenuVisible,
            toggleIsMenuVisible: toggleIsMenuVisible,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
