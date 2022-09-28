import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/item_action/item_action.dart';
import '../blocs/item_action/item_action_bloc.dart';
import '../blocs/items/items_bloc.dart';
import '../widgets/actions/item_action_list_tile.dart';

class ActionsListPage extends StatefulWidget {
  const ActionsListPage({Key? key}) : super(key: key);

  static const routeName = '/item-details/actions-list';

  @override
  State<ActionsListPage> createState() => _ActionsListPageState();
}

class _ActionsListPageState extends State<ActionsListPage> with ResponsiveSize {
  Item? item;
  late UserProfile _currentUser;
  List<ItemAction>? _actions;
  List<ItemAction>? _filteredActions;

  _filterActions(int index) {
    switch (index) {
      case 0:
        setState(() {
          _filteredActions = _actions;
        });
        break;
      case 1:
        setState(() {
          _filteredActions = _actions
              ?.where((action) => action.type == ItemActionType.add)
              .toList();
        });
        break;
      case 2:
        setState(() {
          _filteredActions = _actions
              ?.where((action) => action.type == ItemActionType.remove)
              .toList();
        });
        break;
      case 3:
        setState(() {
          _filteredActions = _actions
              ?.where((action) =>
                  action.type == ItemActionType.moveAdd ||
                  action.type == ItemActionType.moveRemove)
              .toList();
        });
        break;
      default:
        _filteredActions = _actions;
        break;
    }
  }

  @override
  void initState() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      _currentUser = currentState.userProfile;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // gets selected item
    final itemId = (ModalRoute.of(context)?.settings.arguments as Item).id;
    final itemsState = context.watch<ItemsBloc>().state;
    if (itemsState is ItemsLoadedState) {
      final index = itemsState.allItems.allItems
          .indexWhere((element) => element.id == itemId);
      if (index >= 0) {
        setState(() {
          item = itemsState.allItems.allItems[index];
        });
        if (_filteredActions == null) {
          // gets item actions
          context.read<ItemActionBloc>().add(
                GetItemActionsEvent(
                  item: item!,
                  companyId: _currentUser.companyId,
                ),
              );
        }
      }
    }
    //
    final actionsState = context.watch<ItemActionBloc>().state;
    if (actionsState is ItemActionLoadedState && actionsState.isAllItems) {
      _actions = actionsState.allActions.allItemActions.toList();
      _filteredActions = _actions;
    }
    super.didChangeDependencies();
  }

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
                if (_filteredActions != null && _filteredActions!.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    itemCount: _filteredActions!.length,
                    itemBuilder: (context, index) => ItemActionListTile(
                      action: _filteredActions![index],
                    ),
                  ),
                if (_filteredActions != null && _filteredActions!.isEmpty)
                  Container(
                    alignment: Alignment.center,
                    height: responsiveSizeVerticalPct(small: 90),
                    child: Text(
                      AppLocalizations.of(context)!
                          .no_actions_in_selected_locations,
                    ),
                  ),
                if (_filteredActions == null)
                  Container(
                    alignment: Alignment.center,
                    height: responsiveSizeVerticalPct(small: 90),
                    child: const CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
