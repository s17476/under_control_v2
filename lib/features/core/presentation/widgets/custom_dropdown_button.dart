import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    required this.initialValue,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
    required this.label,
  }) : super(key: key);

  final String initialValue;
  final String selectedValue;
  final String label;
  final List<DropdownMenuItem<String>> items;
  final Function(String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            value: initialValue,
            items: items,
            onChanged: (value) {
              if (value != selectedValue) {
                onSelected(value!);
              }
            },
          ),
        ),
        if (selectedValue.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}
