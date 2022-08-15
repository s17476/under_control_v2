part of 'checklist_bloc.dart';

abstract class ChecklistState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const ChecklistState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ChecklistEmptyState extends ChecklistState {}

class ChecklistLoadingState extends ChecklistState {}

class ChecklistErrorState extends ChecklistState {
  const ChecklistErrorState({
    super.message,
    super.error = true,
  });
}

class ChecklistLoadedState extends ChecklistState {
  final ChecklistsListModel allChecklists;
  ChecklistLoadedState({
    required this.allChecklists,
  }) : super(properties: [allChecklists]);
}
