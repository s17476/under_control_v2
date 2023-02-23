part of 'calenddar_task_archive_bloc.dart';

abstract class CalendarTaskArchiveState extends Equatable {
  final List properties;

  const CalendarTaskArchiveState({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class CalendarTaskArchiveEmptyState extends CalendarTaskArchiveState {}

class CalendarTaskArchiveLoadingState extends CalendarTaskArchiveState {}

class CalendarTaskArchiveErrorState extends CalendarTaskArchiveState {}

class CalendarTaskArchiveLoadedState extends CalendarTaskArchiveState {
  final TasksListModel allTasks;
  final DateTime from;
  final DateTime to;

  CalendarTaskArchiveLoadedState({
    required this.allTasks,
    required this.from,
    required this.to,
  }) : super(properties: [allTasks, from, to]);

  Task? getTaskById(String id) {
    final index = allTasks.allTasks.indexWhere((asset) => asset.id == id);
    if (index >= 0) {
      return allTasks.allTasks[index];
    }
    return null;
  }
}
