import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/domain/entities/item.dart';
import '../../../../inventory/presentation/widgets/item_tile.dart';
import '../../../../inventory/utils/get_item_total_quantity.dart';
import '../../../data/models/task/spare_part_item_model.dart';

class ItemTileWithQuantity extends StatefulWidget {
  const ItemTileWithQuantity({
    Key? key,
    required this.item,
    required this.sparePartItemModel,
    this.borderRadius = 15,
    this.color = Colors.black,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    required this.searchQuery,
    this.onSelected,
    this.updateSparePartQuantity,
    this.isSelected,
    this.showBreadcrumbs = false,
  }) : super(key: key);

  final Item item;
  final SparePartItemModel sparePartItemModel;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final String searchQuery;
  final Function(SparePartItemModel)? onSelected;
  final Function(String, double)? updateSparePartQuantity;
  final bool? isSelected;
  final bool showBreadcrumbs;

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
        widget.updateSparePartQuantity!(widget.item.id, increasedValue);
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
        widget.updateSparePartQuantity!(widget.item.id, decreasedValue);
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
                  onSelected: widget.onSelected != null
                      ? (_) => widget.onSelected!(widget.sparePartItemModel)
                      : null,
                  isSelected: widget.onSelected != null ? true : null,
                  locationId: widget.sparePartItemModel.locationId,
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
                if (widget.updateSparePartQuantity != null)
                  IconButton(
                    onPressed: _increaseQuantity,
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                // text field
                if (widget.updateSparePartQuantity == null)
                  FittedBox(
                    child: Text(
                      widget.sparePartItemModel.quantity
                          .toStringWithFixedDecimal(),
                      style: TextStyle(
                        fontSize: 28,
                        color: widget.sparePartItemModel.quantity >
                                getItemTotalQuantity(widget.item)
                            ? Theme.of(context).highlightColor
                            : null,
                      ),
                    ),
                  ),
                if (widget.updateSparePartQuantity != null)
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
                      enabled: widget.updateSparePartQuantity != null,
                      onChanged: (val) {
                        double quantity;
                        try {
                          quantity =
                              double.parse(_quantityTextEditingController.text);
                        } catch (e) {
                          quantity = 0;
                        }
                        widget.updateSparePartQuantity!(
                            widget.item.id, quantity);
                      },
                    ),
                  ),
                // decrease button
                if (widget.updateSparePartQuantity != null)
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
