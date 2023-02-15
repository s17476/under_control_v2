import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CalendarButton extends HookWidget {
  const CalendarButton({
    Key? key,
    required this.isCalendarVisible,
    required this.toggleCalendarButton,
  }) : super(key: key);

  final bool isCalendarVisible;
  final VoidCallback toggleCalendarButton;

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    toggleState.value = isCalendarVisible;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: InkResponse(
        onTap: () {
          toggleCalendarButton();
          toggleState.value = !toggleState.value;
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? Icon(
                  key: const ValueKey('list'),
                  Icons.calendar_month,
                  color: Theme.of(context).primaryColor,
                )
              : Icon(
                  key: const ValueKey('calendar'),
                  Icons.calendar_month,
                  color: Theme.of(context).iconTheme.color,
                ),
        ),
      ),
    );
  }
}
