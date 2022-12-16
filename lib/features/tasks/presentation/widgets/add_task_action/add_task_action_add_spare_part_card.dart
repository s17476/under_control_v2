import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../assets/presentation/widgets/asset_selection/overlay_asset_selection.dart';
import '../../../../assets/presentation/widgets/assets_spare_parts_list.dart';

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
    return SafeArea(
      child: Stack(
        children: [
          Column(
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
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.blue.shade700,
              onPressed: () {},
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
              spareParts: sparePartsAssets,
              toggleSelection: toggleAssetSelection,
              onDismiss: toggleAddAssetVisibility,
              onlyUnusedParts: true,
            ),
        ],
      ),
    );
  }
}
