import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/pages/qr_scanner.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import 'category_dropdown_button.dart';
import 'item_unit_dropdown_button.dart';

class AddItemDataCard extends StatefulWidget {
  const AddItemDataCard({
    Key? key,
    required this.isEditMode,
    required this.pageController,
    required this.priceTextEditingController,
    required this.codeTextEditingController,
    required this.barCodeTextEditingController,
    required this.setCategory,
    required this.setItemUnit,
    required this.category,
    required this.itemUnit,
  }) : super(key: key);

  final bool isEditMode;
  final PageController pageController;
  final TextEditingController priceTextEditingController;
  final TextEditingController codeTextEditingController;
  final TextEditingController barCodeTextEditingController;
  final Function(String category) setCategory;
  final Function(String category) setItemUnit;
  final String category;
  final String itemUnit;

  @override
  State<AddItemDataCard> createState() => _AddItemDataCardState();
}

class _AddItemDataCardState extends State<AddItemDataCard> with ResponsiveSize {
  bool hasBarCode = false;
  String currency = '';

  @override
  void didChangeDependencies() {
    final companyState = context.read<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      currency = companyState.company.currency;
    }
    super.didChangeDependencies();
  }

  void _pickCode(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
      final code = await Navigator.pushNamed(context, QrScanner.routeName);
      if (code is String) {
        widget.barCodeTextEditingController.text = code;
        setState(() {
          hasBarCode = true;
        });
      }
    } catch (e) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.item_no_barcode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        AppLocalizations.of(context)!.item_data,
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
                      height: responsiveSizeVerticalPct(small: 20),
                    ),

                    // category selection
                    CategoryDropdownButton(
                      selectedValue: widget.category,
                      onSelected: widget.setCategory,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // unit selection
                    ItemUnitDropdownButton(
                      selectedUnit: widget.itemUnit,
                      onSelected: widget.setItemUnit,
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
                          '${AppLocalizations.of(context)!.item_unit_price_optional} [$currency]',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // internal code text field
                    CustomTextFormField(
                      scrollPadding: const EdgeInsets.all(170),
                      fieldKey: 'code',
                      controller: widget.codeTextEditingController,
                      keyboardType: TextInputType.name,
                      labelText: AppLocalizations.of(context)!
                          .item_internal_code_optional,
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
                  ],
                ),
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
                      curve: Curves.easeInOut),
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
