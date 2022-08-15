import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.fieldKey,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    required this.labelText,
    this.validator,
    this.onSaved,
    this.enabled = true,
    this.autofocus = false,
    this.initialValue,
    this.prefixIcon,
    this.scrollPadding = const EdgeInsets.all(20),
  }) : super(key: key);

  final String fieldKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool enabled;
  final bool autofocus;
  final String? initialValue;
  final Widget? prefixIcon;
  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      enabled: enabled,
      initialValue: initialValue,
      scrollPadding: scrollPadding,
      controller: controller,
      key: ValueKey(fieldKey),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
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
      onSaved: onSaved,
    );
  }
}
