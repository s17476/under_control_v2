import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.fieldKey,
    required this.controller,
    required this.keyboardtype,
    required this.textCapitalization,
    required this.labelText,
    required this.validator,
  }) : super(key: key);

  final String fieldKey;
  final TextEditingController controller;
  final TextInputType keyboardtype;
  final TextCapitalization textCapitalization;
  final String labelText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 300),
        controller: controller,
        key: ValueKey(fieldKey),
        keyboardType: keyboardtype,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
          ),
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
        validator: validator,
      ),
    );
  }
}