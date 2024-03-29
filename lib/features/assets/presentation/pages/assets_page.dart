import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
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
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.assets,
      permissionType: PermissionType.read,
    );
    if (!permission) {
      return Column(
        children: [
          SizedBox(
            height: responsiveSizeVerticalPct(small: 40),
          ),
          SizedBox(
            child: Text(
              AppLocalizations.of(context)!.permission_no_permission,
            ),
          ),
        ],
      );
    }
    return DefaultTabController(
      length: 5,
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          if (state is FilterLoadedState && state.locations.isNotEmpty) {
            return BlocBuilder<AssetBloc, AssetState>(
                builder: (context, state) {
              if (state is AssetLoadedState) {
                // Assets loaded, but list is empty
                if (state.allAssets.allAssets.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: responsiveSizeVerticalPct(small: 40),
                      ),
                      Text(
                        AppLocalizations.of(context)!.item_no_items,
                      ),
                    ],
                  );
                }

                // Assets loaded
                _assets = searchAssets(
                  context,
                  state.allAssets.allAssets,
                  widget.searchQuery,
                );
                _filterAssets();
                return ListView(
                  children: [
                    // Empty space under search bar
                    AnimatedContainer(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      duration: const Duration(milliseconds: 300),
                      height: widget.isSearchBoxExpanded
                          ? widget.searchBoxHeight
                          : 0,
                    ),
                    Container(
                      height: 4,
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    // TabBar
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
                    // Assets in use
                    if (_inUse.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.assets_in_use,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ..._inUse.map(
                      (asset) => AssetTile(
                        key: ValueKey(asset.id),
                        asset: asset,
                        searchQuery: widget.searchQuery,
                      ),
                    ),
                    // Assets in reserve
                    if (_inReserve.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.assets_not_in_use,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ..._inReserve.map(
                      (asset) => AssetTile(
                        key: ValueKey(asset.id),
                        asset: asset,
                        searchQuery: widget.searchQuery,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              }
              // shows shimmer while loading assets
              return ListView.separated(
                padding: const EdgeInsets.only(top: 4),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                itemCount: 8,
                itemBuilder: (context, index) => const ShimmerItemTile(),
              );
            });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
