import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/core/presentation/widgets/custom_text_form_field.dart';

import '../../../utils/show_snack_bar.dart';
import '../../pages/qr_scanner.dart';
import '../rounded_button.dart';

class AppBarSearchBox extends StatelessWidget {
  const AppBarSearchBox({
    Key? key,
    required this.isSearchBoxExpanded,
    required this.onChanged,
    required this.searchTextEditingController,
    required this.searchBoxHeight,
    required this.title,
  }) : super(key: key);

  final bool isSearchBoxExpanded;
  final VoidCallback onChanged;
  final TextEditingController? searchTextEditingController;
  final double searchBoxHeight;
  final String title;

  void _clearSearchBox() {
    searchTextEditingController?.text = '';
    onChanged();
  }

  void _pickBarCode(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
      final code = await Navigator.pushNamed(context, QrScanner.routeName);
      if (code is String) {
        searchTextEditingController?.text = code;
        onChanged();
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.item_no_barcode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isSearchBoxExpanded) {
      return const SizedBox();
    } else {
      return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ),
          builder: (context, Offset offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: Container(
                height: searchBoxHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0.5),
                      color: Colors.grey.shade700,
                      blurRadius: 3,
                    )
                  ],
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: searchTextEditingController,
                          fieldKey: 'search',
                          labelText: title,
                          autofocus: true,
                          onChanged: (_) => onChanged(),
                          keyboardType: TextInputType.name,
                          suffixIcon: InkWell(
                            onTap: () => _clearSearchBox(),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Icon(
                                Icons.cancel,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      RoundedButton(
                        iconSize: 28,
                        padding: const EdgeInsets.all(9),
                        onPressed: () => _pickBarCode(context),
                        icon: Icons.qr_code_scanner,
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withAlpha(60),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
