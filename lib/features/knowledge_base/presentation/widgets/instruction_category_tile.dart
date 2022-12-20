import 'package:flutter/material.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../data/models/inventory_category/instruction_category_model.dart';
import '../../domain/entities/instruction_category/instruction_category.dart';
import '../../utils/show_add_instruction_category_modal_bottom_sheet.dart';
import '../../utils/show_instruction_category_delete_dialog.dart';

class InstructionCategoryTile extends StatelessWidget {
  final bool isAdministrator;
  final InstructionCategory instructionCategory;
  const InstructionCategoryTile({
    Key? key,
    required this.isAdministrator,
    required this.instructionCategory,
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
                  instructionCategory.name,
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
                    premissionType: PermissionType.edit,
                  ))
                    IconButton(
                      onPressed: () {
                        showAddInstructionCategoryModalBottomSheet(
                          context: context,
                          instructionCategory:
                              instructionCategory as InstructionCategoryModel,
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
                    premissionType: PermissionType.delete,
                  ))
                    IconButton(
                      onPressed: () {
                        showInstructionCategoryDeleteDialog(
                          context: context,
                          instructionCategory: instructionCategory,
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
