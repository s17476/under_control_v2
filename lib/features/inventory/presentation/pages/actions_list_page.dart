import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

class _ActionsListPageState extends State<ActionsListPage> {
  Item? item;
  late UserProfile _currentUser;
  List<ItemAction>? actions;
  List<ItemAction>? filteredActions;

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

        // gets item actions
        context.read<ItemActionBloc>().add(
              GetItemActionsEvent(
                item: item!,
                companyId: _currentUser.companyId,
              ),
            );
      }
    }
    //
    final actionsState = context.watch<ItemActionBloc>().state;
    if (actionsState is ItemActionLoadedState) {
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
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 16,
              left: 8,
              right: 8,
            ),
            itemCount: filteredActions!.length,
            itemBuilder: (context, index) {
              return ItemActionListTile(action: filteredActions![index]);
            },
          ),
        ),
      ),
    );
  }
}
