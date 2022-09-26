import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';

import 'package:under_control_v2/features/inventory/presentation/pages/actions_list_page.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../domain/entities/item.dart';
import '../../../utils/get_item_total_quantity.dart';
import '../../blocs/item_action/item_action_bloc.dart';
import '../../pages/add_to_item_page.dart';
import '../../pages/move_inside_item_page.dart';
import '../../pages/subtract_from_item_page.dart';
import '../actions/item_action_list_tile.dart';

class ItemActionsTab extends StatelessWidget {
  const ItemActionsTab({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: BlocBuilder<ItemActionBloc, ItemActionState>(
        builder: (context, state) {
          if (state is ItemActionLoadedState) {
            List<ItemAction> actions = state.allActions.allItemActions.toList();
            if (actions.length > 5) {
              actions = actions.sublist(0, 5);
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: Row(
                    children: [
                      // add button
                      Expanded(
                        child: RoundedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AddToItemPage.routeName,
                              arguments: item,
                            );
                          },
                          icon: Icons.add,
                          iconSize: 40,
                          title: AppLocalizations.of(context)!.add,
                          titleSize: 16,
                          foregroundColor: Colors.grey.shade200,
                          padding: const EdgeInsets.all(16),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(60),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      // move button
                      Expanded(
                        child: RoundedButton(
                          onPressed: getItemTotalQuantity(item) > 0
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    MoveInsideItemPage.routeName,
                                    arguments: item,
                                  );
                                }
                              : () {},
                          icon: Icons.compare_arrows_outlined,
                          iconSize: 40,
                          title: AppLocalizations.of(context)!.move,
                          titleSize: 16,
                          foregroundColor: Colors.grey.shade200,
                          padding: const EdgeInsets.all(16),
                          gradient: LinearGradient(
                            colors: getItemTotalQuantity(item) > 0
                                ? [
                                    Colors.blue.shade700,
                                    Colors.blue.shade700.withAlpha(60),
                                  ]
                                : [
                                    Colors.grey,
                                    Colors.grey.withAlpha(60),
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),
                      // subtract button
                      Expanded(
                        child: RoundedButton(
                          onPressed: getItemTotalQuantity(item) > 0
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    SubtractFromItemPage.routeName,
                                    arguments: item,
                                  );
                                }
                              : () {},
                          icon: Icons.remove,
                          iconSize: 40,
                          title: AppLocalizations.of(context)!.subtract,
                          titleSize: 16,
                          foregroundColor: Colors.grey.shade200,
                          padding: const EdgeInsets.all(16),
                          gradient: LinearGradient(
                            colors: getItemTotalQuantity(item) > 0
                                ? [
                                    Colors.red.shade600,
                                    Colors.red.shade600.withAlpha(60),
                                  ]
                                : [
                                    Colors.grey,
                                    Colors.grey.withAlpha(60),
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                  indent: 8,
                  endIndent: 8,
                ),
                // title
                Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconTitleRow(
                          icon: Icons.history,
                          iconColor: Colors.white,
                          iconBackground: Colors.black,
                          title: actions.isNotEmpty
                              ? AppLocalizations.of(context)!
                                  .item_details_latest_actions
                              : AppLocalizations.of(context)!
                                  .item_details_no_actions,
                          titleFontSize: 16,
                        ),
                      ),
                      if (actions.isNotEmpty)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ActionsListPage.routeName,
                              arguments: item,
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
                    ],
                  ),
                ),
                // actions list

                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: actions.length,
                  itemBuilder: (context, index) {
                    return ItemActionListTile(action: actions[index]);
                  },
                ),
              ],
            );
            // actions not loaded yet
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: IconTitleRow(
                      icon: Icons.history,
                      iconColor: Colors.white,
                      iconBackground: Colors.black,
                      title: AppLocalizations.of(context)!
                          .item_details_loading_actions,
                      titleFontSize: 16,
                    ),
                  ),
                  const CircularProgressIndicator()
                  //
                  //
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
