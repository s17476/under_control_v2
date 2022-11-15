import 'package:flutter/material.dart';

import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';

import '../../../inventory/domain/entities/item.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';

class ItemTileWithQuantity extends StatelessWidget {
  final Item item;
  final SparePartItemModel sparePartItemModel;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final String searchQuery;
  final Function(SparePartItemModel) onSelected;
  final bool? isSelected;

  const ItemTileWithQuantity({
    Key? key,
    required this.item,
    required this.sparePartItemModel,
    this.borderRadius = 15,
    this.color = Colors.black,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    required this.searchQuery,
    required this.onSelected,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: ItemTile(
                  margin: const EdgeInsets.all(0),
                  borderRadius: 15,
                  item: item,
                  searchQuery: '',
                  onSelected: (_) => onSelected(sparePartItemModel),
                  isSelected: true,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70,
          ),
        ],
      ),
    );
  }
}
