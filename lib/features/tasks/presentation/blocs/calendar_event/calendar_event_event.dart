part of 'calendar_event_bloc.dart';

abstract class CalendarEventEvent extends Equatable {
  final List properties;
  const CalendarEventEvent({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class UpdateEvents extends CalendarEventEvent {
  final Either<List<WorkRequest>, List<task.Task>> events;
  UpdateEvents({
    required this.events,
  }) : super(properties: [events]);
}
