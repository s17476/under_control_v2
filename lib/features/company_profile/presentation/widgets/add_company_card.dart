import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';
import '../../../core/presentation/widgets/rounded_button.dart';

class AddCompanyCard extends StatelessWidget with ResponsiveSize {
  const AddCompanyCard({
    Key? key,
    required this.pageController,
    required this.nameTexEditingController,
    required this.addressTexEditingController,
    required this.postCodeTexEditingController,
    required this.cityTexEditingController,
    required this.countryTexEditingController,
    required this.currencyTexEditingController,
    required this.vatNumberTexEditingController,
    required this.phoneNumberTexEditingController,
    required this.emailTexEditingController,
    required this.homepageTexEditingController,
    required this.addNewCompany,
  }) : super(key: key);

  final PageController pageController;
  final TextEditingController nameTexEditingController;
  final TextEditingController addressTexEditingController;
  final TextEditingController postCodeTexEditingController;
  final TextEditingController cityTexEditingController;
  final TextEditingController countryTexEditingController;
  final TextEditingController currencyTexEditingController;
  final TextEditingController vatNumberTexEditingController;
  final TextEditingController phoneNumberTexEditingController;
  final TextEditingController emailTexEditingController;
  final TextEditingController homepageTexEditingController;
  final Function(BuildContext context) addNewCompany;

  void _pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: responsiveSizeVerticalPct(small: 60),
        flagSize: 30,
        backgroundColor: Theme.of(context).cardColor,
        textStyle:
            const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
        ),
      ),
      onSelect: (Country country) => countryTexEditingController.text =
          country.nameLocalized ?? country.name,
    );
  }

  void _pickCurrency(BuildContext context) {
    showCurrencyPicker(
      context: context,
      showFlag: false,
      searchHint: AppLocalizations.of(context)!.search,
      theme: CurrencyPickerThemeData(
        flagSize: 30,
        titleTextStyle: const TextStyle(fontSize: 18),
        subtitleTextStyle:
            TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
        bottomSheetHeight: responsiveSizeVerticalPct(small: 60),
      ),
      onSelect: (Currency currency) =>
          currencyTexEditingController.text = currency.code,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // title
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            AppLocalizations.of(context)!
                                .add_company_intro_card_title,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .fontSize,
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'name',
                          controller: nameTexEditingController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_name,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                enabled: false,
                                fieldKey: 'currency',
                                controller: currencyTexEditingController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                labelText:
                                    AppLocalizations.of(context)!.currency,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            RoundedButton(
                              iconSize: 30,
                              padding: const EdgeInsets.all(9),
                              onPressed: () => _pickCurrency(context),
                              icon: Icons.attach_money,
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
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                enabled: false,
                                fieldKey: 'country',
                                controller: countryTexEditingController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                labelText: AppLocalizations.of(context)!
                                    .add_company_intro_card_country,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            RoundedButton(
                              iconSize: 30,
                              padding: const EdgeInsets.all(9),
                              onPressed: () => _pickCountry(context),
                              icon: Icons.flag,
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
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'address',
                          controller: addressTexEditingController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_address,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'post-code',
                          controller: postCodeTexEditingController,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.none,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_postcode,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'city',
                          controller: cityTexEditingController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_city,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'vat',
                          controller: vatNumberTexEditingController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_vat_number,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'phone',
                          controller: phoneNumberTexEditingController,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.none,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_phone_number,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'email',
                          controller: emailTexEditingController,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_email,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          validator: (val) {
                            if (val!.length < 4) {
                              return AppLocalizations.of(context)!
                                  .add_company_intro_card_to_short;
                            }
                            return null;
                          },
                          fieldKey: 'homepage',
                          controller: homepageTexEditingController,
                          keyboardType: TextInputType.url,
                          textCapitalization: TextCapitalization.none,
                          labelText: AppLocalizations.of(context)!
                              .add_company_intro_card_homepage,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackwardTextButton(
                    icon: Icons.cancel,
                    color: Theme.of(context).textTheme.headline4!.color!,
                    label: AppLocalizations.of(context)!.cancel,
                    function: () => Navigator.pop(context),
                  ),
                  ForwardTextButton(
                    color: Theme.of(context).textTheme.headline5!.color!,
                    label: AppLocalizations.of(context)!.add,
                    function: () => addNewCompany(context),
                    icon: Icons.check,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
