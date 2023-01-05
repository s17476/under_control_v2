import 'package:flutter/material.dart';

import '../../../../assets/presentation/widgets/assets_spare_parts_list.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../add_task/inventory_spare_parts_list_with_quantity.dart';

class TaskSparePartTab extends StatelessWidget {
  const TaskSparePartTab({
    Key? key,
    required this.sparePartsAssets,
    required this.sparePartsItems,
  }) : super(key: key);

  final List<String> sparePartsAssets;
  final List<SparePartItemModel> sparePartsItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // assets
                AssetsSparePartsList(
                  items: sparePartsAssets,
                ),
                // inventory
                InventorySparePartsListWithQuantity(
                  items: sparePartsItems,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
