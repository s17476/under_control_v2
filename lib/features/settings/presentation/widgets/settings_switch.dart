import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? description;
  final bool value;
  final EdgeInsetsGeometry? padding;
  final Function(bool) onChanged;

  const SettingsSwitch({
    Key? key,
    this.icon,
    required this.title,
    this.description,
    required this.value,
    this.padding,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
      child: Column(
        children: [
          Row(
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(
                  width: 8,
                ),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: Theme.of(context).primaryColor.withAlpha(50),
              ),
            ],
          ),
          if (description != null)
            Text(
              description!,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
        ],
      ),
    );
  }
}
