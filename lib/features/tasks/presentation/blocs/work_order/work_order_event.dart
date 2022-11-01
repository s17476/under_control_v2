part of 'work_order_bloc.dart';

abstract class WorkOrderEvent extends Equatable {
  final List properties;

  const WorkOrderEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetWorkOrdersStreamEvent extends WorkOrderEvent {}

class UpdateWorkOrdersListEvent extends WorkOrderEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateWorkOrdersListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
