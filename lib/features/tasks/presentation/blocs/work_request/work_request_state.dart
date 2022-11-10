part of 'work_request_bloc.dart';

abstract class WorkRequestState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const WorkRequestState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkRequestEmptyState extends WorkRequestState {}

class WorkRequestLoadingState extends WorkRequestState {}

class WorkRequestErrorState extends WorkRequestState {
  const WorkRequestErrorState({
    super.message,
    super.error = true,
  });
}

class WorkRequestLoadedState extends WorkRequestState {
  final WorkRequestsListModel allWorkRequests;

  WorkRequestLoadedState({
    required this.allWorkRequests,
  }) : super(properties: [allWorkRequests]);

  WorkRequest? getWorkRequestById(String id) {
    final index =
        allWorkRequests.allWorkRequests.indexWhere((asset) => asset.id == id);
    if (index >= 0) {
      return allWorkRequests.allWorkRequests[index];
    }
    return null;
  }
}
