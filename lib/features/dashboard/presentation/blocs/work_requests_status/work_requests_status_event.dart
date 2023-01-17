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

class UpdateAwaitingStatusEvent extends WorkRequestsStatusEvent {
  final int awaiting;

  UpdateAwaitingStatusEvent({
    required this.awaiting,
  }) : super(properties: [awaiting]);
}

class UpdateConvertedStatusEvent extends WorkRequestsStatusEvent {
  final int converted;

  UpdateConvertedStatusEvent({
    required this.converted,
  }) : super(properties: [converted]);
}

class UpdateCancelledStatusEvent extends WorkRequestsStatusEvent {
  final int cancelled;

  UpdateCancelledStatusEvent({
    required this.cancelled,
  }) : super(properties: [cancelled]);
}
