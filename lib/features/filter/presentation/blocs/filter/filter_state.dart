part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  final bool isAdmin;
  final String companyId;
  final List<Location> locations;
  final List<Group> groups;
  final List<Group> allPossibleGroups;

  const FilterState({
    this.isAdmin = false,
    this.companyId = '',
    this.locations = const [],
    this.groups = const [],
    this.allPossibleGroups = const [],
  });

  @override
  List<Object> get props {
    return [
      isAdmin,
      companyId,
      locations,
      groups,
      allPossibleGroups,
    ];
  }
}

class FilterEmptyState extends FilterState {}

class FilterErrorState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadedState extends FilterState {
  const FilterLoadedState({
    super.companyId,
    super.isAdmin,
    super.locations,
    super.groups,
    super.allPossibleGroups,
  });

  FilterLoadedState copyWith(
    String? companyId,
    List<Location>? locations,
    List<Group>? groups,
    List<Group>? allPossibleGroups,
  ) {
    return FilterLoadedState(
      companyId: companyId ?? this.companyId,
      isAdmin: isAdmin,
      locations: locations ?? this.locations,
      groups: groups ?? this.groups,
      allPossibleGroups: allPossibleGroups ?? this.allPossibleGroups,
    );
  }

  List<Location> get getAvailableLocations {
    List<Location> result = [];

    for (var group in groups) {
      final feature = group.features
          .firstWhere((ftr) => ftr.type == FeatureType.knowledgeBase);
      if (feature.read) {
        for (var location in locations) {
          if (group.locations.contains(location.id) &&
              !result.contains(location)) {
            result.add(location);
          }
        }
      }
    }
    return result;
  }
}
