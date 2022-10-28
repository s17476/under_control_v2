import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action/asset_action_bloc.dart';

import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/entities/asset.dart';
import '../../../domain/entities/asset_action/asset_action.dart';
import '../../blocs/asset/asset_bloc.dart';
import 'asset_action_tile.dart';
import 'shimmer_asset_action_list_tile.dart';

class AssetActionsListPage extends StatefulWidget {
  const AssetActionsListPage({Key? key}) : super(key: key);

  static const routeName = '/asset-details/actions-list';

  @override
  State<AssetActionsListPage> createState() => _AssetActionsListPageState();
}

class _AssetActionsListPageState extends State<AssetActionsListPage>
    with ResponsiveSize {
  Asset? _asset;
  late UserProfile _currentUser;
  List<AssetAction>? _actions;

  @override
  void initState() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      _currentUser = currentState.userProfile;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // gets selected asset
    final assetId = (ModalRoute.of(context)?.settings.arguments as Asset).id;
    final assetsState = context.watch<AssetBloc>().state;
    if (assetsState is AssetLoadedState && _asset == null) {
      _asset = assetsState.getAssetById(assetId);
      // fetch actions
      if (_asset != null) {
        context.read<AssetActionBloc>().add(
              GetAssetActionsEvent(
                asset: AssetModel.fromAsset(_asset!),
                companyId: _currentUser.companyId,
              ),
            );
      }
    }
    final actionsState = context.watch<AssetActionBloc>().state;
    if (actionsState is AssetActionLoadedState && actionsState.isAllItems) {
      _actions = actionsState.allActions.allAssetActions.toList();
      print('asset ok');
      print(_actions!.length);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.item_actions_history,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_actions != null)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _actions!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: AssetActionTile(
                    action: _actions![index],
                    isAddAction: index == _actions!.length - 1,
                  ),
                ),
              ),
            if (_actions == null)
              ListView.builder(
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
              ),
          ],
        ),
      ),
    );
  }
}
