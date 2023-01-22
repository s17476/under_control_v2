part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  final List properties;

  const GroupEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class AddGroupEvent extends GroupEvent {
  final Group group;
  AddGroupEvent({
    required this.group,
  }) : super(properties: [group]);
}

class UpdateGroupEvent extends GroupEvent {
  final Group group;
  UpdateGroupEvent({
    required this.group,
  }) : super(properties: [group]);
}

class SelectGroupEvent extends GroupEvent {
  final Group group;
  SelectGroupEvent({
    required this.group,
  }) : super(properties: [group]);
}

class UnselectGroupEvent extends GroupEvent {
  final Group group;
  UnselectGroupEvent({
    required this.group,
  }) : super(properties: [group]);
}

class DeleteGroupEvent extends GroupEvent {
  final Group group;
  DeleteGroupEvent({
    required this.group,
  }) : super(properties: [group]);
}

class FetchAllGroupsEvent extends GroupEvent {}

class ResetEvent extends GroupEvent {}

class UpdateGroupsListEvent extends GroupEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateGroupsListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
