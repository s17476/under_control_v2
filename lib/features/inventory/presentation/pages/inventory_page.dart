import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/shimmer_item_tile.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../domain/entities/item.dart';
import '../blocs/item_category/item_category_bloc.dart';
import '../blocs/items/items_bloc.dart';
import '../widgets/item_tile.dart';

class InventoryPage extends StatelessWidget with ResponsiveSize {
  const InventoryPage({
    Key? key,
    required this.searchBoxHeight,
    required this.isSearchBoxExpanded,
    required this.searchQuery,
    required this.isSortedByCategory,
  }) : super(key: key);

  final double searchBoxHeight;
  final bool isSearchBoxExpanded;
  final String searchQuery;
  final bool isSortedByCategory;

  // search items according to given query string
  List<Item> _searchItems(
      BuildContext context, List<Item> items, String searchQuery) {
    if (searchQuery.trim().isNotEmpty) {
      final categoryState = context.read<ItemCategoryBloc>().state;
      if (categoryState is ItemCategoryLoadedState) {
        return items
            .where(
              (item) =>
                  item.producer
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  item.name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  item.itemCode
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  item.itemBarCode
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  categoryState
                      .getItemCategoryById(item.category)!
                      .name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()),
            )
            .toList();
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.inventory,
      permissionType: PermissionType.read,
    );
    if (!permission) {
      return Column(
        children: [
          SizedBox(
            height: responsiveSizeVerticalPct(small: 40),
          ),
          SizedBox(
            child: Text(
              AppLocalizations.of(context)!.permission_no_permission,
            ),
          ),
        ],
      );
    }
    return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
      if (state is FilterLoadedState && state.locations.isNotEmpty) {
        return BlocBuilder<ItemsBloc, ItemsState>(builder: (context, state) {
          if (state is ItemsLoadedState) {
            // Items loaded, but the list is empty
            if (state.allItems.allItems.isEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: responsiveSizeVerticalPct(small: 40),
                  ),
                  Text(
                    AppLocalizations.of(context)!.item_no_items,
                  ),
                ],
              );
            }
            // Items loaded
            final filteredItems = _searchItems(
              context,
              state.allItems.allItems,
              searchQuery,
            );
            return ListView(
              padding: const EdgeInsets.only(top: 8),
              children: [
                // Empty space under search bar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isSearchBoxExpanded ? searchBoxHeight : 0,
                ),
                ...filteredItems
                    .map(
                      (item) => ItemTile(
                        item: item,
                        searchQuery: searchQuery,
                      ),
                    )
                    .toList(),
                const SizedBox(
                  height: 100,
                ),
              ],
            );
          }
          // loading shimmer animation
          return ListView.builder(
            padding: const EdgeInsets.only(top: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return const ShimmerItemTile();
            },
          );
        });
      }
      return const SizedBox();
    });
  }
}
