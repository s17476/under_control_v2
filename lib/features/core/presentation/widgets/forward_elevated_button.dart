import 'package:flutter/material.dart';

class ForwardElevatedButton extends StatelessWidget {
  final Function function;
  final IconData icon;
  final Color color;
  final String child;
  const ForwardElevatedButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.child,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        function();
      },
      style: ElevatedButton.styleFrom(primary: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            child,
          ),
          const SizedBox(width: 4),
          Icon(icon),
        ],
      ),
    );
  }
}
