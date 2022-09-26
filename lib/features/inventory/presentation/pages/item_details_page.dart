import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/item_details/item_actions_tab.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/item_details/item_info_tab.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/item_details/item_locations_tab.dart';
import 'package:under_control_v2/features/inventory/utils/show_item_delete_dialog.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/item.dart';
import '../../utils/get_item_total_quantity.dart';
import '../../utils/item_action_management_bloc_listener.dart';
import '../../utils/item_management_bloc_listener.dart';
import '../blocs/item_action/item_action_bloc.dart';
import '../blocs/item_action_management/item_action_management_bloc.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';
import 'add_item_page.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/inventory/item-details';

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> with ResponsiveSize {
  Item? item;
  late UserProfile _currentUser;

  late Widget locationsTab;

  List<Choice> _choices = [];

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
        // popup menu items
        _choices = [
          // edit item
          Choice(
            title: AppLocalizations.of(context)!.edit,
            icon: Icons.edit,
            onTap: () => Navigator.pushNamed(
              context,
              AddItemPage.routeName,
              arguments: item,
            ),
          ),
          if (_currentUser.administrator)
            Choice(
              title: AppLocalizations.of(context)!.delete,
              icon: Icons.delete,
              onTap: () async {
                if (getItemTotalQuantity(item!) > 0) {
                  showSnackBar(
                    context: context,
                    message: AppLocalizations.of(context)!
                        .item_details_cannot_delete,
                    isErrorMessage: true,
                  );
                } else {
                  final result =
                      await showItemDeleteDialog(context: context, item: item!);
                  if (result != null && result) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
        ];
        // gets last actions for selected item
        context.read<ItemActionBloc>().add(
              GetLastFiveItemActionsEvent(
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
    String appBarTitle = '';
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;

    appBarTitle = AppLocalizations.of(context)!.item_details_title;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          actions: [
            // popup menu
            if (_currentUser.administrator)
              PopupMenuButton<Choice>(
                onSelected: (Choice choice) {
                  choice.onTap();
                },
                itemBuilder: (BuildContext context) {
                  return _choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(choice.icon),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            choice.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.info,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.work_history,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.location_on,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            ],
            indicatorColor: tabBarIconColor,
          ),
        ),
        body: item == null
            ? const LoadingWidget()
            : MultiBlocListener(
                listeners: [
                  BlocListener<ItemsManagementBloc, ItemsManagementState>(
                    listener: (context, state) =>
                        itemManagementBlocListener(context, state),
                  ),
                  BlocListener<ItemActionManagementBloc,
                      ItemActionManagementState>(
                    listener: (context, state) =>
                        itemActionManagementBlocListener(context, state),
                  ),
                ],
                child: TabBarView(
                  children: [
                    ItemInfoTab(item: item!),
                    ItemActionsTab(item: item!),
                    ItemLocationsTab(item: item!),
                  ],
                ),
              ),
      ),
    );
  }
}
