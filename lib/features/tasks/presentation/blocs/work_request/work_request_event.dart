part of 'work_request_bloc.dart';

abstract class WorkRequestEvent extends Equatable {
  final List properties;

  const WorkRequestEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetWorkRequestsStreamEvent extends WorkRequestEvent {}

class ResetEvent extends WorkRequestEvent {}

class UpdateWorkRequestsListEvent extends WorkRequestEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateWorkRequestsListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
