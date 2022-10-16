import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../inventory/domain/entities/item.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/actions/shimmer_item_action_list_tile.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/utils/get_item_quantity_in_locations.dart';

class AllLowLevelItemsPage extends StatefulWidget {
  const AllLowLevelItemsPage({Key? key}) : super(key: key);

  static const routeName = 'dashboard/all-low-level-items';

  @override
  State<AllLowLevelItemsPage> createState() => _AllLowLevelItemsPageState();
}

class _AllLowLevelItemsPageState extends State<AllLowLevelItemsPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.quantity_low_level),
        centerTitle: true,
      ),
      body: Stack(
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
              itemBuilder: (context, index) => const ShimmerItemActionListTile(
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
                AppLocalizations.of(context)!.no_actions_in_selected_locations,
              ),
            ),
        ],
      ),
    );
  }
}
