import 'package:equatable/equatable.dart';

class Locations extends Equatable {
  final Stream allLocations;

  const Locations({
    required this.allLocations,
  });

  @override
  List<Object> get props => [allLocations];

  @override
  String toString() => 'Locations(allLocations: $allLocations)';
}
