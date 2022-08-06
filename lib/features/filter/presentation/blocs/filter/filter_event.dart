part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  final List properties;
  const FilterEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class UpdateLocationsEvent extends FilterEvent {
  final List<Location> locations;
  UpdateLocationsEvent({
    required this.locations,
  }) : super(properties: [
          locations,
        ]);
}

class UpdateGroupsEvent extends FilterEvent {
  final List<Group> groups;
  UpdateGroupsEvent({
    required this.groups,
  }) : super(properties: [groups]);
}
