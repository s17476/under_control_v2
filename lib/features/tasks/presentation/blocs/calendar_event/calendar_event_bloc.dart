import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task/calendar_task_bloc.dart';

import '../../../domain/entities/task/task.dart' as task;

part 'calendar_event_event.dart';
part 'calendar_event_state.dart';

@lazySingleton
class CalendarEventBloc extends Bloc<CalendarEventEvent, CalendarEventState> {
  final CalendarTaskBloc calendarTaskBloc;

  late StreamSubscription taskStreamSubscription;

  CalendarEventBloc(
    this.calendarTaskBloc,
  ) : super(CalendarEventEmpty()) {
    taskStreamSubscription = calendarTaskBloc.stream.listen((state) {
      if (state is CalendarTaskLoadedState) {
        add(UpdateEvents(events: Right(state.allTasks.allTasks)));
      }
    });

    on<UpdateEvents>((event, emit) {
      final Map<DateTime, List<Either<WorkRequest, task.Task>>> events = {};
      event.events.fold(
        (l) => null,
        (tasks) {
          for (var task in tasks) {
            final date = normalizeDate(task.executionDate);
            if (events.containsKey(date)) {
              events.update(date, (list) => list..add(right(task)));
            } else {
              events[date] = [right(task)];
            }
          }
        },
      );
      print(events);
    });
  }

  @override
  Future<void> close() {
    taskStreamSubscription.cancel();
    return super.close();
  }
}
