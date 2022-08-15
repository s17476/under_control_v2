part of 'checklist_bloc.dart';

abstract class ChecklistEvent extends Equatable {
  final List properties;

  const ChecklistEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetAllChecklistsEvent extends ChecklistEvent {}
