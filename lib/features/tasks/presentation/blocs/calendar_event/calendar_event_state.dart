part of 'calendar_event_bloc.dart';

abstract class CalendarEventState extends Equatable {
  final Map<DateTime, List<Either<WorkRequest, Task>>> events;
  const CalendarEventState({this.events = const {}});

  @override
  List<Object> get props => [events];
}

class CalendarEventEmpty extends CalendarEventState {}

class CalendarEventError extends CalendarEventState {}

class CalendarEventLoading extends CalendarEventState {}

class CalendarEventLoaded extends CalendarEventState {
  const CalendarEventLoaded({required super.events});
}
