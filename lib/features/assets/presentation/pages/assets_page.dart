import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_tile.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../blocs/asset/asset_bloc.dart';
import '../blocs/asset_category/asset_category_bloc.dart';

class AssetsPage extends StatelessWidget with ResponsiveSize {
  const AssetsPage({
    Key? key,
    required this.searchQuery,
    required this.searchBoxHeight,
    required this.isSearchBoxExpanded,
  }) : super(key: key);

  final String searchQuery;
  final double searchBoxHeight;
  final bool isSearchBoxExpanded;

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
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.assets,
      premissionType: PremissionType.read,
    );
    return CustomScrollView(
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
                        AppLocalizations.of(context)!.premission_no_premission,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isSearchBoxExpanded ? searchBoxHeight + 4 : 0,
                    ),
                    // assets list
                    BlocBuilder<AssetBloc, AssetState>(
                      builder: (context, state) {
                        if (state is AssetLoadedState) {
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
                          final filteredAssets = _search(
                            context,
                            state.allAssets.allAssets,
                            searchQuery,
                          );
                          final List<Asset> inUse = [];
                          final List<Asset> inReserve = [];
                          for (var asset in filteredAssets) {
                            if (asset.isInUse) {
                              inUse.add(asset);
                            } else {
                              inReserve.add(asset);
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // inUse
                              if (inUse.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      itemCount: inUse.length,
                                      itemBuilder: (context, index) =>
                                          AssetTile(
                                        asset: inUse[index],
                                        searchQuery: searchQuery,
                                      ),
                                    ),
                                  ],
                                ),
                              // published instructions
                              if (inReserve.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (inReserve.isNotEmpty)
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
                                      itemCount: inReserve.length,
                                      itemBuilder: (context, index) =>
                                          AssetTile(
                                        asset: inReserve[index],
                                        searchQuery: searchQuery,
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
    );
  }
}
