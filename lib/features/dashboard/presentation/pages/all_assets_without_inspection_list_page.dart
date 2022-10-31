import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/domain/entities/asset.dart';
import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/widgets/asset_tile.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';

class AllAssetsWithoutInspectionListPage extends StatefulWidget {
  const AllAssetsWithoutInspectionListPage({Key? key}) : super(key: key);

  static const routeName = '/dashboard/all-assets-without-inspection-list';

  @override
  State<AllAssetsWithoutInspectionListPage> createState() =>
      _AllAssetsWithoutInspectionListPageState();
}

class _AllAssetsWithoutInspectionListPageState
    extends State<AllAssetsWithoutInspectionListPage> with ResponsiveSize {
  List<Asset>? _assets;

  @override
  void didChangeDependencies() {
    final assetssState = context.watch<AssetBloc>().state;
    if (assetssState is AssetLoadedState) {
      _assets = assetssState.allAssets.allAssets
          .where((asset) => asset.currentStatus == AssetStatus.noInspection)
          .toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.bottom_bar_title_assets,
          ),
          centerTitle: true,
        ),
        body: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // loading assets
                if (_assets == null)
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => const ShimmerItemTile(),
                  ),
                // assets loaded
                if (_assets != null && _assets!.isNotEmpty)
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _assets!.length,
                    itemBuilder: (context, index) => AssetTile(
                      asset: _assets![index],
                      searchQuery: '',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
