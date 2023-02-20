part of 'calendar_task_bloc.dart';

abstract class CalendarTaskEvent extends Equatable {
  final List properties;

  const CalendarTaskEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetCalendarTasksStreamEvent extends CalendarTaskEvent {
  final DateTime from;
  final DateTime to;

  GetCalendarTasksStreamEvent({
    required this.from,
    required this.to,
  }) : super(properties: [from, to]);
}

class ResetEvent extends CalendarTaskEvent {}

class UpdateCalendarTasksListEvent extends CalendarTaskEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;
  final DateTime from;
  final DateTime to;

  UpdateCalendarTasksListEvent({
    required this.snapshot,
    required this.locations,
    required this.from,
    required this.to,
  }) : super(properties: [snapshot, locations, from, to]);
}
