import 'package:flutter/material.dart';

class BackwardTextButton extends StatelessWidget {
  final Function function;
  final IconData icon;
  final Color color;
  final String label;
  const BackwardTextButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.label,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        function();
      },
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
