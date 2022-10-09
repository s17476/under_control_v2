import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../domain/entities/item.dart';
import '../../../utils/get_localized_unit_name.dart';

class AddQuantityCard extends StatefulWidget {
  const AddQuantityCard({
    Key? key,
    required this.quantityTextEditingController,
    required this.itemUnit,
    this.maxQuantity = 0,
  }) : super(key: key);

  final TextEditingController quantityTextEditingController;
  final ItemUnit itemUnit;
  final double maxQuantity;

  @override
  State<AddQuantityCard> createState() => _AddQuantityCardState();
}

class _AddQuantityCardState extends State<AddQuantityCard> with ResponsiveSize {
  String? _errorMessage;

  void _increaseQuantity() {
    try {
      FocusScope.of(context).unfocus();
      final increasedValue =
          double.parse(widget.quantityTextEditingController.text) + 1;
      setState(() {
        widget.quantityTextEditingController.text =
            increasedValue.toStringWithFixedDecimal();
      });
    } catch (e) {
      _showFormatErrorSnackBar();
    }
  }

  void _decreaseQuantity() {
    try {
      FocusScope.of(context).unfocus();
      final decreasedValue =
          double.parse(widget.quantityTextEditingController.text) - 1;
      setState(() {
        widget.quantityTextEditingController.text =
            decreasedValue.toStringWithFixedDecimal();
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
  Widget build(BuildContext context) {
    final unit = getLocalizedUnitName(context, widget.itemUnit);

    double doubleQuantity;
    try {
      doubleQuantity = double.parse(widget.quantityTextEditingController.text);
    } catch (e) {
      doubleQuantity = 2;
    }

    return SafeArea(
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
                    AppLocalizations.of(context)!.quantity,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // decrease button
                    RoundedButton(
                      onPressed:
                          doubleQuantity <= 1 ? () {} : _decreaseQuantity,
                      icon: Icons.remove,
                      iconSize: 40,
                      titleSize: 16,
                      foregroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      gradient: LinearGradient(
                        colors: doubleQuantity <= 1
                            ? [
                                Colors.grey,
                                Colors.grey.withAlpha(60),
                              ]
                            : [
                                Colors.red.shade600,
                                Colors.red.shade600.withAlpha(60),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    // text field
                    SizedBox(
                      width: 125,
                      child: CustomTextFormField(
                        fieldKey: 'quantity',
                        labelText:
                            '${AppLocalizations.of(context)!.quantity} [$unit]',
                        controller: widget.quantityTextEditingController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          double? quantity;
                          try {
                            quantity = double.parse(val!);
                            if (quantity <= 0) {
                              setState(() {
                                _errorMessage = AppLocalizations.of(context)!
                                    .incorrect_number_to_small;
                              });
                            } else if (widget.maxQuantity != 0 &&
                                quantity > widget.maxQuantity) {
                              setState(() {
                                _errorMessage = AppLocalizations.of(context)!
                                    .incorrect_number_to_big;
                              });
                            } else {
                              setState(() {
                                _errorMessage = null;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              _errorMessage = AppLocalizations.of(context)!
                                  .incorrect_number_format;
                            });
                          }

                          return null;
                        },
                      ),
                    ),
                    // increase button
                    RoundedButton(
                      onPressed: (widget.maxQuantity != 0 &&
                              doubleQuantity > widget.maxQuantity - 1)
                          ? () {}
                          : _increaseQuantity,
                      icon: Icons.add,
                      iconSize: 40,
                      titleSize: 16,
                      foregroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      gradient: LinearGradient(
                        colors: (widget.maxQuantity != 0 &&
                                doubleQuantity > widget.maxQuantity - 1)
                            ? [
                                Colors.grey,
                                Colors.grey.withAlpha(60),
                              ]
                            : [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withAlpha(60),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
