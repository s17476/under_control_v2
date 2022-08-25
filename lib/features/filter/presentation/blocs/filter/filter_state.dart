part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  final String companyId;
  final List<Location> locations;
  final List<Location> availableLocations;
  final List<Group> groups;
  final List<Group> allPossibleGroups;

  const FilterState({
    this.availableLocations = const [],
    this.companyId = '',
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
    super.companyId,
    super.locations,
    super.availableLocations,
    super.groups,
    super.allPossibleGroups,
  });

  FilterLoadedState copyWith(
    String? companyId,
    List<Location>? locations,
    List<Location>? availableLocations,
    List<Group>? groups,
    List<Group>? allPossibleGroups,
  ) {
    return FilterLoadedState(
      companyId: companyId ?? this.companyId,
      locations: locations ?? this.locations,
      availableLocations: availableLocations ?? this.availableLocations,
      groups: groups ?? this.groups,
      allPossibleGroups: allPossibleGroups ?? this.allPossibleGroups,
    );
  }
}
