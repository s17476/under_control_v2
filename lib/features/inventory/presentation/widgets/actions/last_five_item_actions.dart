import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';

import 'package:under_control_v2/features/inventory/presentation/pages/actions_list_page.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../domain/entities/item.dart';
import '../../blocs/item_action/item_action_bloc.dart';
import 'item_action_list_tile.dart';

class LastFiveItemActions extends StatelessWidget {
  const LastFiveItemActions({
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
            List<ItemAction> actions =
                state.allActions.allItemActions.reversed.toList();
            if (actions.length > 5) {
              actions = actions.sublist(0, 4);
            }
            return Column(
              children: [
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
                  physics: const NeverScrollableScrollPhysics(),
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
