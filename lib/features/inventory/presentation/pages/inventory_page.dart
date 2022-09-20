import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/item_tile.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';

class InventoryPage extends StatelessWidget with ResponsiveSize {
  const InventoryPage({
    Key? key,
    required this.inventorySearchTextEditingController,
  }) : super(key: key);

  final TextEditingController inventorySearchTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsManagementBloc, ItemsManagementState>(
      listener: (context, state) {
        if (state is ItemsManagementSuccessState) {
          String message = '';
          switch (state.message) {
            case ItemsMessage.itemAdded:
              message = AppLocalizations.of(context)!.item_add_added_new_msg;
              break;
            case ItemsMessage.itemInUse:
              message = AppLocalizations.of(context)!
                  .group_management_delete_error_not_empty;
              break;
            case ItemsMessage.itemUpdated:
              message = AppLocalizations.of(context)!.update_success;
              break;
            case ItemsMessage.itemDeleted:
              message = AppLocalizations.of(context)!.delete_success;
              break;
            default:
              message = '';
          }
          if (message.isNotEmpty) {
            showSnackBar(
              context: context,
              message: message,
              isErrorMessage: state.error,
            );
          }
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
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
      ),
    );
  }
}
