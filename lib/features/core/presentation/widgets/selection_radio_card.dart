import 'package:flutter/material.dart';

class SelectionRadioCard<T> extends StatelessWidget {
  const SelectionRadioCard({
    Key? key,
    required this.onTap,
    required this.value,
    required this.groupValue,
    required this.title,
  }) : super(key: key);

  final void Function(T val) onTap;
  final T value;
  final T groupValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(value),
      child: Card(
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(child: Text(title)),
            Radio<T>(
              activeColor: Theme.of(context).primaryColor,
              value: value,
              groupValue: groupValue,
              onChanged: (val) => onTap(val as T),
            ),
          ],
        ),
      ),
    );
  }
}
