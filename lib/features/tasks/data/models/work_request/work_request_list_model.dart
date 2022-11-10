import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';

import '../../../domain/entities/work_request/work_requests_list.dart';
import 'work_request_model.dart';

class WorkRequestsListModel extends WorkRequestsList {
  const WorkRequestsListModel({required super.allWorkRequests});

  factory WorkRequestsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<WorkRequest> workRequestsList = [];
    workRequestsList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => WorkRequestModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.date.compareTo(b.date),
      );
    return WorkRequestsListModel(allWorkRequests: workRequestsList);
  }
}
