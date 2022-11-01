import 'package:equatable/equatable.dart';

class WorkOrdersStream extends Equatable {
  final Stream allWorkOrders;

  const WorkOrdersStream({
    required this.allWorkOrders,
  });

  @override
  List<Object> get props => [allWorkOrders];

  @override
  String toString() => 'WorkOrdersStream(allWorkOrders: $allWorkOrders)';
}
