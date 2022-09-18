import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/get_locale_type.dart';
import '../../../../core/utils/responsive_size.dart';

class AddDateAndDescriptionCard extends StatefulWidget {
  const AddDateAndDescriptionCard({
    Key? key,
    required this.pageController,
    required this.descriptionTextEditingController,
    required this.dateTime,
    required this.setDate,
  }) : super(key: key);

  final PageController pageController;

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

  final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');

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
          _dateTextEditingController.text = dateFormat.format(date);
        });
      },
      currentTime: dateFormat.parse(_dateTextEditingController.text),
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
    _dateTextEditingController.text = dateFormat.format(widget.dateTime);
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
                            Theme.of(context).textTheme.headline5!.fontSize,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.arrow_back_ios_new,
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  function: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
