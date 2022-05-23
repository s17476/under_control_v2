import 'package:flutter/material.dart';

class BackwardElevatedButton extends StatelessWidget {
  final Function function;
  final IconData icon;
  final Color? color;
  final String child;
  const BackwardElevatedButton({
    Key? key,
    required this.icon,
    this.color,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            child,
          ),
          const SizedBox(width: 8),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}
