import 'package:equatable/equatable.dart';

import 'work_order.dart';

class WorkOrdersList extends Equatable {
  final List<WorkOrder> allWorkOrders;

  const WorkOrdersList({
    required this.allWorkOrders,
  });

  @override
  List<Object> get props => [allWorkOrders];

  @override
  String toString() => 'WorkOrdersList(allWorkOrders: $allWorkOrders)';
}
