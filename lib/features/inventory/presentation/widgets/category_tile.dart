import 'package:flutter/material.dart';
import 'package:under_control_v2/features/inventory/data/models/item_category/item_category_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category/item_category.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/show_add_category_modal_bottom_sheet.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/show_category_delete_dialog.dart';

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
              if (isAdministrator)
                Row(
                  children: [
                    // edit button
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
