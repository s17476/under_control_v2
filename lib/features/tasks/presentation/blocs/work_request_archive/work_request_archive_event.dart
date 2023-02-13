part of 'work_request_archive_bloc.dart';

abstract class WorkRequestArchiveEvent extends Equatable {
  final List properties;

  const WorkRequestArchiveEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetWorkRequestsArchiveStreamEvent extends WorkRequestArchiveEvent {
  final bool isAllWorkRequest;
  GetWorkRequestsArchiveStreamEvent({
    required this.isAllWorkRequest,
  }) : super(properties: [isAllWorkRequest]);
}

class ResetEvent extends WorkRequestArchiveEvent {}

class UpdateWorkRequestsArchiveListEvent extends WorkRequestArchiveEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;
  final bool isAllWorkRequests;

  UpdateWorkRequestsArchiveListEvent({
    required this.snapshot,
    required this.locations,
    required this.isAllWorkRequests,
  }) : super(properties: [snapshot, locations, isAllWorkRequests]);
}
