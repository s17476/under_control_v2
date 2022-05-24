import 'package:flutter/material.dart';

class BackwardElevatedButton extends StatelessWidget {
  final Function function;
  final IconData icon;
  final Color color;
  final String child;
  const BackwardElevatedButton({
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 4),
          Text(
            child,
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}
