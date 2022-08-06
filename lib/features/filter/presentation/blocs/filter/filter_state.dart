part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  final List<Location> locations;
  final List<Group> groups;
  final List<Group> allPossibleGroups;

  const FilterState({
    this.locations = const [],
    this.groups = const [],
    this.allPossibleGroups = const [],
  });

  @override
  List<Object> get props => [
        locations,
        groups,
        allPossibleGroups,
      ];
}

class FilterEmptyState extends FilterState {}

class FilterErrorState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadedState extends FilterState {
  const FilterLoadedState({
    super.locations,
    super.groups,
    super.allPossibleGroups,
  });

  FilterLoadedState copyWith(
    List<Location>? locations,
    List<Group>? groups,
    List<Group>? allPossibleGroups,
  ) {
    return FilterLoadedState(
      locations: locations ?? this.locations,
      groups: groups ?? this.groups,
      allPossibleGroups: allPossibleGroups ?? this.allPossibleGroups,
    );
  }
}
