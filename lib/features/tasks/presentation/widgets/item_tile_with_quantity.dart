import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/double_apis.dart';

import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';

import '../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../inventory/domain/entities/item.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';

class ItemTileWithQuantity extends StatefulWidget {
  final Item item;
  final SparePartItemModel sparePartItemModel;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final String searchQuery;
  final Function(SparePartItemModel) onSelected;
  final Function(String, double) updateSparePartQuantity;
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
    required this.updateSparePartQuantity,
    this.isSelected,
  }) : super(key: key);

  @override
  State<ItemTileWithQuantity> createState() => _ItemTileWithQuantityState();
}

class _ItemTileWithQuantityState extends State<ItemTileWithQuantity> {
  final TextEditingController _quantityTextEditingController =
      TextEditingController();

  void _increaseQuantity() {
    try {
      FocusScope.of(context).unfocus();
      final increasedValue =
          double.parse(_quantityTextEditingController.text) + 1;
      setState(() {
        _quantityTextEditingController.text =
            increasedValue.toStringWithFixedDecimal();
        widget.updateSparePartQuantity(widget.item.id, increasedValue);
      });
    } catch (e) {
      _showFormatErrorSnackBar();
    }
  }

  void _decreaseQuantity() {
    try {
      FocusScope.of(context).unfocus();
      final decreasedValue =
          double.parse(_quantityTextEditingController.text) - 1;
      setState(() {
        _quantityTextEditingController.text =
            decreasedValue.toStringWithFixedDecimal();
        widget.updateSparePartQuantity(widget.item.id, decreasedValue);
      });
    } catch (e) {
      _showFormatErrorSnackBar();
    }
  }

  void _showFormatErrorSnackBar() {
    showSnackBar(
      context: context,
      message: AppLocalizations.of(context)!.incorrect_number_format,
      isErrorMessage: true,
    );
  }

  @override
  void initState() {
    _quantityTextEditingController.text =
        widget.sparePartItemModel.quantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double doubleQuantity;
    try {
      doubleQuantity = double.parse(_quantityTextEditingController.text);
    } catch (e) {
      doubleQuantity = 0;
    }
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
                  item: widget.item,
                  searchQuery: '',
                  onSelected: (_) =>
                      widget.onSelected(widget.sparePartItemModel),
                  isSelected: true,
                ),
              ),
            ),
          ),
          // quantity box
          SizedBox(
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // decrease button
                IconButton(
                  onPressed: _increaseQuantity,
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
                // text field
                SizedBox(
                  width: 125,
                  child: CustomTextFormField(
                    maxLines: 1,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    fieldKey: 'quantity',
                    labelText: '',
                    controller: _quantityTextEditingController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      double quantity;
                      try {
                        quantity =
                            double.parse(_quantityTextEditingController.text);
                      } catch (e) {
                        quantity = 0;
                      }
                      widget.updateSparePartQuantity(widget.item.id, quantity);
                    },
                  ),
                ),
                // decrease button
                IconButton(
                  onPressed: doubleQuantity >= 1 ? _decreaseQuantity : null,
                  icon: const Icon(
                    Icons.remove,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
