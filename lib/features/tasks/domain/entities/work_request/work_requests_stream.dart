import 'package:equatable/equatable.dart';

class WorkRequestsStream extends Equatable {
  final Stream allWorkRequests;

  const WorkRequestsStream({
    required this.allWorkRequests,
  });

  @override
  List<Object> get props => [allWorkRequests];

  @override
  String toString() => 'WorkRequestsStream(allWorkRequests: $allWorkRequests)';
}
