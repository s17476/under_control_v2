import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddDateAndDescriptionCard extends StatefulWidget {
  const AddDateAndDescriptionCard({
    Key? key,
    required this.descriptionTextEditingController,
    required this.dateTime,
    required this.setDate,
  }) : super(key: key);

  final TextEditingController descriptionTextEditingController;
  final DateTime dateTime;
  final Function(DateTime) setDate;

  @override
  State<AddDateAndDescriptionCard> createState() =>
      _AddDateAndDescriptionCardState();
}

class _AddDateAndDescriptionCardState extends State<AddDateAndDescriptionCard>
    with ResponsiveSize {
  final _dateTextEditingController = TextEditingController();

  final _dateFormat = DateFormat('dd-MM-yyyy  HH:mm');

  void _pickDate() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    // DatePicker.showDateTimePicker(
    //   context,
    //   showTitleActions: true,
    //   minTime: DateTime(2021, 1, 1),
    //   maxTime: DateTime(
    //     now.year,
    //     now.month,
    //     now.day,
    //     now.hour,
    //     now.minute,
    //     now.second + 3,
    //   ),
    //   onConfirm: (date) {
    //     widget.setDate(date);
    //     setState(() {
    //       _dateTextEditingController.text = _dateFormat.format(date);
    //     });
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

  @override
  void initState() {
    _dateTextEditingController.text = _dateFormat.format(widget.dateTime);
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
                  // title
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.date_and_description,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headlineSmall!.fontSize,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: responsiveSizeVerticalPct(small: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
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
                                  Theme.of(context).primaryColor.withAlpha(60),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          fieldKey: 'description',
                          labelText: AppLocalizations.of(context)!.description,
                          controller: widget.descriptionTextEditingController,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          scrollPadding: const EdgeInsets.only(bottom: 200),
                          validator: (value) {
                            if (value!.length < 2) {
                              return AppLocalizations.of(context)!
                                  .validation_min_two_characters;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
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
