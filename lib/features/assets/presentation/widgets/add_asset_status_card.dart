import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/utils/get_locale_type.dart';
import 'duration_unit_dropdown_button.dart';
import 'selectable_location_list.dart';

class AddAssetStatusCard extends StatefulWidget {
  const AddAssetStatusCard({
    Key? key,
    required this.lastInspectionDate,
    required this.setLastInspectionDate,
    required this.durationUnit,
    required this.setDurationUnit,
  }) : super(key: key);

  final DateTime lastInspectionDate;
  final Function(DateTime) setLastInspectionDate;
  final String durationUnit;
  final Function(String unit) setDurationUnit;

  @override
  State<AddAssetStatusCard> createState() => _AddAssetStatusCardState();
}

class _AddAssetStatusCardState extends State<AddAssetStatusCard> {
  final _dateTextEditingController = TextEditingController();
  final _dateFormat = DateFormat('dd-MM-yyyy');

  void _pickDate() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2019, 1, 1),
      maxTime: DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second + 3,
      ),
      onConfirm: (date) {
        widget.setLastInspectionDate(date);
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
    _dateTextEditingController.text =
        _dateFormat.format(widget.lastInspectionDate);
    super.initState();
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.asset_select_location,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // date time row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.asset_last_inspection,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
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
                                  labelText: AppLocalizations.of(context)!
                                      .asset_last_inspection_date,
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
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .asset_inspection_interval,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // unit selection
                        DurationUnitDropdownButton(
                          selectedUnit: widget.durationUnit,
                          onSelected: widget.setDurationUnit,
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
        ],
      ),
    );
  }
}
