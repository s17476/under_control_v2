import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../assets/presentation/widgets/duration_dropdown_button.dart';
import '../../../../assets/presentation/widgets/duration_unit_dropdown_button.dart';
import '../../../../assets/utils/get_next_date.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/duration_unit.dart';

class AddTaskSetCyclicCard extends StatefulWidget {
  const AddTaskSetCyclicCard({
    Key? key,
    required this.executionDate,
    required this.setExecutionDate,
    required this.durationUnit,
    required this.setDurationUnit,
    required this.isCyclicTask,
    required this.setIsCyclicTask,
    required this.duration,
    required this.setDuration,
  }) : super(key: key);

  final DateTime executionDate;
  final Function(DateTime) setExecutionDate;
  final String durationUnit;
  final Function(String) setDurationUnit;
  final bool isCyclicTask;
  final Function(bool) setIsCyclicTask;
  final int duration;
  final Function(String) setDuration;

  @override
  State<AddTaskSetCyclicCard> createState() => _AddTaskSetCyclicCardState();
}

class _AddTaskSetCyclicCardState extends State<AddTaskSetCyclicCard> {
  final _dateTextEditingController = TextEditingController();
  final _nextDateTextEditingController = TextEditingController();
  final _dateFormat = DateFormat('dd-MM-yyyy HH:mm');

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
    // DatePicker.showDateTimePicker(
    //   context,
    //   showTitleActions: true,
    //   minTime: DateTime(
    //     now.year,
    //     now.month,
    //     now.day,
    //     now.hour,
    //     now.minute - 5,
    //     now.second,
    //   ),
    //   onConfirm: (date) {
    //     widget.setExecutionDate(date);
    //     setState(() {
    //       _dateTextEditingController.text = _dateFormat.format(date);
    //     });
    //     _generateNextInspectionDate(lastInspectionDate: date);
    //   },
    //   currentTime: _dateFormat.parse(_dateTextEditingController.text),
    //   locale: getLocaleType(context),
    //   // TODO datetime
    //   // theme: DatePickerTheme(
    //   //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   //   // headerColor: Theme.of,
    //   //   itemStyle: Theme.of(context).textTheme.titleLarge!,
    //   //   cancelStyle: Theme.of(context).textTheme.titleLarge!,
    //   //   doneStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
    //   //         color: Colors.amber,
    //   //       ),
    //   //   itemHeight: 40,
    //   // ),
    // );
  }

  void _generateNextInspectionDate({
    DateTime? lastInspectionDate,
    String? durationUnit,
    int? duration,
  }) {
    if ((duration ?? widget.duration) != 0) {
      final nextDate = getNextDate(
        lastInspectionDate ?? widget.executionDate,
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
    _dateTextEditingController.text = _dateFormat.format(widget.executionDate);
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
              AppLocalizations.of(context)!.add_date,
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
                            icon: Icons.build_circle_outlined,
                            iconColor: Colors.white,
                            iconBackground: Theme.of(context).primaryColor,
                            title: AppLocalizations.of(context)!
                                .task_execution_date,
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
                                        .selected_date,
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
                            height: 16,
                          ),
                          SelectionButton<bool>(
                            onSelected: (val) {
                              _nextDateTextEditingController.text = '';
                              widget.setIsCyclicTask(val);
                            },
                            icon: Icons.today,
                            iconSize: 30,
                            title: AppLocalizations.of(context)!
                                .task_not_is_cyclic,
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
                            value: false,
                            groupValue: widget.isCyclicTask,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // connected to an asset
                          SelectionButton<bool>(
                            onSelected: widget.setIsCyclicTask,
                            icon: Icons.refresh,
                            iconSize: 30,
                            title: AppLocalizations.of(context)!.task_is_cyclic,
                            titleSize: 18,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withAlpha(150),
                                Colors.blue,
                                Colors.blue.withAlpha(80),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            value: true,
                            groupValue: widget.isCyclicTask,
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          IconTitleRow(
                            icon: Icons.refresh_sharp,
                            iconColor: Colors.white,
                            iconBackground: Theme.of(context).primaryColor,
                            title: AppLocalizations.of(context)!.task_interval,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // unit selection
                          DurationUnitDropdownButton(
                            isEnabled: widget.isCyclicTask,
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
                                    .task_next_execution_date,
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
