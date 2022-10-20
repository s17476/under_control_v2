import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/pages/qr_scanner.dart';
import '../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/utils/get_locale_type.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../utils/show_add_asset_category_modal_bottom_sheet.dart';
import 'asset_category_dropdown_button.dart';

class AddAssetDataCard extends StatefulWidget {
  const AddAssetDataCard({
    Key? key,
    required this.setCategory,
    required this.category,
    required this.priceTextEditingController,
    required this.codeTextEditingController,
    required this.barCodeTextEditingController,
    required this.dateTime,
    required this.setDate,
  }) : super(key: key);

  final Function(String category) setCategory;
  final String category;
  final TextEditingController priceTextEditingController;
  final TextEditingController codeTextEditingController;
  final TextEditingController barCodeTextEditingController;
  final DateTime dateTime;
  final Function(DateTime) setDate;

  @override
  State<AddAssetDataCard> createState() => _AddAssetDataCardState();
}

class _AddAssetDataCardState extends State<AddAssetDataCard> {
  String _currency = '';
  final _dateTextEditingController = TextEditingController();
  final _dateFormat = DateFormat('dd-MM-yyyy  HH:mm');

  void _pickCode(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
      final code = await Navigator.pushNamed(context, QrScanner.routeName);
      if (code is String) {
        widget.barCodeTextEditingController.text = code;
      }
    } catch (e) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.item_no_barcode);
    }
  }

  void _pickDate() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2021, 1, 1),
      maxTime: DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second + 3,
      ),
      onConfirm: (date) {
        widget.setDate(date);
        setState(() {
          _dateTextEditingController.text = _dateFormat.format(date);
        });
      },
      currentTime: _dateFormat.parse(_dateTextEditingController.text),
      locale: getLocaleType(context),
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // headerColor: Theme.of,
        itemStyle: Theme.of(context).textTheme.headline6!,
        cancelStyle: Theme.of(context).textTheme.headline6!,
        doneStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.amber,
            ),
        itemHeight: 40,
      ),
    );
  }

  @override
  void initState() {
    _dateTextEditingController.text = _dateFormat.format(widget.dateTime);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final companyState = context.read<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      _currency = companyState.company.currency;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dateTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: 8,
              right: 8,
            ),
            child: Text(
              AppLocalizations.of(context)!.asset_add_data,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // category selection
                      Row(
                        children: [
                          Expanded(
                            child: AssetCategoryDropdownButton(
                              selectedValue: widget.category,
                              onSelected: widget.setCategory,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: RoundedButton(
                              iconSize: 30,
                              padding: const EdgeInsets.all(9),
                              onPressed: () =>
                                  showAddAssetCategoryModalBottomSheet(
                                context: context,
                              ),
                              icon: Icons.add,
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withAlpha(60),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // price text field
                      CustomTextFormField(
                        scrollPadding: const EdgeInsets.all(170),
                        fieldKey: 'price',
                        controller: widget.priceTextEditingController,
                        keyboardType: TextInputType.number,
                        labelText:
                            '${AppLocalizations.of(context)!.asset_price_optional} [$_currency]',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // internal code text field
                      CustomTextFormField(
                        scrollPadding: const EdgeInsets.all(170),
                        fieldKey: 'code',
                        controller: widget.codeTextEditingController,
                        textCapitalization: TextCapitalization.characters,
                        labelText:
                            AppLocalizations.of(context)!.item_internal_code,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // bar code text field
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              scrollPadding: const EdgeInsets.all(170),
                              fieldKey: 'barCode',
                              controller: widget.barCodeTextEditingController,
                              keyboardType: TextInputType.name,
                              labelText: AppLocalizations.of(context)!
                                  .item_bar_code_optional,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          RoundedButton(
                            iconSize: 30,
                            padding: const EdgeInsets.all(9),
                            onPressed: () => _pickCode(context),
                            icon: Icons.qr_code_scanner,
                            gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(60),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // date time row
                      InkWell(
                        onTap: _pickDate,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                fieldKey: 'date',
                                enabled: false,
                                controller: _dateTextEditingController,
                                textAlign: TextAlign.center,
                                labelText:
                                    AppLocalizations.of(context)!.selected_date,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            RoundedButton(
                              iconSize: 30,
                              padding: const EdgeInsets.all(9),
                              onPressed: _pickDate,
                              icon: Icons.edit_calendar,
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withAlpha(60),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
