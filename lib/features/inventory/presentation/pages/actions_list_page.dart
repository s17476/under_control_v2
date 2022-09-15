import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/item.dart';
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

  @override
  void didChangeDependencies() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      _currentUser = currentState.userProfile;
    }
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.item_actions_history,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ItemActionBloc, ItemActionState>(
        builder: (context, state) {
          if (state is ItemActionLoadedState) {
            final actions = state.allActions.allItemActions.reversed.toList();
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 16,
                left: 8,
                right: 8,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                return ItemActionListTile(action: actions[index]);
              },
            );
            // actions not loaded yet
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
