import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:under_control_v2/features/core/presentation/pages/loading_page.dart';
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_event/calendar_event_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task/calendar_task_bloc.dart';

import '../../domain/entities/task/task.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../widgets/calendar/events_list.dart';

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
  Map<DateTime, List<dartz.Either<WorkRequest, Task>>>? _events;
  List<dartz.Either<WorkRequest, Task>> _selectedEvents = [];

  final now = DateTime.now();
  late DateTime from;
  late DateTime to;

  @override
  void initState() {
    from = DateTime(now.year, now.month - 1);
    to = DateTime(now.year, now.month + 2);
    final calendarState = context.read<CalendarEventBloc>().state;
    if (calendarState is CalendarEventEmpty) {
      context.read<CalendarTaskBloc>().add(
            GetCalendarTasksStreamEvent(
              from: from,
              to: to,
            ),
          );
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final calendarState = context.watch<CalendarEventBloc>().state;
    if (calendarState is CalendarEventLoaded) {
      _events = calendarState.events;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_events == null) {
      return const LoadingPage();
    }
    return ListView(
      children: [
        TableCalendar(
          firstDay: DateTime(2022, 10),
          lastDay: DateTime(2023, 10).subtract(const Duration(days: 1)),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          availableGestures: AvailableGestures.horizontalSwipe,
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
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _events![selectedDay] ?? [];
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
          eventLoader: (day) => _events?[day] ?? [],
          calendarBuilders: CalendarBuilders(
            // today marker style
            todayBuilder: (context, day, focusedDay) {
              return Center(
                  child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withAlpha(60),
                child: Text(
                  day.day.toString(),
                ),
              ));
            },
            // selected day marker style
            selectedBuilder: (context, day, focusedDay) {
              return Center(
                  child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withAlpha(140),
                child: Text(
                  day.day.toString(),
                ),
              ));
            },
            // badge with events count for date
            markerBuilder: (context, day, events) {
              return events.isNotEmpty
                  ? Positioned(
                      right: 3,
                      top: 3,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: day == _selectedDay
                              ? Colors.grey.shade300
                              : Theme.of(context).primaryColor.withAlpha(100),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          events.length.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: day == _selectedDay ? Colors.black : null,
                          ),
                        ),
                      ),
                    )
                  : null;
            },
          ),
        ),
        EventsList(events: _selectedEvents),
      ],
    );
  }
}
