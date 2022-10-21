import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_tile.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../blocs/asset/asset_bloc.dart';
import '../blocs/asset_category/asset_category_bloc.dart';

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
  final List<Asset> _inUse = [];
  final List<Asset> _inReserve = [];

  void _filterAssets(int index) {
    _index = index;
    print(_index);
    switch (index) {
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
                asset.currentStatus == AssetStatus.workingRequiresReparation)
            .toList();
        break;
      case 4:
        _filteredAssets = _assets
            ?.where((asset) =>
                asset.currentStatus == AssetStatus.notWorkingRequiresReparation)
            .toList();
        break;
      default:
        _filteredAssets = _assets;
        break;
    }
    if (_filteredAssets != null) {
      for (var asset in _filteredAssets!) {
        if (asset.isInUse) {
          setState(() {
            _inUse.add(asset);
          });
        } else {
          setState(() {
            _inReserve.add(asset);
          });
        }
      }
    }
  }

  List<Asset> _search(
    BuildContext context,
    List<Asset> allAssets,
    String searchQuery,
  ) {
    if (searchQuery.trim().isNotEmpty) {
      final categoryState = context.read<AssetCategoryBloc>().state;
      if (categoryState is AssetCategoryLoadedState) {
        return allAssets
            .where(
              (asset) =>
                  asset.producer
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  asset.model
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  asset.internalCode
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  asset.barCode
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  categoryState
                      .getAssetCategoryById(asset.categoryId)!
                      .name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()),
            )
            .toList();
      }
    }
    return allAssets;
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
                        duration: const Duration(milliseconds: 300),
                        height: widget.isSearchBoxExpanded
                            ? widget.searchBoxHeight + 4
                            : 0,
                      ),
                      TabBar(
                        tabs: [
                          Tab(
                            icon: Text(
                              AppLocalizations.of(context)!.all,
                              style: TextStyle(
                                color: tabBarIconColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.add,
                              color: tabBarIconColor,
                              size: tabBarIconSize,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.remove,
                              color: tabBarIconColor,
                              size: tabBarIconSize,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.compare_arrows,
                              color: tabBarIconColor,
                              size: tabBarIconSize,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.compare_arrows,
                              color: tabBarIconColor,
                              size: tabBarIconSize,
                            ),
                          ),
                        ],
                        onTap: _filterAssets,
                        indicatorColor: tabBarIconColor,
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
                            _assets = _search(
                              context,
                              state.allAssets.allAssets,
                              widget.searchQuery,
                            );
                            print('jaki index');
                            print(_index);
                            if (_index == 0) {
                              for (var asset in _assets!) {
                                if (asset.isInUse) {
                                  _inUse.add(asset);
                                } else {
                                  _inReserve.add(asset);
                                }
                              }
                            }
                            // TO DO
                            print(_inUse);
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
                                  // TODO build new shimmer
                                  const ShimmerInstructionTile(),
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
