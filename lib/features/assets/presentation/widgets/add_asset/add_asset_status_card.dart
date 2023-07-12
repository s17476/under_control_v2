import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/duration_unit.dart';
import '../../../utils/get_next_date.dart';
import '../asset_status_dropdown_button.dart';
import '../duration_dropdown_button.dart';
import '../duration_unit_dropdown_button.dart';

class AddAssetStatusCard extends StatefulWidget {
  const AddAssetStatusCard({
    Key? key,
    required this.lastInspectionDate,
    required this.setLastInspectionDate,
    required this.durationUnit,
    required this.setDurationUnit,
    required this.assetStatus,
    required this.setAssetStatus,
    required this.duration,
    required this.setDuration,
  }) : super(key: key);

  final DateTime lastInspectionDate;
  final Function(DateTime) setLastInspectionDate;
  final String durationUnit;
  final Function(String) setDurationUnit;
  final String assetStatus;
  final Function(String) setAssetStatus;
  final int duration;
  final Function(String) setDuration;

  @override
  State<AddAssetStatusCard> createState() => _AddAssetStatusCardState();
}

class _AddAssetStatusCardState extends State<AddAssetStatusCard> {
  final _dateTextEditingController = TextEditingController();
  final _nextDateTextEditingController = TextEditingController();
  final _dateFormat = DateFormat('dd-MM-yyyy');

  void _setDurationUnit(String value) {
    widget.setDurationUnit(value);
    _generateNextInspectionDate(durationUnit: value, duration: 0);
  }

  void _setDuration(String value) {
    widget.setDuration(value);
    _generateNextInspectionDate(duration: int.parse(value));
  }

  void _pickDate() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    BottomPicker.date(
      title: AppLocalizations.of(context)!.add_date,
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      onSubmit: (date) {
        widget.setLastInspectionDate(date);
        setState(() {
          _dateTextEditingController.text = _dateFormat.format(date);
        });
        _generateNextInspectionDate(lastInspectionDate: date);
      },
      dismissable: true,
      closeIconColor: Theme.of(context).textTheme.labelMedium!.color!,
      gradientColors: [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor.withAlpha(80),
      ],
      pickerTextStyle: TextStyle(
        color: Theme.of(context).textTheme.labelMedium!.color,
        fontSize: 20,
      ),
      initialDateTime: _dateFormat.parse(_dateTextEditingController.text),
      minDateTime: DateTime(2019, 1, 1),
      maxDateTime: DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second + 3,
      ),
    ).show(context);
  }

  void _generateNextInspectionDate({
    DateTime? lastInspectionDate,
    String? durationUnit,
    int? duration,
  }) {
    if ((duration ?? widget.duration) != 0) {
      final nextDate = getNextDate(
        lastInspectionDate ?? widget.lastInspectionDate,
        DurationUnit.fromString(durationUnit ?? widget.durationUnit),
        duration ?? widget.duration,
      );
      setState(() {
        _nextDateTextEditingController.text = _dateFormat.format(nextDate);
      });
    } else {
      setState(() {
        _nextDateTextEditingController.text = '';
      });
    }
  }

  @override
  void initState() {
    _dateTextEditingController.text =
        _dateFormat.format(widget.lastInspectionDate);
    _generateNextInspectionDate();
    super.initState();
  }

  @override
  void dispose() {
    _dateTextEditingController.dispose();
    _nextDateTextEditingController.dispose();
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
              AppLocalizations.of(context)!.asset_status,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    // date time row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconTitleRow(
                            icon: Icons.youtube_searched_for,
                            iconColor: Colors.white,
                            iconBackground: Theme.of(context).primaryColor,
                            title: AppLocalizations.of(context)!
                                .asset_last_inspection,
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
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(60),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // unit selection
                          AssetStatusDropdownButton(
                            assetStatus: widget.assetStatus,
                            onSelected: widget.setAssetStatus,
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          IconTitleRow(
                            icon: Icons.manage_search,
                            iconColor: Colors.white,
                            iconBackground: Theme.of(context).primaryColor,
                            title: AppLocalizations.of(context)!
                                .asset_inspection_interval,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // unit selection
                          DurationUnitDropdownButton(
                            selectedUnit: widget.durationUnit,
                            onSelected: _setDurationUnit,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // unit selection
                          DurationDropdownButton(
                            duration: widget.duration,
                            durationUnit: widget.durationUnit,
                            onSelected: _setDuration,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            fieldKey: 'generatedDate',
                            enabled: false,
                            textAlign: TextAlign.center,
                            controller: _nextDateTextEditingController,
                            labelText: widget.duration == 0
                                ? AppLocalizations.of(context)!
                                    .asset_next_inspection_tip
                                : AppLocalizations.of(context)!
                                    .asset_next_inspection,
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
        ],
      ),
    );
  }
}
