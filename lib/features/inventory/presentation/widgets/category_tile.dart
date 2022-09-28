import 'package:flutter/material.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../data/models/item_category/item_category_model.dart';
import '../../domain/entities/item_category/item_category.dart';
import '../../utils/show_add_category_modal_bottom_sheet.dart';
import '../../utils/show_category_delete_dialog.dart';

class CategoryTile extends StatelessWidget {
  final bool isAdministrator;
  final ItemCategory itemCategory;
  const CategoryTile({
    Key? key,
    required this.isAdministrator,
    required this.itemCategory,
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
                  itemCategory.name,
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
                    featureType: FeatureType.inventory,
                    premissionType: PremissionType.edit,
                  ))
                    IconButton(
                      onPressed: () {
                        showAddCategoryModalBottomSheet(
                          context: context,
                          itemCategory: itemCategory as ItemCategoryModel,
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
                    featureType: FeatureType.inventory,
                    premissionType: PremissionType.delete,
                  ))
                    IconButton(
                      onPressed: () {
                        showCategoryDeleteDialog(
                          context: context,
                          itemCategory: itemCategory,
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
