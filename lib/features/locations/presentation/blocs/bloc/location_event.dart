part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  final List properties;

  const LocationEvent({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class AddLocationEvent extends LocationEvent {
  final Location location;
  AddLocationEvent({
    required this.location,
  }) : super(properties: [location]);
}

class UpdateLocationEvent extends LocationEvent {
  final Location location;
  UpdateLocationEvent({
    required this.location,
  }) : super(properties: [location]);
}

class SelectLocationEvent extends LocationEvent {
  final Location location;
  SelectLocationEvent({
    required this.location,
  }) : super(properties: [location]);
}

class DeleteLocationEvent extends LocationEvent {
  final Location location;
  DeleteLocationEvent({
    required this.location,
  }) : super(properties: [location]);
}

class FetchAllLocationsEvent extends LocationEvent {}

class UpdateLocationsListEvent extends LocationEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateLocationsListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
