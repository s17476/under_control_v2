import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_event/calendar_event_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task/calendar_task_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final now = DateTime.now();
  late DateTime from;
  late DateTime to;

  @override
  void initState() {
    from = DateTime(now.year, now.month - 1);
    to = DateTime(now.year, now.month + 2);
    context.read<CalendarTaskBloc>().add(
          GetCalendarTasksStreamEvent(
            from: from,
            to: to,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('context.read<CalendarEventBloc>().state');
    print(context.read<CalendarEventBloc>().state);
    return TableCalendar(
      firstDay: DateTime(2022, 10),
      lastDay: DateTime(2023, 10).subtract(const Duration(days: 1)),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      // availableGestures: AvailableGestures.horizontalSwipe,
      locale: context.watch<LanguageCubit>().state.languageCode,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      // TODO - use page controller to fetch data from DB
      onCalendarCreated: (pageController) {
        // data format Map<DateTime, List<task>>
        // one month forward
        // one month back
        // get events for day in BLoC
      },
      weekNumbersVisible: true,
      calendarStyle: CalendarStyle(
        tableBorder: TableBorder(
          left: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.4),
          ),
        ),
      ),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }
}
