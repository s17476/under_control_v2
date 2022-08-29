part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  final List properties;

  const ItemsEvent({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class GetItemsEvent extends ItemsEvent {
  final List<Group> selectedGroups;
  final List<Location> selectedLocations;
  final String companyId;
  GetItemsEvent({
    required this.selectedGroups,
    required this.selectedLocations,
    required this.companyId,
  }) : super(properties: [selectedLocations, selectedGroups, companyId]);
}

class UpdateItemsListEvent extends ItemsEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateItemsListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
