import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../inventory/domain/entities/item_action/item_action.dart';
import '../../../inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';
import '../../../inventory/presentation/widgets/actions/item_action_list_tile.dart';

class AllActionsListPage extends StatefulWidget {
  const AllActionsListPage({Key? key}) : super(key: key);

  static const routeName = '/item-details/all-actions-list';

  @override
  State<AllActionsListPage> createState() => _AllActionsListPageState();
}

class _AllActionsListPageState extends State<AllActionsListPage> {
  List<ItemAction>? actions;
  List<ItemAction>? filteredActions;
  bool isFilterExpanded = false;

  @override
  void initState() {
    // gets item actions
    context.read<DashboardItemActionBloc>().add(
          GetDashboardItemActionsEvent(),
        );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final actionsState = context.watch<DashboardItemActionBloc>().state;
    if (actionsState is DashboardItemActionLoadedState) {
      actions = actionsState.allActions.allItemActions.toList();
      filteredActions ??= actions;
    }
    super.didChangeDependencies();
  }

  _filterActions(int index) {
    switch (index) {
      case 0:
        setState(() {
          filteredActions = actions;
        });
        break;
      case 1:
        setState(() {
          filteredActions = actions
              ?.where((action) => action.type == ItemActionType.add)
              .toList();
        });
        break;
      case 2:
        setState(() {
          filteredActions = actions
              ?.where((action) => action.type == ItemActionType.remove)
              .toList();
        });
        break;
      case 3:
        setState(() {
          filteredActions = actions
              ?.where((action) =>
                  action.type == ItemActionType.moveAdd ||
                  action.type == ItemActionType.moveRemove)
              .toList();
        });
        break;
      default:
        filteredActions = actions;
        break;
    }
  }

  // TODO
  // add date sliders ti limit actions
  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.item_actions_history,
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Text(
                  AppLocalizations.of(context)!.all,
                  style: TextStyle(
                    color: tabBarIconColor,
                    fontSize: 18,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.remove,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.compare_arrows,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            ],
            onTap: _filterActions,
            indicatorColor: tabBarIconColor,
          ),
        ),
        body: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (filteredActions != null && filteredActions!.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    itemCount: filteredActions!.length,
                    itemBuilder: (context, index) => ItemActionListTile(
                      action: filteredActions![index],
                      isDashboardTile: true,
                    ),
                  ),
                if (filteredActions != null && filteredActions!.isEmpty)
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      AppLocalizations.of(context)!
                          .no_actions_in_selected_locations,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
