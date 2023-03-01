import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../domain/entities/task/task.dart' as task;
import '../../../domain/entities/work_request/work_request.dart';
import '../calendar_task/calendar_task_bloc.dart';
import '../calendar_task_archive/calenddar_task_archive_bloc.dart';

part 'calendar_event_event.dart';
part 'calendar_event_state.dart';

@lazySingleton
class CalendarEventBloc extends Bloc<CalendarEventEvent, CalendarEventState> {
  final CalendarTaskBloc calendarTaskBloc;
  final CalendarTaskArchiveBloc calendarTaskArchiveBloc;
  final FilterBloc filterBloc;

  late StreamSubscription taskStreamSubscription;
  late StreamSubscription taskArchiveStreamSubscription;

  CalendarEventBloc(
    this.calendarTaskBloc,
    this.calendarTaskArchiveBloc,
    this.filterBloc,
  ) : super(CalendarEventEmpty()) {
    // tasks
    taskStreamSubscription = calendarTaskBloc.stream.listen((state) {
      if (state is CalendarTaskLoadedState) {
        add(UpdateEvents(events: Right(state.allTasks.allTasks)));
      }
    });
    // tasks archive
    taskArchiveStreamSubscription =
        calendarTaskArchiveBloc.stream.listen((state) {
      if (state is CalendarTaskArchiveLoadedState) {
        add(UpdateEvents(events: Right(state.allTasks.allTasks)));
      }
    });

    on<UpdateEvents>(
      (event, emit) {
        emit(CalendarEventLoading());
        final Map<DateTime, List<Either<WorkRequest, task.Task>>> events = {};
        final tasksState = calendarTaskBloc.state;
        if (tasksState is CalendarTaskLoadedState) {
          for (var task in tasksState.allTasks.allTasks) {
            final date = normalizeDate(task.executionDate);
            if (events.containsKey(date)) {
              events.update(date, (list) => list..add(right(task)));
            } else {
              events[date] = [right(task)];
            }
          }
        }
        final tasksArchiveState = calendarTaskArchiveBloc.state;
        if (tasksArchiveState is CalendarTaskArchiveLoadedState) {
          for (var task in tasksArchiveState.allTasks.allTasks) {
            final date = normalizeDate(task.executionDate);
            if (events.containsKey(date)) {
              events.update(date, (list) => list..add(right(task)));
            } else {
              events[date] = [right(task)];
            }
          }
        }
        emit(CalendarEventLoaded(events: events));
      },
    );
  }

  @override
  Future<void> close() {
    taskStreamSubscription.cancel();
    taskArchiveStreamSubscription.cancel();
    return super.close();
  }
}
