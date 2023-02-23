part of 'calenddar_task_archive_bloc.dart';

abstract class CalendarTaskArchiveEvent extends Equatable {
  final List properties;

  const CalendarTaskArchiveEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetCalendarTasksArchiveStreamEvent extends CalendarTaskArchiveEvent {
  final DateTime from;
  final DateTime to;

  GetCalendarTasksArchiveStreamEvent({
    required this.from,
    required this.to,
  }) : super(properties: [from, to]);
}

class ResetEvent extends CalendarTaskArchiveEvent {}

class UpdateCalendarTasksArchiveListEvent extends CalendarTaskArchiveEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;
  final DateTime from;
  final DateTime to;

  UpdateCalendarTasksArchiveListEvent({
    required this.snapshot,
    required this.locations,
    required this.from,
    required this.to,
  }) : super(properties: [snapshot, locations, from, to]);
}
