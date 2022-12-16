import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../assets/presentation/widgets/asset_selection/overlay_asset_selection.dart';
import '../../../../assets/presentation/widgets/assets_spare_parts_list.dart';
import '../../../../core/utils/responsive_size.dart';

class AddTaskActionAddSparePartCard extends StatelessWidget {
  const AddTaskActionAddSparePartCard({
    Key? key,
    required this.toggleAssetSelection,
    required this.toggleAddAssetVisibility,
    required this.sparePartsAssets,
    required this.isAddAssetVisible,
  }) : super(key: key);

  final Function(String) toggleAssetSelection;
  final Function() toggleAddAssetVisibility;
  final List<String> sparePartsAssets;
  final bool isAddAssetVisible;

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
                        child: AssetsSparePartsList(
                          items: sparePartsAssets,
                          onSelected: toggleAssetSelection,
                        ),
                      ),
                    ),

                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        // height: _isVisible ? null : 0,
                        child: Column(
                          children: [
                            // add spareparts from assets button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                ),
                                onPressed: toggleAddAssetVisibility,
                                icon: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Stack(
                                    children: const [
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Icon(
                                          Icons.precision_manufacturing,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                label: Text(
                                  AppLocalizations.of(context)!
                                      .asset_add_spare_parts_assets,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 50,
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
        if (isAddAssetVisible)
          OverlayAssetSelection(
            spareParts: sparePartsAssets,
            toggleSelection: toggleAssetSelection,
            onDismiss: toggleAddAssetVisibility,
            onlyUnusedParts: true,
          ),
      ],
    );
  }
}
