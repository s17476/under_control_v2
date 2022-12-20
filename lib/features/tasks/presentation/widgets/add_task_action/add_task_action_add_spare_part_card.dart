import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_selection/overlay_asset_selection.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../assets/presentation/widgets/assets_spare_parts_list.dart';
import '../../../../core/utils/show_snack_bar.dart';

class AddTaskActionAddSparePartCard extends HookWidget {
  const AddTaskActionAddSparePartCard({
    Key? key,
    required this.toggleAssetSelection,
    required this.toggleReplacementAsset,
    required this.toggleAddAssetVisibility,
    required this.sparePartsAssets,
    required this.isAddAssetVisible,
    required this.isConnectedAssetReplaced,
    required this.replacementAsset,
  }) : super(key: key);

  final Function(String) toggleAssetSelection;
  final Function(AssetModel?) toggleReplacementAsset;
  final Function() toggleAddAssetVisibility;
  final List<String> sparePartsAssets;
  final bool isAddAssetVisible;
  final bool isConnectedAssetReplaced;
  final AssetModel? replacementAsset;

  void toggleAsset(BuildContext context, String assetId) {
    if (replacementAsset != null) {
      toggleReplacementAsset(null);
    } else {
      final assetState = context.read<AssetBloc>().state;
      if (assetState is AssetLoadedState) {
        final asset = assetState.getAssetById(assetId);
        if (asset != null) {
          final assetModel = AssetModel.fromAsset(asset);
          toggleReplacementAsset(assetModel);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showOnlySubAssets = useState(true);
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
                        AppLocalizations.of(context)!.task_action_add_assets,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (isConnectedAssetReplaced) ...[
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .task_connected_asset,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                              if (replacementAsset != null)
                                AssetTile(
                                  asset: replacementAsset!,
                                  searchQuery: '',
                                  onSelected: (assetId) =>
                                      toggleAsset(context, assetId),
                                  isSelected: true,
                                ),
                              if (replacementAsset == null)
                                AddReplacementAssetButton(
                                  showOnlySubAssets: showOnlySubAssets,
                                  toggleAddAssetVisibility:
                                      toggleAddAssetVisibility,
                                ),
                            ],
                            AssetsSparePartsList(
                              items: sparePartsAssets,
                              onSelected: toggleAssetSelection,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 58,
          right: 16,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            onPressed: () {
              showOnlySubAssets.value = true;
              toggleAddAssetVisibility();
            },
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.precision_manufacturing,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.asset_add_spare_parts_assets,
                ),
              ],
            ),
          ),
        ),
        if (isAddAssetVisible)
          OverlayAssetSelection(
            spareParts: replacementAsset != null
                ? [...sparePartsAssets, replacementAsset!.id]
                : sparePartsAssets,
            toggleSelection: showOnlySubAssets.value
                ? (assetId) {
                    if (replacementAsset != null &&
                        replacementAsset!.id == assetId) {
                      showSnackBar(
                        context: context,
                        message: AppLocalizations.of(context)!
                            .task_action_asset_already_in_use_err_msg,
                        isErrorMessage: true,
                      );
                    } else {
                      toggleAssetSelection(assetId);
                    }
                  }
                : (assetId) {
                    if (sparePartsAssets.contains(assetId)) {
                      showSnackBar(
                        context: context,
                        message: AppLocalizations.of(context)!
                            .task_action_asset_already_in_use_err_msg,
                        isErrorMessage: true,
                      );
                    } else {
                      toggleAsset(context, assetId);
                      toggleAddAssetVisibility();
                    }
                  },
            onDismiss: toggleAddAssetVisibility,
            onlyUnusedParts: showOnlySubAssets.value,
          ),
      ],
    );
  }
}

class AddReplacementAssetButton extends StatelessWidget {
  const AddReplacementAssetButton({
    Key? key,
    required this.showOnlySubAssets,
    required this.toggleAddAssetVisibility,
  }) : super(key: key);

  final ValueNotifier<bool> showOnlySubAssets;
  final Function() toggleAddAssetVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              showOnlySubAssets.value = false;
              toggleAddAssetVisibility();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 36,
                    color: Theme.of(context).highlightColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .task_action_add_replacement_asset,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
