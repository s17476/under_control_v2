import 'package:equatable/equatable.dart';

import 'work_request.dart';

class WorkRequestsList extends Equatable {
  final List<WorkRequest> allWorkRequests;

  const WorkRequestsList({
    required this.allWorkRequests,
  });

  @override
  List<Object> get props => [allWorkRequests];

  @override
  String toString() => 'WorkRequestsList(allWorkRequests: $allWorkRequests)';
}
