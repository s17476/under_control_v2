part of 'work_request_archive_bloc.dart';

abstract class WorkRequestArchiveEvent extends Equatable {
  final List properties;

  const WorkRequestArchiveEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetWorkRequestsArchiveStreamEvent extends WorkRequestArchiveEvent {}

class ResetEvent extends WorkRequestArchiveEvent {}

class UpdateWorkRequestsArchiveListEvent extends WorkRequestArchiveEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateWorkRequestsArchiveListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
