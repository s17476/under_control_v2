import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.searchController,
    required this.onChanged,
    required this.onCancel,
  }) : super(key: key);

  final TextEditingController searchController;

  final VoidCallback onChanged;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: searchController,
      onChanged: (_) => onChanged(),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.search,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: InkWell(
          onTap: onCancel,
          child: Icon(
            Icons.cancel,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 22,
      ),
      cursorColor: Colors.grey.shade200,
    );
  }
}
