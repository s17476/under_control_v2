part of 'checklist_management_bloc.dart';

abstract class ChecklistManagementEvent extends Equatable {
  final Checklist checklist;
  const ChecklistManagementEvent({
    required this.checklist,
  });

  @override
  List<Object> get props => [checklist];
}

class AddChecklistEvent extends ChecklistManagementEvent {
  const AddChecklistEvent({required super.checklist});
}

class UpdateChecklistEvent extends ChecklistManagementEvent {
  const UpdateChecklistEvent({required super.checklist});
}

class DeleteChecklistEvent extends ChecklistManagementEvent {
  const DeleteChecklistEvent({required super.checklist});
}
