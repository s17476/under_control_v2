import 'package:flutter/material.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../data/models/asset_category/asset_category_model.dart';
import '../../domain/entities/asset_category/asset_category.dart';
import '../../utils/show_add_asset_category_modal_bottom_sheet.dart';
import '../../utils/show_asset_category_delete_dialog.dart';

class AssetCategoryTile extends StatelessWidget {
  final bool isAdministrator;
  final AssetCategory assetCategory;
  const AssetCategoryTile({
    Key? key,
    required this.isAdministrator,
    required this.assetCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                // location name
                child: Text(
                  assetCategory.name,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // action buttons
              Row(
                children: [
                  // edit button
                  if (getUserPremission(
                    context: context,
                    featureType: FeatureType.assets,
                    premissionType: PermissionType.edit,
                  ))
                    IconButton(
                      onPressed: () {
                        showAddAssetCategoryModalBottomSheet(
                          context: context,
                          assetCategory: assetCategory as AssetCategoryModel,
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  // delete button
                  if (getUserPremission(
                    context: context,
                    featureType: FeatureType.assets,
                    premissionType: PermissionType.delete,
                  ))
                    IconButton(
                      onPressed: () {
                        showAssetCategoryDeleteDialog(
                          context: context,
                          assetCategory: assetCategory,
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey.shade200,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
