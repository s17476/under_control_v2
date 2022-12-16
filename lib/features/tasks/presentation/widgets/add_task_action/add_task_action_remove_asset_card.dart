import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_tile.dart';

import '../../../../assets/presentation/blocs/asset_parts/asset_parts_bloc.dart';
import '../../../../core/utils/responsive_size.dart';

class AddTaskActionRemoveAssetCard extends StatefulWidget {
  const AddTaskActionRemoveAssetCard({
    Key? key,
    required this.toggleRemovedAssets,
    required this.assetsToRemove,
  }) : super(key: key);

  final Function(AssetModel) toggleRemovedAssets;
  final List<AssetModel> assetsToRemove;

  @override
  State<AddTaskActionRemoveAssetCard> createState() =>
      _AddTaskActionRemoveAssetCardState();
}

class _AddTaskActionRemoveAssetCardState
    extends State<AddTaskActionRemoveAssetCard>
    with ResponsiveSize, WidgetsBindingObserver {
  // bool _isVisible = true;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeMetrics() {
  //   final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
  //   final newValue = bottomInset == 0.0;
  //   if (newValue != _isVisible) {
  //     setState(() {
  //       _isVisible = newValue;
  //     });
  //   }
  //   if (_isVisible && mounted) {
  //     // FocusScope.of(context).unfocus();
  //   }
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
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
                                toggleRemovedAssets: widget.toggleRemovedAssets,
                                isRemoved:
                                    widget.assetsToRemove.contains(asset),
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
                    // TODO: assets list
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
            onTap: () => toggleRemovedAssets(asset),
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
