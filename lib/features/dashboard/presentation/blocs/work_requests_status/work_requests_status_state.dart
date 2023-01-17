part of 'work_requests_status_bloc.dart';

abstract class WorkRequestsStatusState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const WorkRequestsStatusState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkRequestsStatusEmptyState extends WorkRequestsStatusState {}

class WorkRequestsStatusLoadingState extends WorkRequestsStatusState {}

class WorkRequestsStatusErrorState extends WorkRequestsStatusState {
  const WorkRequestsStatusErrorState({
    super.message,
    super.error = true,
  });
}

class WorkRequestsStatusLoadedState extends WorkRequestsStatusState {
  final WorkRequestsListModel awaiting;
  final WorkRequestsListModel converted;
  final WorkRequestsListModel cancelled;

  WorkRequestsStatusLoadedState({
    required this.awaiting,
    required this.converted,
    required this.cancelled,
  }) : super(properties: [awaiting, converted, cancelled]);

  WorkRequestsStatusLoadedState copyWith(
    WorkRequestsListModel? awaiting,
    WorkRequestsListModel? converted,
    WorkRequestsListModel? cancelled,
  ) =>
      WorkRequestsStatusLoadedState(
        awaiting: awaiting ?? this.awaiting,
        converted: converted ?? this.converted,
        cancelled: cancelled ?? this.cancelled,
      );
}
