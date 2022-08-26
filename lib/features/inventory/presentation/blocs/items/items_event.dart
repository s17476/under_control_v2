part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  final List properties;

  const ItemsEvent({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class GetItemsEvent extends ItemsEvent {
  final List<Group> groups;
  final String companyId;
  GetItemsEvent({
    required this.groups,
    required this.companyId,
  }) : super(properties: [groups, companyId]);
}

class UpdateItemsListEvent extends ItemsEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateItemsListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
