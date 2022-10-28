import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/asset_action_tile.dart';
import 'package:under_control_v2/features/core/presentation/widgets/icon_title_mini_row.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/actions/shimmer_item_action_list_tile.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/shimmer_item_tile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../../core/presentation/widgets/cached_pdf_viewer.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/entities/asset.dart';
import '../../../domain/entities/asset_action/asset_action.dart';
import '../../blocs/asset_action/asset_action_bloc.dart';
import 'asset_actions_list_page.dart';
import 'shimmer_asset_action_list_tile.dart';

class AssetHistoryTab extends StatefulWidget {
  const AssetHistoryTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  State<AssetHistoryTab> createState() => _AssetHistoryTabState();
}

class _AssetHistoryTabState extends State<AssetHistoryTab> {
  @override
  void didChangeDependencies() {
    final userState = context.read<UserProfileBloc>().state;
    if (userState is Approved) {
      context.read<AssetActionBloc>().add(
            GetLastFiveAssetActionsEvent(
              asset: AssetModel.fromAsset(widget.asset),
              companyId: userState.userProfile.companyId,
            ),
          );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AssetActionBloc, AssetActionState>(
        builder: (context, state) {
          if (state is AssetActionLoadedState) {
            List<AssetAction> actions = [];
            if (state.allActions.allAssetActions.length > 5) {
              actions = state.allActions.allAssetActions.sublist(0, 4);
            } else {
              actions = state.allActions.allAssetActions;
            }
            // actions loaded
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 16,
                    bottom: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconTitleRow(
                          title: AppLocalizations.of(context)!
                              .item_details_latest_actions,
                          icon: Icons.history,
                          iconColor: Colors.white,
                          iconBackground: Colors.black,
                        ),
                      ),
                      if (actions.isNotEmpty)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AssetActionsListPage.routeName,
                              arguments: widget.asset,
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: actions.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: AssetActionTile(
                      action: actions[index],
                      isAddAction: index == actions.length - 1,
                    ),
                  ),
                ),
              ],
            );
          }
          // actions loading
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: ShimmerAssetActionListTile(),
            ),
          );
        },
      ),
    );
  }
}
