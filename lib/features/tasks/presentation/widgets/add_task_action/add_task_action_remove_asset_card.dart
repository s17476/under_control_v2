import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/pages/select_new_assets_data_page.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../assets/presentation/blocs/asset_parts/asset_parts_bloc.dart';
import '../../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';

class AddTaskActionRemoveAssetCard extends StatelessWidget {
  const AddTaskActionRemoveAssetCard({
    Key? key,
    required this.toggleRemovedAssets,
    required this.assetsToRemove,
  }) : super(key: key);

  final Function(AssetModel) toggleRemovedAssets;
  final List<AssetModel> assetsToRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.task_action_remove_assets,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.task_connected_asset,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.asset_spare_parts,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    BlocBuilder<AssetPartsBloc, AssetPartsState>(
                      builder: (context, state) {
                        if (state is AssetPartsLoadedState) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.allAssetParts.allAssets.length,
                            itemBuilder: (context, index) {
                              final asset =
                                  state.allAssetParts.allAssets[index];
                              return AssetToRemoveTile(
                                asset: AssetModel.fromAsset(asset),
                                toggleRemovedAssets: toggleRemovedAssets,
                                isRemoved: assetsToRemove
                                    .map((e) => e.id)
                                    .contains(asset.id),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) =>
                                const ShimmerAssetActionListTile(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AssetToRemoveTile extends StatelessWidget {
  const AssetToRemoveTile({
    Key? key,
    required this.asset,
    required this.toggleRemovedAssets,
    required this.isRemoved,
  }) : super(key: key);

  final AssetModel asset;
  final Function(AssetModel) toggleRemovedAssets;
  final bool isRemoved;

  void selectNewDataAndRemove(BuildContext context) async {
    if (isRemoved) {
      toggleRemovedAssets(asset);
    } else {
      final updatedAsset = await Navigator.pushNamed(
        context,
        SelectNewAssetDataPage.routeName,
        arguments: asset,
      );
      await Future.delayed(const Duration(milliseconds: 300));
      if (updatedAsset != null && updatedAsset is AssetModel) {
        toggleRemovedAssets(updatedAsset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = 15.0;
    const margin = EdgeInsets.symmetric(vertical: 4, horizontal: 8);
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          margin: margin,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color:
                isRemoved ? Colors.red.shade900 : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: () => selectNewDataAndRemove(context),
            child: IgnorePointer(
              child: AssetTile(
                asset: asset,
                searchQuery: '',
                backgroundColor: Colors.transparent,
                borderRadius: borderRadius,
                margin: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        if (isRemoved)
          Icon(
            Icons.delete,
            size: 80,
            color: Colors.grey.shade200,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 25,
              )
            ],
          ),
      ],
    );
  }
}
