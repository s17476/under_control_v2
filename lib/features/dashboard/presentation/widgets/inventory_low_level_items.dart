import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../inventory/domain/entities/item.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/actions/shimmer_item_action_list_tile.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/utils/get_item_quantity_in_locations.dart';

class InventoryLowLevelItems extends StatefulWidget {
  const InventoryLowLevelItems({Key? key}) : super(key: key);

  @override
  State<InventoryLowLevelItems> createState() => _InventoryLowLevelItemsState();
}

class _InventoryLowLevelItemsState extends State<InventoryLowLevelItems> {
  List<Item>? _items;

  @override
  void didChangeDependencies() {
    final itemsState = context.watch<ItemsBloc>().state;
    if (itemsState is ItemsLoadedState) {
      _items = itemsState.allItems.allItems
          .where((item) => item.alertQuantity != null)
          .toList();
      _items = _items!
          .where((item) =>
              item.alertQuantity! >= getItemQuantityInLocations(context, item))
          .toList();
      if (_items != null && _items!.length > 5) {
        _items = _items!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.inventory,
      premissionType: PremissionType.read,
    );
    return !premission
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
                        iconBackground: Theme.of(context).primaryColor,
                        title:
                            '${AppLocalizations.of(context)!.bottom_bar_title_inventory} - ${AppLocalizations.of(context)!.quantity_low_level}',
                      ),
                    ),
                    if (_items != null && _items!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   AllActionsListPage.routeName,
                          // );
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
              Column(
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
            ],
          );
  }
}
