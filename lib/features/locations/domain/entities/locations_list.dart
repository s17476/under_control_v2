import 'package:equatable/equatable.dart';

import 'location.dart';

class LocationsList extends Equatable {
  final List<Location> allLocations;

  const LocationsList({
    required this.allLocations,
  });

  @override
  List<Object> get props => [allLocations];

  @override
  String toString() => 'LocationsList(allLocations: $allLocations)';
}
