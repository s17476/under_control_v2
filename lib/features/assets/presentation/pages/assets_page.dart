import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../domain/entities/asset.dart';
import '../../utils/asset_status.dart';
import '../../utils/get_asset_status_icon.dart';
import '../../utils/search_assets.dart';
import '../blocs/asset/asset_bloc.dart';
import '../widgets/asset_tile.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({
    Key? key,
    required this.searchQuery,
    required this.searchBoxHeight,
    required this.isSearchBoxExpanded,
  }) : super(key: key);

  final String searchQuery;
  final double searchBoxHeight;
  final bool isSearchBoxExpanded;

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> with ResponsiveSize {
  List<Asset>? _assets;
  List<Asset>? _filteredAssets;
  int _index = 0;
  List<Asset> _inUse = [];
  List<Asset> _inReserve = [];

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  void _filterAssets() {
    switch (_index) {
      case 0:
        _filteredAssets = _assets;
        break;
      case 1:
        _filteredAssets = _assets
            ?.where((asset) => asset.currentStatus == AssetStatus.ok)
            .toList();
        break;
      case 2:
        _filteredAssets = _assets
            ?.where((asset) =>
                asset.currentStatus == AssetStatus.workingRequiresAttention)
            .toList();
        break;
      case 3:
        _filteredAssets = _assets
            ?.where((asset) =>
                asset.currentStatus == AssetStatus.notWorkingRequiresReparation)
            .toList();
        break;
      case 4:
        _filteredAssets = _assets
            ?.where((asset) => asset.currentStatus == AssetStatus.noInspection)
            .toList();
        break;
      default:
        _filteredAssets = _assets;
        break;
    }
    if (_filteredAssets != null) {
      _inUse.clear();
      _inReserve.clear();

      _inUse = _filteredAssets!.where((asset) => asset.isInUse).toList();
      _inReserve = _filteredAssets!.where((asset) => !asset.isInUse).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.assets,
      premissionType: PremissionType.read,
    );
    return DefaultTabController(
      length: 5,
      child: CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: !premission
                ? Column(
                    children: [
                      SizedBox(
                        height: responsiveSizeVerticalPct(small: 40),
                      ),
                      SizedBox(
                        child: Text(
                          AppLocalizations.of(context)!
                              .premission_no_premission,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        duration: const Duration(milliseconds: 300),
                        height: widget.isSearchBoxExpanded
                            ? widget.searchBoxHeight + 4
                            : 0,
                      ),
                      Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        child: TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.all_inclusive,
                                size: tabBarIconSize,
                                color: tabBarIconColor,
                              ),
                            ),
                            Tab(
                              icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: getAssetStatusIcon(
                                  context,
                                  AssetStatus.ok,
                                  14,
                                ),
                              ),
                            ),
                            Tab(
                              icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: getAssetStatusIcon(
                                  context,
                                  AssetStatus.workingRequiresAttention,
                                  14,
                                ),
                              ),
                            ),
                            Tab(
                              icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: getAssetStatusIcon(
                                  context,
                                  AssetStatus.notWorkingRequiresReparation,
                                  14,
                                ),
                              ),
                            ),
                            Tab(
                              icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: getAssetStatusIcon(
                                  context,
                                  AssetStatus.noInspection,
                                  14,
                                ),
                              ),
                            ),
                          ],
                          onTap: _setIndex,
                          indicatorColor: tabBarIconColor,
                        ),
                      ),
                      // assets list
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          if (state is AssetLoadedState) {
                            if (state.allAssets.allAssets.isEmpty) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                        responsiveSizeVerticalPct(small: 40),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.item_no_items,
                                  ),
                                ],
                              );
                            }
                            _assets = searchAssets(
                              context,
                              state.allAssets.allAssets,
                              widget.searchQuery,
                            );
                            _filterAssets();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // inUse
                                if (_inUse.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .assets_in_use,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _inUse.length,
                                        itemBuilder: (context, index) =>
                                            AssetTile(
                                          asset: _inUse[index],
                                          searchQuery: widget.searchQuery,
                                        ),
                                      ),
                                    ],
                                  ),
                                // published instructions
                                if (_inReserve.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (_inReserve.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .assets_not_in_use,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _inReserve.length,
                                        itemBuilder: (context, index) =>
                                            AssetTile(
                                          asset: _inReserve[index],
                                          searchQuery: widget.searchQuery,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          } else {
                            // shows shimmer when loading
                            return ListView.separated(
                              padding: const EdgeInsets.only(top: 4),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 4,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 8,
                              itemBuilder: (context, index) =>
                                  const ShimmerItemTile(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
