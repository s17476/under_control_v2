part of 'work_order_archive_bloc.dart';

abstract class WorkOrderArchiveEvent extends Equatable {
  final List properties;

  const WorkOrderArchiveEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetWorkOrdersArchiveStreamEvent extends WorkOrderArchiveEvent {}

class UpdateWorkOrdersArchiveListEvent extends WorkOrderArchiveEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateWorkOrdersArchiveListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
