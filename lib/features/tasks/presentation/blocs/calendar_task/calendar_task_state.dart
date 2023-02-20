part of 'calendar_task_bloc.dart';

abstract class CalendarTaskState extends Equatable {
  final List properties;

  const CalendarTaskState({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class CalendarTaskEmptyState extends CalendarTaskState {}

class CalendarTaskLoadingState extends CalendarTaskState {}

class CalendarTaskErrorState extends CalendarTaskState {}

class CalendarTaskLoadedState extends CalendarTaskState {
  final TasksListModel allTasks;
  final DateTime from;
  final DateTime to;

  CalendarTaskLoadedState({
    required this.allTasks,
    required this.from,
    required this.to,
  }) : super(properties: [allTasks, from, to]);

  Task? getTaskById(String id) {
    final index = allTasks.allTasks.indexWhere((task) => task.id == id);
    if (index >= 0) {
      return allTasks.allTasks[index];
    }
    return null;
  }
}
