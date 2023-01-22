part of 'work_requests_status_bloc.dart';

abstract class WorkRequestsStatusEvent extends Equatable {
  final List properties;

  const WorkRequestsStatusEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetWorkRequestsStatusEvent extends WorkRequestsStatusEvent {}

class ResetEvent extends WorkRequestsStatusEvent {}

class UpdateAwaitingStatusEvent extends WorkRequestsStatusEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateAwaitingStatusEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}

class UpdateConvertedStatusEvent extends WorkRequestsStatusEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateConvertedStatusEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}

class UpdateCancelledStatusEvent extends WorkRequestsStatusEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateCancelledStatusEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
