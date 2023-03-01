import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../settings/presentation/blocs/language/language_cubit.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../blocs/calendar_event/calendar_event_bloc.dart';
import '../blocs/calendar_task/calendar_task_bloc.dart';
import '../blocs/calendar_task_archive/calenddar_task_archive_bloc.dart';
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
  bool isLoadingEvents = true;

  final now = DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime from;
  late DateTime to;

  void updateTasks() {
    setState(() {
      isLoadingEvents = true;
    });
    context.read<CalendarTaskBloc>().add(
          GetCalendarTasksStreamEvent(
            from: from,
            to: to,
          ),
        );
  }

  void updateArchiveTasks() {
    setState(() {
      isLoadingEvents = true;
    });
    context.read<CalendarTaskArchiveBloc>().add(
          GetCalendarTasksArchiveStreamEvent(
            from: from,
            to: to,
          ),
        );
  }

  @override
  void initState() {
    final taskState = context.read<CalendarTaskBloc>().state;
    if (taskState is CalendarTaskLoadedState) {
      to = taskState.to;
    } else {
      to = DateTime(now.year, now.month + 2);
    }
    final taskArchiveState = context.read<CalendarTaskArchiveBloc>().state;
    if (taskArchiveState is CalendarTaskArchiveLoadedState) {
      from = taskArchiveState.from;
    } else {
      from = DateTime(now.year, now.month - 1);
    }
    final calendarState = context.read<CalendarEventBloc>().state;
    if (calendarState is CalendarEventEmpty) {
      updateTasks();
      updateArchiveTasks();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final calendarState = context.watch<CalendarEventBloc>().state;
    if (calendarState is CalendarEventLoading) {}
    if (calendarState is CalendarEventLoaded) {
      _events = calendarState.events;
      if (_selectedDay == null) {
        _selectedEvents = _events![normalizeDate(DateTime.now())] ?? [];
      }
      isLoadingEvents = false;
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
        Stack(
          alignment: Alignment.center,
          children: [
            TableCalendar(
              firstDay: DateTime(2022, 1),
              lastDay: DateTime(2030, 1).subtract(const Duration(days: 1)),
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
              onCalendarCreated: (pageController) {
                pageController.addListener(
                  () {
                    final pageDifference =
                        pageController.initialPage - (pageController.page ?? 0);

                    if (pageDifference % 1 == 0) {
                      // going back
                      if (pageDifference > 0) {
                        final fromDifference = from.difference(
                          DateTime(
                            now.year,
                            now.month - pageDifference.toInt(),
                          ),
                        );
                        if (fromDifference.inDays >= 0) {
                          from = DateTime(
                            DateTime.now().year,
                            DateTime.now().month - pageDifference.toInt() - 1,
                          );
                          updateTasks();
                          updateArchiveTasks();
                        }
                      }
                      // going forward
                      if (pageDifference < 0) {
                        final toDifference = DateTime(
                          now.year,
                          now.month + 1 - pageDifference.toInt(),
                        ).difference(to);
                        if (toDifference.inDays >= 0) {
                          to = DateTime(
                            DateTime.now().year,
                            DateTime.now().month - pageDifference.toInt() + 2,
                          );
                          updateTasks();
                        }
                      }
                    }
                  },
                );
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
                    backgroundColor:
                        Theme.of(context).primaryColor.withAlpha(60),
                    child: Text(
                      day.day.toString(),
                    ),
                  ));
                },
                // selected day marker style
                selectedBuilder: (context, day, focusedDay) {
                  return Center(
                      child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor.withAlpha(140),
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
                                  : Theme.of(context)
                                      .primaryColor
                                      .withAlpha(100),
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
                                color:
                                    day == _selectedDay ? Colors.black : null,
                              ),
                            ),
                          ),
                        )
                      : null;
                },
              ),
            ),
            if (isLoadingEvents) const LoadingWidget(showLogo: false),
          ],
        ),
        EventsList(events: _selectedEvents),
      ],
    );
  }
}
