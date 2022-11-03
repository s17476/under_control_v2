import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_order.dart';

import '../../../domain/entities/work_order/work_orders_list.dart';
import 'work_order_model.dart';

class WorkOrdersListModel extends WorkOrdersList {
  const WorkOrdersListModel({required super.allWorkOrders});

  factory WorkOrdersListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<WorkOrder> workOrdersList = [];
    workOrdersList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => WorkOrderModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.date.compareTo(b.date),
      );
    return WorkOrdersListModel(allWorkOrders: workOrdersList);
  }
}
