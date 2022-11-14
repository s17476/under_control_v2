import 'package:flutter/material.dart';

class BackwardTextButton extends StatelessWidget {
  final Function function;
  final Function onHoldFunction;
  final IconData icon;
  final Color color;
  final String label;
  const BackwardTextButton({
    Key? key,
    required this.function,
    required this.onHoldFunction,
    required this.icon,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        function();
      },
      onLongPress: () {
        FocusScope.of(context).unfocus();
        onHoldFunction();
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
