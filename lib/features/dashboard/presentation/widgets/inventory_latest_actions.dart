import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../inventory/domain/entities/item_action/item_action.dart';
import '../../../inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';
import '../../../inventory/presentation/widgets/actions/item_action_list_tile.dart';
import '../../../inventory/presentation/widgets/actions/shimmer_item_action_list_tile.dart';
import '../pages/all_actions_list_page.dart';

class InventoryLatestActions extends StatefulWidget {
  const InventoryLatestActions({Key? key}) : super(key: key);

  @override
  State<InventoryLatestActions> createState() => _InventoryLatestActionsState();
}

class _InventoryLatestActionsState extends State<InventoryLatestActions> {
  List<ItemAction>? _actions;

  @override
  void didChangeDependencies() {
    final actionsState = context.watch<DashboardItemActionBloc>().state;
    if (actionsState is DashboardItemActionLoadedState) {
      _actions = actionsState.allActions.allItemActions.toList();
      if (_actions != null && _actions!.length > 5) {
        _actions = _actions!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('Dash - InventoryLatestActions');
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
                            '${AppLocalizations.of(context)!.bottom_bar_title_inventory} - ${AppLocalizations.of(context)!.item_details_latest_actions}',
                      ),
                    ),
                    if (_actions != null && _actions!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AllActionsListPage.routeName,
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
                    if (_actions == null)
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
                    if (_actions == null)
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
                    if (_actions != null && _actions!.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _actions!.length,
                        itemBuilder: (context, index) => ItemActionListTile(
                          action: _actions![index],
                          isDashboardTile: true,
                        ),
                      ),
                    if (_actions != null && _actions!.isEmpty)
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
