import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/icon_title_row.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/actions/item_action_list_tile.dart';

import '../../../inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';

class InventoryLatestActions extends StatelessWidget {
  const InventoryLatestActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardItemActionBloc, DashboardItemActionState>(
      builder: (context, state) {
        if (state is DashboardItemActionLoadedState) {
          return Column(
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
                            '${AppLocalizations.of(context)!.bottom_bar_title_inventory} - ${AppLocalizations.of(context)!.latest_actions}',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allActions.allItemActions.length,
                  itemBuilder: (context, index) => ItemActionListTile(
                    action: state.allActions.allItemActions[index],
                    isDashboardTile: true,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
