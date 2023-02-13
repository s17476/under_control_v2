part of 'work_request_archive_bloc.dart';

abstract class WorkRequestArchiveState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const WorkRequestArchiveState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkRequestArchiveEmptyState extends WorkRequestArchiveState {}

class WorkRequestArchiveLoadingState extends WorkRequestArchiveState {}

class WorkRequestArchiveErrorState extends WorkRequestArchiveState {
  const WorkRequestArchiveErrorState({
    super.message,
    super.error = true,
  });
}

class WorkRequestArchiveLoadedState extends WorkRequestArchiveState {
  final WorkRequestsListModel allWorkRequests;
  final bool isAllWorkRequests;

  WorkRequestArchiveLoadedState({
    required this.allWorkRequests,
    required this.isAllWorkRequests,
  }) : super(properties: [allWorkRequests, isAllWorkRequests]);

  WorkRequest? getWorkRequestById(String id) {
    final index =
        allWorkRequests.allWorkRequests.indexWhere((asset) => asset.id == id);
    if (index >= 0) {
      return allWorkRequests.allWorkRequests[index];
    }
    return null;
  }
}
