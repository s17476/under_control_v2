import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../groups/domain/entities/feature.dart';
import '../../../../tasks/presentation/blocs/task_filter/task_filter_bloc.dart';
import '../../../utils/get_user_premission.dart';
import '../../../utils/premission.dart';
import 'app_bar_animated_icon.dart';
import 'filter_icon.dart';

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
    required this.isTaskFilterVisible,
  }) : super(key: key);

  final int pageIndex;
  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;
  final bool isSearchBarExpanded;
  final VoidCallback toggleIsSearchBarExpanded;
  final bool isMenuVisible;
  final VoidCallback toggleIsMenuVisible;
  final bool isTaskFilterVisible;

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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3.0),
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
      ),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              if (isFilterExpanded) {
                toggleIsFilterExpanded();
              }
              if (isTaskFilterVisible) {
                context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
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
                : appBarTitles[pageIndex],
      ),
      actions: [
        // tasks and work requests filter
        if (pageIndex == 0 &&
            getUserPremission(
              context: context,
              featureType: FeatureType.tasks,
              premissionType: PremissionType.read,
            ))
          IconButton(
            onPressed: () {
              if (isTaskFilterVisible) {
                context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
              } else {
                context.read<TaskFilterBloc>().add(TaskFilterShowEvent());
              }
            },
            icon: Stack(
              children: [
                Icon(
                  Icons.filter_list_outlined,
                  color: isTaskFilterVisible
                      ? Theme.of(context).primaryColor
                      : null,
                ),
                BlocBuilder<TaskFilterBloc, TaskFilterState>(
                  builder: (context, state) {
                    if (state is TaskFilterSelectedState) {
                      return const Positioned(
                        top: 0,
                        left: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 5,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
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
