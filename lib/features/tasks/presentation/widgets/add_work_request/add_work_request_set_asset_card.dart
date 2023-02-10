import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import 'overlay_connected_asset_selection.dart';

class AddWorkRequestSetAssetCard extends StatelessWidget {
  const AddWorkRequestSetAssetCard({
    Key? key,
    required this.setIsConnectedToAsset,
    required this.isConnectedToAsset,
    required this.toggleAddConnectedAssetVisibility,
    required this.isAddConnectedAssetVisible,
    required this.setAssetId,
    required this.assetId,
    required this.setLocation,
  }) : super(key: key);

  final Function(bool) setIsConnectedToAsset;
  final bool isConnectedToAsset;
  final bool isAddConnectedAssetVisible;
  final Function() toggleAddConnectedAssetVisibility;
  final Function(String) setAssetId;
  final String assetId;
  final Function(String) setLocation;

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
                        AppLocalizations.of(context)!.task_connected_asset,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 3000),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // not connected to an asset
                              SelectionButton<bool>(
                                onSelected: setIsConnectedToAsset,
                                icon: Icons.handyman,
                                iconSize: 50,
                                title: AppLocalizations.of(context)!
                                    .task_connected_asset_no,
                                titleSize: 18,
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(100),
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(80),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                value: false,
                                groupValue: isConnectedToAsset,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // connected to an asset
                              SelectionButton<bool>(
                                onSelected: (val) {
                                  setIsConnectedToAsset(val);
                                  setAssetId('');
                                },
                                icon: Icons.precision_manufacturing,
                                iconSize: 50,
                                title: AppLocalizations.of(context)!
                                    .task_connected_asset_yes,
                                titleSize: 18,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.withAlpha(150),
                                    Colors.blue,
                                    Colors.blue.withAlpha(80),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                value: true,
                                groupValue: isConnectedToAsset,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (isConnectedToAsset) ...[
                                if (assetId.isEmpty)
                                  SelectAssetButton(
                                    toggleAddConnectedAssetVisibility:
                                        toggleAddConnectedAssetVisibility,
                                  ),
                                if (assetId.isNotEmpty)
                                  BlocBuilder<AssetBloc, AssetState>(
                                    builder: (context, state) {
                                      if (state is AssetLoadedState) {
                                        final asset =
                                            state.getAssetById(assetId);
                                        if (asset != null) {
                                          return InkWell(
                                            onTap:
                                                toggleAddConnectedAssetVisibility,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: IgnorePointer(
                                              child: AssetTile(
                                                asset: asset,
                                                searchQuery: '',
                                                margin: EdgeInsets.zero,
                                              ),
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      }
                                      return const ShimmerItemTile();
                                    },
                                  )
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isAddConnectedAssetVisible)
          OverlayConnectedAssetSelection(
            setAssetId: setAssetId,
            assetId: assetId,
            setLocation: setLocation,
            onDismiss: toggleAddConnectedAssetVisibility,
          ),
      ],
    );
  }
}

class SelectAssetButton extends StatelessWidget {
  const SelectAssetButton({
    Key? key,
    required this.toggleAddConnectedAssetVisibility,
  }) : super(key: key);

  final Function() toggleAddConnectedAssetVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
            onTap: toggleAddConnectedAssetVisibility,
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
                    AppLocalizations.of(context)!.task_connected_asset_select,
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
