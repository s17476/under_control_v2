import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/asset_action_tile.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/actions/shimmer_item_action_list_tile.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/shimmer_item_tile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../../core/presentation/widgets/cached_pdf_viewer.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/entities/asset.dart';
import '../../../domain/entities/asset_action/asset_action.dart';
import '../../blocs/asset_action/asset_action_bloc.dart';
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
    return BlocBuilder<AssetActionBloc, AssetActionState>(
      builder: (context, state) {
        if (state is AssetActionLoadedState) {
          List<AssetAction> actions = [];
          if (state.allActions.allAssetActions.length > 5) {
            actions = state.allActions.allAssetActions.sublist(0, 4);
          } else {
            actions = state.allActions.allAssetActions;
          }
          // actions loaded
          return ListView.builder(
            shrinkWrap: true,
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
          );
        }
        // actions loading
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: ShimmerItemTile()),
        );
      },
    );
  }
}
