import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/domain/entities/asset_action/asset_action.dart';
import '../../../assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart';
import '../../../assets/presentation/widgets/asset_details/asset_action_tile.dart';
import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../pages/all_asset_actions_page.dart';

class AssetsLatestActions extends StatefulWidget {
  const AssetsLatestActions({Key? key}) : super(key: key);

  @override
  State<AssetsLatestActions> createState() => _AssetsLatestActionsState();
}

class _AssetsLatestActionsState extends State<AssetsLatestActions> {
  List<AssetAction>? _actions;

  @override
  void didChangeDependencies() {
    final actionsState = context.watch<DashboardAssetActionBloc>().state;
    if (actionsState is DashboardAssetActionLoadedState) {
      _actions = actionsState.allActions.allAssetActions.toList();
      if (_actions != null && _actions!.length > 5) {
        _actions = _actions!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.assets,
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
                    // color: Theme.of(context).appBarTheme.backgroundColor,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade900.withAlpha(150),
                        Colors.blue.withAlpha(30),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                        icon: Icons.precision_manufacturing,
                        iconColor: Colors.white,
                        iconBackground: Colors.blue,
                        title:
                            '${AppLocalizations.of(context)!.bottom_bar_title_assets} - ${AppLocalizations.of(context)!.item_details_latest_actions}',
                      ),
                    ),
                    if (_actions != null && _actions!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AllAssetActionsListPage.routeName,
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
              Column(
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
                          const ShimmerAssetActionListTile(
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
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: AssetActionTile(
                          action: _actions![index],
                          isDashboardTile: true,
                        ),
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
            ],
          );
  }
}
