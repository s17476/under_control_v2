import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../blocs/item_action/item_action_bloc.dart';
import 'quantity_location_list_tile.dart';

class LastFiveItemActions extends StatelessWidget {
  const LastFiveItemActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  title:
                      AppLocalizations.of(context)!.item_details_latest_actions,
                  titleFontSize: 16,
                ),
              ),
              //
              //
            ],
          ),
        ),
        // members list
        BlocBuilder<ItemActionBloc, ItemActionState>(
          builder: (context, state) {
            if (state is ItemActionLoadedState) {
              final actions = state.allActions.allItemActions.reversed.toList();
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        // action list tile
                        Expanded(
                          child: IconTitleRow(
                            icon: actions[index].type == ItemActionType.add
                                ? Icons.add
                                : Icons.remove,
                            iconColor: Colors.white,
                            iconBackground:
                                actions[index].type == ItemActionType.add
                                    ? Theme.of(context).primaryColor
                                    : Colors.red,
                            title: actions[index].description,
                          ),
                        ),
                        Text(actions[index].ammount.toString()),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
