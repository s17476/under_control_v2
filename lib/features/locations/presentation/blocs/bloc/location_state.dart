part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const LocationState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class LocationEmptyState extends LocationState {
  const LocationEmptyState();
}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final List<Location> selectedLocations;
  final LocationsList allLocations;
  final List<String> context;
  final List<String> children;

  List<Location> get allSelectedLocations {
    final List<Location> selectedLocations = [...this.selectedLocations];
    for (var locId in children) {
      selectedLocations.add(
        allLocations.allLocations.firstWhere((e) => e.id == locId),
      );
    }
    return selectedLocations;
  }

  LocationLoadedState({
    this.selectedLocations = const [],
    required this.allLocations,
    required this.context,
    required this.children,
    super.error = false,
    super.message = '',
  }) : super(properties: [
          selectedLocations,
          allLocations,
          context,
          children,
        ]);

  LocationLoadedState copyWith({
    List<Location>? selectedLocations,
    LocationsList? allLocations,
    List<String>? context,
    List<String>? children,
    String? message,
    bool? error,
  }) {
    return LocationLoadedState(
      selectedLocations: selectedLocations ?? this.selectedLocations,
      allLocations: allLocations ?? this.allLocations,
      context: context ?? this.context,
      children: children ?? this.children,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  Location? getLocationById(String id) {
    final index = allLocations.allLocations.indexWhere((loc) => loc.id == id);
    if (index >= 0) {
      return allLocations.allLocations[index];
    }
    return null;
  }
}

class LocationErrorState extends LocationState {
  const LocationErrorState({
    super.message,
    super.error = true,
  });
}
