import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task/calendar_task_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/calendar_task_archive/calenddar_task_archive_bloc.dart';

import '../../../domain/entities/task/task.dart' as task;

part 'calendar_event_event.dart';
part 'calendar_event_state.dart';

@lazySingleton
class CalendarEventBloc extends Bloc<CalendarEventEvent, CalendarEventState> {
  final CalendarTaskBloc calendarTaskBloc;
  final CalendarTaskArchiveBloc calendarTaskArchiveBloc;

  late StreamSubscription taskStreamSubscription;
  late StreamSubscription taskArchiveStreamSubscription;

  CalendarEventBloc(
    this.calendarTaskBloc,
    this.calendarTaskArchiveBloc,
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

    on<UpdateEvents>((event, emit) {
      final Map<DateTime, List<Either<WorkRequest, task.Task>>> events = {};
      event.events.fold(
        // TODO add work requests
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
      final oldEvents = state.events;

      final doubleKeys =
          events.keys.where((key) => oldEvents.keys.contains(key));

      Map<DateTime, List<Either<WorkRequest, task.Task>>> combinedEvents = {}
        ..addAll(events)
        ..addAll(oldEvents);

      for (var key in doubleKeys) {
        final oldTasks = oldEvents[key]
            ?.map((e) => e.fold((_) => null, (r) => r))
            .where((e) => e != null)
            .toList();
        final newTasks = events[key]
            ?.map((e) => e.fold((_) => null, (r) => r))
            .where((e) => e != null)
            .toList();

        if (oldTasks != null && newTasks != null) {
          for (var task in oldTasks) {
            if (!newTasks.contains(task)) {
              newTasks.add(task);
            }
          }
        }

        combinedEvents[key] =
            newTasks!.map((e) => right<WorkRequest, task.Task>(e!)).toList();

        combinedEvents.update(
          key,
          (value) => value
            ..addAll(
              events[key]!.where((element) => element.isLeft()).toList(),
            ),
        );
      }

      emit(CalendarEventLoaded(events: combinedEvents));
    });
  }

  @override
  Future<void> close() {
    taskStreamSubscription.cancel();
    taskArchiveStreamSubscription.cancel();
    return super.close();
  }
}
