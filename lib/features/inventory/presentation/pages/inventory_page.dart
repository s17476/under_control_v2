import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/item_tile.dart';
import 'package:under_control_v2/features/inventory/utils/item_management_bloc_listener.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';

class InventoryPage extends StatelessWidget with ResponsiveSize {
  const InventoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsManagementBloc, ItemsManagementState>(
      listener: (context, state) => itemManagementBlocListener(context, state),
      child: CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                BlocBuilder<ItemsBloc, ItemsState>(
                  builder: (context, state) {
                    if (state is ItemsLoadedState) {
                      if (state.allItems.allItems.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: responsiveSizeVerticalPct(small: 40),
                            ),
                            Text(AppLocalizations.of(context)!.item_no_items),
                          ],
                        );
                      }
                      final filteredItems = state.allItems.allItems;
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 2),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return ItemTile(item: filteredItems[index]);
                        },
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: responsiveSizeVerticalPct(small: 40),
                          ),
                          const CircularProgressIndicator(),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
