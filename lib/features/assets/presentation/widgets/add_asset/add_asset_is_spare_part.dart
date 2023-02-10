import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../tasks/presentation/widgets/add_work_request/overlay_connected_asset_selection.dart';
import '../../blocs/asset/asset_bloc.dart';
import '../asset_tile.dart';

class AddAssetIsSparePartCard extends StatelessWidget with ResponsiveSize {
  const AddAssetIsSparePartCard({
    Key? key,
    required this.setIsSparePart,
    required this.setParentAsset,
    required this.isSparePart,
    required this.setIsInUse,
    required this.isInUse,
    required this.setLocation,
    required this.currentParentId,
    required this.isAddParentAssetVisible,
    required this.toggleAddParentAssetVisible,
  }) : super(key: key);

  final Function(bool) setIsSparePart;
  final Function(String) setParentAsset;
  final bool isSparePart;
  final Function(bool) setIsInUse;
  final bool isInUse;
  final Function(String) setLocation;
  final String currentParentId;
  final bool isAddParentAssetVisible;
  final Function() toggleAddParentAssetVisible;

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
                        AppLocalizations.of(context)!.asset_type,
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
                      child: Center(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 32,
                          ),
                          shrinkWrap: true,
                          children: [
                            // not a spare part
                            SelectionButton<bool>(
                              onSelected: (val) {
                                setIsSparePart(val);
                                setParentAsset('');
                              },
                              icon: Icons.check_circle,
                              iconSize: 50,
                              title: AppLocalizations.of(context)!
                                  .asset_not_spare_part,
                              titleSize: 18,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor.withAlpha(100),
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withAlpha(80),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              value: false,
                              groupValue: isSparePart,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // spare part
                            SelectionButton<bool>(
                              onSelected: setIsSparePart,
                              icon: Icons.build_circle_rounded,
                              iconSize: 50,
                              title: AppLocalizations.of(context)!
                                  .asset_spare_part,
                              titleSize: 18,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.withAlpha(150),
                                  Colors.orange,
                                  Colors.orange.withAlpha(80),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              value: true,
                              groupValue: isSparePart,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color!,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .asset_spare_part_description,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color!,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 8,
                            ),
                            // not a spare part
                            SelectionButton<bool>(
                              onSelected: setIsInUse,
                              icon: Icons.play_circle,
                              iconSize: 50,
                              title: AppLocalizations.of(context)!.asset_in_use,
                              titleSize: 18,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor.withAlpha(100),
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withAlpha(80),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              value: true,
                              groupValue: isInUse,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // spare part
                            SelectionButton<bool>(
                              onSelected: (val) {
                                setIsInUse(val);
                                setParentAsset('');
                              },
                              icon: Icons.pause_circle,
                              iconSize: 50,
                              title: AppLocalizations.of(context)!
                                  .asset_not_in_use,
                              titleSize: 18,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.withAlpha(150),
                                  Colors.orange,
                                  Colors.orange.withAlpha(80),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              value: false,
                              groupValue: isInUse,
                            ),
                            if (isInUse && isSparePart) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(),
                              ),
                              if (currentParentId.isEmpty)
                                SelectAssetButton(
                                  toggleAddConnectedAssetVisibility:
                                      toggleAddParentAssetVisible,
                                ),
                              if (currentParentId.isNotEmpty)
                                BlocBuilder<AssetBloc, AssetState>(
                                  builder: (context, state) {
                                    if (state is AssetLoadedState) {
                                      final asset =
                                          state.getAssetById(currentParentId);
                                      if (asset != null) {
                                        return InkWell(
                                          onTap: toggleAddParentAssetVisible,
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
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isAddParentAssetVisible)
          OverlayConnectedAssetSelection(
            setAssetId: setParentAsset,
            assetId: currentParentId,
            setLocation: setLocation,
            onDismiss: toggleAddParentAssetVisible,
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
                    AppLocalizations.of(context)!.asset_parent_select,
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
