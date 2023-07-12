import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/double_apis.dart';

import '../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/presentation/widgets/selection_button.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../domain/entities/item.dart';
import '../../utils/get_localized_unit_name.dart';

class AddAlertQuantityCard extends StatefulWidget {
  const AddAlertQuantityCard({
    Key? key,
    required this.quantityTextEditingController,
    required this.itemUnit,
    required this.isAlertQuantitySet,
    required this.toggleIsAlertQuantitySet,
  }) : super(key: key);

  final TextEditingController quantityTextEditingController;
  final String itemUnit;
  final bool isAlertQuantitySet;

  final Function(bool) toggleIsAlertQuantitySet;

  @override
  State<AddAlertQuantityCard> createState() => _AddAlertQuantityCardState();
}

class _AddAlertQuantityCardState extends State<AddAlertQuantityCard>
    with ResponsiveSize {
  String? _errorMessage;

  final noAlerts = TextEditingController();

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
  void didChangeDependencies() {
    noAlerts.text = AppLocalizations.of(context)!.no_alert;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    noAlerts.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unit =
        getLocalizedUnitName(context, ItemUnit.fromString(widget.itemUnit));

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
                    AppLocalizations.of(context)!.alert_quantity,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SelectionButton<bool>(
                    onSelected: widget.toggleIsAlertQuantitySet,
                    icon: Icons.do_not_disturb_alt,
                    iconSize: 50,
                    title: AppLocalizations.of(context)!.no_alert_quantity,
                    titleSize: 18,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withAlpha(150),
                        Colors.orange,
                        Colors.orange.withAlpha(80),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    value: false,
                    groupValue: widget.isAlertQuantitySet,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SelectionButton<bool>(
                    onSelected: widget.toggleIsAlertQuantitySet,
                    icon: Icons.warning_amber_rounded,
                    iconSize: 50,
                    title: AppLocalizations.of(context)!.use_alert_quantity,
                    titleSize: 18,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withAlpha(100),
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withAlpha(80),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    value: true,
                    groupValue: widget.isAlertQuantitySet,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // decrease button
                    RoundedButton(
                      onPressed:
                          (doubleQuantity < 1 || !widget.isAlertQuantitySet)
                              ? () {}
                              : _decreaseQuantity,
                      icon: Icons.remove,
                      iconSize: 40,
                      titleSize: 16,
                      foregroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      gradient: LinearGradient(
                        colors:
                            (doubleQuantity < 1 || !widget.isAlertQuantitySet)
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
                        enabled: widget.isAlertQuantitySet,
                        fieldKey: 'quantity',
                        labelText:
                            '${AppLocalizations.of(context)!.quantity} [$unit]',
                        controller: widget.isAlertQuantitySet
                            ? widget.quantityTextEditingController
                            : noAlerts,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (!widget.isAlertQuantitySet) {
                            return null;
                          }
                          double? quantity;
                          try {
                            quantity = double.parse(val!);
                            if (quantity < 0) {
                              setState(() {
                                _errorMessage = AppLocalizations.of(context)!
                                    .quantity_to_small;
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
                      onPressed: !widget.isAlertQuantitySet
                          ? () {}
                          : _increaseQuantity,
                      icon: Icons.add,
                      iconSize: 40,
                      titleSize: 16,
                      foregroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      gradient: LinearGradient(
                        colors: !widget.isAlertQuantitySet
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
                        color: Theme.of(context).colorScheme.error,
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
