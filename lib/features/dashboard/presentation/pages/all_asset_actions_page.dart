import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/domain/entities/asset_action/asset_action.dart';
import '../../../assets/presentation/blocs/dashboard_asset_action/dashboard_asset_action_bloc.dart';
import '../../../assets/presentation/widgets/asset_details/asset_action_tile.dart';
import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/utils/responsive_size.dart';

class AllAssetActionsListPage extends StatefulWidget {
  const AllAssetActionsListPage({Key? key}) : super(key: key);

  static const routeName = '/dashboard/all-asset-actions-list';

  @override
  State<AllAssetActionsListPage> createState() =>
      _AllAssetActionsListPageState();
}

class _AllAssetActionsListPageState extends State<AllAssetActionsListPage>
    with ResponsiveSize {
  List<AssetAction>? _actions;

  @override
  void initState() {
    // gets item actions
    context.read<DashboardAssetActionBloc>().add(
          GetDashboardAssetActionsEvent(),
        );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final actionsState = context.watch<DashboardAssetActionBloc>().state;
    if (actionsState is DashboardAssetActionLoadedState &&
        actionsState.isAllItems) {
      _actions = actionsState.allActions.allAssetActions.toList();
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
      body: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // actions loaded
              if (_actions != null)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  itemCount: _actions!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: AssetActionTile(
                      action: _actions![index],
                      isDashboardTile: true,
                    ),
                  ),
                ),
              if (_actions == null)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      const ShimmerAssetActionListTile(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
