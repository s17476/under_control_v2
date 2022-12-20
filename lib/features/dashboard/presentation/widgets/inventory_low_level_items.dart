import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../inventory/domain/entities/item.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/actions/shimmer_item_action_list_tile.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/utils/get_item_quantity_in_locations.dart';
import '../pages/all_low_level_items_page.dart';

class InventoryLowLevelItems extends StatefulWidget {
  const InventoryLowLevelItems({Key? key}) : super(key: key);

  @override
  State<InventoryLowLevelItems> createState() => _InventoryLowLevelItemsState();
}

class _InventoryLowLevelItemsState extends State<InventoryLowLevelItems> {
  List<Item>? _items;

  late StreamSubscription _filterStreamSubscription;

  @override
  void didChangeDependencies() {
    _filterStreamSubscription =
        context.watch<FilterBloc>().stream.listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    final itemsState = context.watch<ItemsBloc>().state;
    if (itemsState is ItemsLoadedState) {
      _items = itemsState.allItems.allItems
          .where((item) => item.alertQuantity != null)
          .toList();
      // _items = _items!
      //     .where((item) => item.alertQuantity! >= getItemTotalQuantity(item))
      //     .toList();
      _items = _items!
          .where((item) =>
              item.alertQuantity! >=
              getItemQuantityInLocations(context, item, false))
          .toList();
      if (_items != null && _items!.length > 5) {
        _items = _items!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _filterStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.inventory,
      permissionType: PermissionType.read,
    );
    return !permission
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Colors.orange.shade700.withAlpha(100),
                    //     Colors.orange.withAlpha(30),
                    //   ],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 4,
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: IconTitleRow(
                        icon: Icons.apps,
                        iconColor: Colors.white,
                        iconBackground: Colors.orange,
                        title:
                            '${AppLocalizations.of(context)!.bottom_bar_title_inventory} - ${AppLocalizations.of(context)!.quantity_low_level}',
                      ),
                    ),
                    if (_items != null && _items!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AllLowLevelItemsPage.routeName,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Text(AppLocalizations.of(context)!.show_all),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    if (_items == null)
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade700.withAlpha(150),
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                    stops: const [0, 0.005],
                  ),
                ),
                child: Column(
                  children: [
                    if (_items == null)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            const ShimmerItemActionListTile(
                          isDashboardTile: true,
                        ),
                      ),
                    if (_items != null && _items!.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _items!.length,
                        itemBuilder: (context, index) => ItemTile(
                          item: _items![index],
                          searchQuery: '',
                        ),
                      ),
                    if (_items != null && _items!.isEmpty)
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
            ],
          );
  }
}
